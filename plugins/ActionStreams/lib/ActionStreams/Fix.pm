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

package ActionStreams::Fix;

use strict;
use warnings;

use ActionStreams::Scraper;

sub _twitter_add_tags_to_item {
    my ($item) = @_;
    if (my @tags = $item->{title} =~ m{
        (?: \A | \s )  # BOT or whitespace
        \#             # hash
        (\w\S*\w)      # tag
        (?<! 's )      # but don't end with 's
    }xmsg) {
        $item->{tags} = \@tags;
    }
}

sub twitter_tweet_name {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    # Remove the Twitter username from the front of the tweet.
    my $ident = $profile->{ident};
    $item->{title} =~ s{ \A \s* \Q$ident\E : \s* }{}xmsi;
    _twitter_add_tags_to_item($item);
}

sub twitter_favorite_author {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    # Remove the Twitter username from the front of the tweet.
    if ($item->{title} =~ s{ \A \s* ([^\s:]+) : \s* }{}xms) {
        $item->{tweet_author} = $1;
    }
    _twitter_add_tags_to_item($item);
}

sub flickr_photo_thumbnail {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    # Extract just the URL, and use the _t size thumbnail, not the _m size image.
    my $thumb = delete $item->{thumbnail};
    if ($thumb =~ m{ (http://farm[^\.]+\.static\.flickr\.com .*? _m.jpg) }xms) {
        $thumb = $1;
        $thumb =~ s{ _m.jpg \z }{_t.jpg}xms;
        $item->{thumbnail} = $thumb;
    }
}

sub googlereader_link_links {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    my $enclosure = delete $item->{enclosure};
    $item->{url} ||= $enclosure || q{};
}

sub iminta_link_title {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    # Remove the username for when we add it back in later.
    $item->{title} =~ s{ (?: \s* :: [^:]+ ){2} \z }{}xms;
}

sub instructables_favorites_thumbnails {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    $item->{thumbnail} = URI->new_abs($item->{thumbnail}, 'http://www.instructables.com/')
        if $item->{thumbnail};
}

sub iusethis_event_title {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    # Remove the username for when we add it back in later.
    $item->{title} =~ s{ \A \w+ \s* }{}xms;
}

sub metafilter_favorites_titles {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    $item->{title} =~ s{ \A [^:]+ : \s* }{}xms;
}

sub netflix_recent_prefix_thumb {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    # Remove the 'Shipped:' or 'Received:' prefix.
    $item->{title} =~ s{ \A [^:]*: \s* }{}xms;

    # Extract thumbnail from description.
    my $thumb = delete $item->{thumbnail};
    if ($thumb =~ m/ <img src="([^"]+)"} /xms) {
        $item->{thumbnail} = $1;
    }
}

sub netflix_queue_prefix_thumb {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    # Remove the item number.
    $item->{title} =~ s{ \A \d+ [\W\S] \s* }{}xms;

    # Extract thumbnail from description.
    my $thumb = delete $item->{thumbnail};
    if ($thumb =~ m/ <img src="([^"]+)"} /xms) {
        $item->{thumbnail} = $1;
    }
}

sub nytimes_links_titles {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    return $item->{title} =~ s{ \A [^:]* recommended [^:]* : \s* }{}xms ? 1 : 0;
}

sub p0pulist_stuff_urls {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    $item->{url} =~ s{ \A / }{http://p0pulist.com/}xms;
}

sub kongregate_achievement_title_thumb {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    # Remove the parenthetical from the end of the title.
    $item->{title} =~ s{ \( [^)]* \) \z }{}xms;

    # Pick the actual achievement badge out of the inline CSS.
    my $thumb = delete $item->{thumbnail} || q{};
    if ($thumb =~ m{ background-image: \s* url\( ([^)]+) }xms) {
        $item->{thumbnail} = $1;
    }
}

sub wists_thumb {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    # Grab the wists thumbnail out.
    my $thumb = delete $item->{thumbnail};
    if ($thumb =~ m{ (http://cache.wists.com/thumbnails/ [^"]+ ) }xms) {
        $item->{thumbnail} = $1;
    }
}

sub gametap_score_stuff {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    $item->{score} =~ s{ \D }{}xmsg;
    $item->{url} = q{} . $item->{url};
    $item->{url} =~ s{ \A / }{http://www.gametap.com/}xms;
}

sub typepad_comment_titles {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    $item->{title} =~ s{ \A .*? ' }{}xms;
    $item->{title} =~ s{ ' \z }{}xms;
}

sub magnolia_link_notes {
    my ($cb, $app, $item, $event, $author, $profile) = @_;
    my $scraper = scraper {
        process '//p[position()=2]', note => 'TEXT';
    };

    my $result = $scraper->scrape(\$item->{note});

    if ($result->{note}) {
        $item->{note} = $result->{note};
    }
    else {
        delete $item->{note};
    }
}

1;
