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

package ActionStreams::Event::Vox;

use strict;
use base qw( ActionStreams::Event );

use ActionStreams::Scraper;

__PACKAGE__->install_properties({
    class_type => 'vox_favorites',
});

sub update_events {
    my $class = shift;
    my %profile = @_;
    my ($ident, $author) = @profile{qw( ident author )};

    my $items = $class->fetch_scraper(
        url => "http://$ident.vox.com/profile/favorites/",
        scraper => scraper {
            process '.asset',
                'assets[]' => scraper {
                    process '.asset',
                        identifier => '@at:xid';
                    process '.asset-meta .asset-name a',
                        url   => '@href',
                        title => 'TEXT';
                };
            result 'assets';
        },
    );
    return if !$items;

    $class->build_results( author => $author, items => $items );
}

1;
