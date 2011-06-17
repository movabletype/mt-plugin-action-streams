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

package ActionStreams::Event::Website;

use strict;
use base qw( ActionStreams::Event );

use ActionStreams::Scraper;

__PACKAGE__->install_properties({
    class_type => 'website_posted',
});

__PACKAGE__->install_meta({
    columns => [ qw(
        summary
        source_title
        source_url
        icon_url
    ) ],
});

sub summary {
    ## for escape from the collision with summary framework.
    my $obj = shift;
    my $col = 'summary';
    $obj->meta('summary', @_);
}

sub update_events {
    my $class = shift;
    my %profile = @_;
    my ($ident, $author) = @profile{qw( ident author )};

    my $links = $class->fetch_scraper(
        unconditional => 1,
        url           => $ident,
        scraper       => scraper {
            process 'head link[type="application/atom+xml"]', 'atom[]' => '@href';
            process 'head link[type="application/rss+xml"]',  'rss[]'  => '@href';
            process 'head link[rel~="shortcut"]',             'icon[]' => '@href';
        },
    );
    return if !$links;

    my ($feed_url, $items);
    if (($feed_url) = @{ $links->{atom} || [] }) {
        $items = $class->fetch_xpath(
            url => $feed_url,
            foreach => '//entry',
            get => {
                identifier   => 'id/child::text()',
                title        => 'title/child::text()',
                summary      => 'summary/child::text()',
                url          => q(link[@rel='alternate']/@href),
                source_title => 'ancestor::feed/title/child::text()',
                source_url   => q(ancestor::feed/link[@rel='alternate']/@href),
                created_on   => 'published/child::text()',
                modified_on  => 'updated/child::text()',
            },
        );
    }
    elsif (($feed_url) = @{ $links->{rss} || [] }) {
        $items = $class->fetch_xpath(
            url => $feed_url,
            foreach => '//item',
            get => {
                identifier   => 'guid/child::text()',
                title        => 'title/child::text()',
                summary      => 'description/child::text()',
                url          => 'link/child::text()',
                source_title => 'ancestor::channel/title/child::text()',
                source_url   => 'ancestor::channel/link/child::text()',
                created_on   => 'pubDate/child::text()',
                modified_on  => 'pubDate/child::text()',
            },
        );
        for my $item (@$items) {
            $item->{identifier} ||= $item->{url} || $item->{title};
        }
        @$items = grep { $_->{identifier} } @$items;
    }
    return if !$items;

    if (my ($icon_url) = @{ $links->{icon} || [] }) {
        $icon_url = q{} . $icon_url;
        $_->{icon_url} = $icon_url for @$items;
    }

    $class->build_results( author => $author, items => $items );
}

1;
