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

package ActionStreams::Scraper;

my $import_error = 'Cannot update stream without Web::Scraper; a prerequisite may not be installed';

sub import {
    my %methods;

    if (eval { require Web::Scraper; 1 }) {
        Web::Scraper->import();
        %methods = (
            scraper       => \&scraper,
            result        => sub { goto &result },
            process       => sub { goto &process },
            process_first => sub { goto &process_first },
        );
    }
    elsif (my $err = $@) {
        $import_error .= ': ' . $err;
        %methods = (
            scraper       => sub (&) { die $import_error },
            result        => sub     { die $import_error },
            process       => sub     { die $import_error },
            process_first => sub     { die $import_error },
        );
    }

    # Export these methods like Web::Scraper does.
    my $pkg = caller;
    no strict 'refs';
    while (my ($key, $val) = each %methods) {
        *{"${pkg}::${key}"} = $val;
    }
    return 1;
}

1;
