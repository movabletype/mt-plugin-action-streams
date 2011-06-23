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

package ActionStreams::Event::OneupPlaying;

use strict;
use base qw( ActionStreams::Event );

use ActionStreams::Scraper;

__PACKAGE__->install_properties({
    class_type => 'oneup_playing',
});

__PACKAGE__->install_meta({
    columns => [ qw(
        playing
    ) ],
});

sub as_html {
    my $event = shift;
    my $form = $event->playing ? '[_1] started playing <a href="[_2]">[_3]</a>'
             :                   '[_1] played <a href="[_2]">[_3]</a>'
             ;
    return $event->SUPER::as_html( form => $form );
}

sub set_user_id {
    my ($cb, $app, $author, $profile) = @_;
    my $ident = $profile->{ident};
    my $url = "http://$ident.1up.com/";
    my $ua = __PACKAGE__->ua();
    my @redir = @{ $ua->requests_redirectable };
    $ua->requests_redirectable([]);

    my $resp = $ua->get($url);
    $ua->requests_redirectable(\@redir);

    die "Failed to get real User ID from 1Up.com." if $resp->code != 301;
    my $real_profile = $resp->header('Location');

    if ($real_profile !~ m{ \D (\d+) \z }xms) {
        # Hmm, invalid ident?
        die "Failed to get real User ID from 1Up.com.";
    }
    $profile->{user_id} = $1;
}

sub replace_ident {
    my ($cb, $mt, $author, $profile) = @_;
    $profile->{__ident} = $profile->{ident};
    $profile->{ident} = $profile->{user_id};
}

sub replace_back_ident {
    my ($cb, $mt, $author, $profile) = @_;
    $profile->{ident} = $profile->{__ident};
}

sub update_events {
    my $class = shift;
    my %profile = @_;
    my ($user_id, $author) = @profile{qw( user_id author )};
    my $url = "http://www.1up.com/do/gamesCollectionViewOnly?publicUserId=$user_id";
    my $items = $class->fetch_scraper(
        url     => $url,
        scraper => scraper {
            process 'table#game tbody tr', 'games[]' => scraper {
                process 'a',
                    'url'   => '@href',
                    'title' => 'TEXT';
                process q{td.bodybold img[src=~'icon_check']},
                    'playing' => '@src';
            };
            result 'games';
        },
    );
    return if !$items;

    for my $item (@$items) {
        $item->{playing} = $item->{playing} ? 1 : 0;
        $item->{identifier} = $item->{url};
    }

    $class->build_results( author => $author, items => $items );
}

1;
