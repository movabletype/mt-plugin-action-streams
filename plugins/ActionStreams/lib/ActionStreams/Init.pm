############################################################################
# Copyright © 2011 Six Apart Ltd.
# This program is free software: you can redistribute it and/or modify it
# under the terms of version 2 of the GNU General Public License as published
# by the Free Software Foundation, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
# version 2 for more details. You should have received a copy of the GNU
# General Public License version 2 along with this program. If not, see
# <http://www.gnu.org/licenses/>.

package ActionStreams::Init;

use strict;

our @ISA = qw{Exporter};
our @EXPORT = qw{add_author_profile remove_author_profile get_author_profiles};

sub init_app { 1 }

## REMOVE ME ASAP
sub hide_ts {
    my ( $cb, $app ) = @_;
    my $mode = $app->mode;
    my $type = $app->param('_type');
    if ( MT->VERSION >= 5
        && ( $mode eq 'list_theme'
          || ( $mode eq 'view' && $type eq 'blog' ))) {
        my $component = MT->component('actionstreams');
        my $registry = $component->registry;
        delete $registry->{template_sets}{streams};
    }
    1;
}

use MT::Author;
MT::Author->install_meta({
    columns => [
        'other_profiles',
    ],
});

sub add_author_profile {
    my( $user, $profile ) = @_;
    my $profiles = get_author_profiles($user);
    push @$profiles, $profile;
    $user->meta( other_profiles => $profiles );
    $user->save;
}

sub remove_author_profile {
    my( $user, $type, $ident ) = @_;
    my $profiles = [ grep {
        $_->{type} ne $type || $_->{ident} ne $ident
    } @{ get_author_profiles($user) } ];
    $user->meta( other_profiles => $profiles );
    $user->save;
}

sub get_author_profiles {
    my( $user, $type ) = @_;
    my $profiles = $user->meta( 'other_profiles' );
    require Storable;
    $profiles = Storable::thaw($profiles) if !ref $profiles;
    $profiles ||= [];
    return $type ?
        [ grep { $_->{type} eq $type } @$profiles ] :
        $profiles;
}

1;
