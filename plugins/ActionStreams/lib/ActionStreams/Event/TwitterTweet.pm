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

package ActionStreams::Event::TwitterTweet;

use strict;
use base qw( ActionStreams::Event ActionStreams::Event::Twitter );

__PACKAGE__->install_properties({
    class_type => 'twitter_statuses',
});

sub tweet { return $_[0]->title(@_) }

sub encode_field_for_html {
    return shift->encode_and_autolink_title_field(@_);
}

1;
