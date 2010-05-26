# Action Streams (C) 2009-2010 Six Apart, Ltd. All Rights Reserved.
# This library is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.
#
# $Id$

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
