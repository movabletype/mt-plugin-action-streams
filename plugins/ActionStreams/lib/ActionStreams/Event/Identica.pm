############################################################################
# Copyright © 2010 Six Apart Ltd.
# This program is free software: you can redistribute it and/or modify it
# under the terms of version 2 of the GNU General Public License as published
# by the Free Software Foundation, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
# version 2 for more details. You should have received a copy of the GNU
# General Public License version 2 along with this program. If not, see
# <http://www.gnu.org/licenses/>.

package ActionStreams::Event::Identica;

use strict;
use base qw( ActionStreams::Event ActionStreams::Event::Twitter );

use MT::Util qw( encode_url );

__PACKAGE__->install_properties({
    class_type => 'identica_statuses',
});

sub search_link_for_tag {
    my $self = shift;
    my ($tag) = @_;
    my $enc_tag = encode_url($tag);
    return qq{<a href="http://identi.ca/tag/$enc_tag">$tag</a>};
}

sub encode_field_for_html {
    return shift->encode_and_autolink_title_field(@_);
}

1;
