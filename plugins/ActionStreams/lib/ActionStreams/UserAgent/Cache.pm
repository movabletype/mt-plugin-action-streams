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

package ActionStreams::UserAgent::Cache;
use base qw( MT::Object );

__PACKAGE__->install_properties({
    column_defs => {
        id            => 'integer not null auto_increment',
        url           => 'string(255) not null',
        etag          => 'string(255)',
        last_modified => 'string(255)',
        action_type   => 'string(255) not null',
    },
    indexes => {
        url         => 1,
        action_type => 1,
    },
    primary_key => 'id',
    datasource  => 'as_ua_cache',
});

1;
