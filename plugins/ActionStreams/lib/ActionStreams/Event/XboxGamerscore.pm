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

package ActionStreams::Event::XboxGamerscore;

use strict;
use base qw( ActionStreams::Event );

use ActionStreams::Scraper;

__PACKAGE__->install_properties({
    class_type => 'xboxlive_gamerscore',
});

__PACKAGE__->install_meta({
    columns => [ qw(
        score
        ident
    ) ],
});

sub update_events {
    my $class = shift;
    my %profile = @_;
    my ($ident, $author) = @profile{qw( ident author )};

    my $url = "http://gamercard.xbox.com/$ident.card";

    my $scraper = scraper {
        process q{//img[@alt='Gamerscore']/ancestor::p/span[@class='XbcFRAR']},
            score => 'TEXT';
    };
    $scraper->user_agent($class->ua);
    my $score = $scraper->scrape(URI->new($url));
    return if !$score;

    $score = $score->{score};
    $score =~ s{ \A \s+ | \s+ \z }{}xmsg;
    return if $score =~ m{ \D }xms;

    $score =~ s/ (?<= \A \d ) (\d*) \z / join q{}, ((q{0}) x length $1) /xmse;

    my $item = {
        url        => "http://live.xbox.com/member/$ident",
        score      => $score,
        identifier => join(q{:}, $ident, $score),
    };

    $class->build_results( author => $author, items => [ $item ] );
}

1;
