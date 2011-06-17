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

package ActionStreams::Event::Steam;

use strict;
use base qw( ActionStreams::Event );

use ActionStreams::Scraper;

__PACKAGE__->install_properties({
    class_type => 'steam_achievements',
});

__PACKAGE__->install_meta({
    columns => [ qw(
        gametitle
        gamecode
        ident
        description
    ) ],
});

my %game_for_code = (
    Portal    => 'Portal',
    TF2       => 'Team Fortress 2',
    'HL2:EP2' => 'Half-Life 2: Episode Two',
    'DOD:S'   => 'Day of Defeat: Source',
);

sub game {
    my $event = shift;
    return $event->gametitle || $game_for_code{$event->gamecode}
        || $event->gamecode;
}

sub update_events {
    my $class = shift;
    my %profile = @_;
    my ($ident, $author) = @profile{qw( ident author )};

    my $achv_scraper = scraper {
        process q{div#BG_top h2},
            'title' => 'TEXT';
        process q{html},
            'html' => 'HTML';
        process q{//div[@class='achieveTxtHolder']},
            'achvs[]' => scraper {
                process 'h3',  'title'       => 'TEXT';
                process 'h5',  'description' => 'TEXT';
                process 'img', 'thumbnail'   => '@src';
            };
    };

    my $games = $class->fetch_scraper(
        url => "http://steamcommunity.com/id/$ident/games",
        scraper => scraper {
            process q{div#mainContents a.linkStandard},
                'urls[]' => '@href';
            result 'urls';
        },
    );
    return if !$games;

    URL: for my $url (@$games) {
        my $gamecode = "$url";
        $gamecode =~ s{ \A .* / }{}xms;

        $url = "$url?tab=achievements";  # TF2's stats page has tabs

        next URL if $url !~ m{ \Q$ident\E }xms;

        my $items = $class->fetch_scraper(
            url     => $url,
            scraper => $achv_scraper,
        );
        next URL if !$items;

        my ($title, $html, $achvs) = @$items{qw( title html achvs )};
        $title =~ s{ \s* Stats \z }{}xmsi;

        next URL if ($title =~ /Global Gameplay/i);

        # So we have the full source code in $html; we need to count how many achievements are before
        # the critical <br /><br /><br /> line dividing achieved from unachieved.

        next URL if ($html !~ /\<br\ \/\>\<br\ \/\>\<br\ \/\>.+/); # If the line isn't there, they don't have any achievements yet.

        $html =~ s/\<br\ \/\>\<br\ \/\>\<br\ \/\>.+//;
        my @splitlist = split(/achieveTxtHolder/, $html);
        my $count = scalar @splitlist;
        $count = $count - 2; #This method ends up with one too many, always, and we want the last valid *INDEX* number.

        my @achievements = @$achvs;
        $#achievements = $count; # Truncates the array

        for my $item (@achievements) {
            $item->{gametitle} = $title;
            $item->{ident}     = $ident;
            $item->{gamecode}  = $gamecode;
            $item->{url}       = $url;
            # Stringify thumbnail url as our complicated structure
            # prevents fetch_scraper() from stringifying it for us.
            $item->{thumbnail} = q{} . $item->{thumbnail};
        }

        $class->build_results(
            author     => $author,
            items      => \@achievements,
            identifier => 'ident,gamecode,title',
        );
    }

    1;
}


1;
