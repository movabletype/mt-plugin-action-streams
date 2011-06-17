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

use MT::Author;

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

MT::Author->install_meta({
    columns => [
        'other_profiles',
    ],
});

sub MT::Author::other_profiles {
    my $user = shift;
    my( $type ) = @_;
    my $profiles = $user->meta( 'other_profiles' );
    require Storable;
    $profiles = Storable::thaw($profiles) if !ref $profiles;
    $profiles ||= [];
    return $type ?
        [ grep { $_->{type} eq $type } @$profiles ] :
        $profiles;
}

sub MT::Author::add_profile {
    my $user = shift;
    my( $profile ) = @_;
    my $profiles = $user->other_profiles;
    push @$profiles, $profile;
    $user->meta( other_profiles => $profiles );
    $user->save;
}

sub MT::Author::remove_profile {
    my $user = shift;
    my( $type, $ident ) = @_;
    my $profiles = [ grep {
        $_->{type} ne $type || $_->{ident} ne $ident
    } @{ $user->other_profiles } ];
    $user->meta( other_profiles => $profiles );
    $user->save;
}

1;
