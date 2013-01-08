# Copyrights 2012-2013 by [Mark Overmeer].
#  For other contributors see Changes.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.
package Net::OAuth2::AccessToken;
use vars '$VERSION';
$VERSION = '0.50';

use warnings;
use strict;

use JSON        qw/encode_json/;
use URI::Escape qw/uri_escape/;

# This class name is kept for backwards compatibility: a better name
# would have been: Net::OAuth2::BearerToken

# In the future, most of this functionality will probably need to be
# split-off in a base class ::Token, to be shared with a new extension
# which supports HTTP-MAC tokens as proposed by ietf dragt
#   http://datatracker.ietf.org/doc/draft-ietf-oauth-v2-http-mac/


sub new(@) { my $class = shift; (bless {}, $class)->init({@_}) }

sub init($)
{   my ($self, $args) = @_;

    $self->{NOA_expires} = $args->{expires_at}
       || ($args->{expires_in} ? time()+$args->{expires_in} : undef);

    # client is the pre-v0.50 name
    my $profile = $self->{NOA_profile} = $args->{profile} || $args->{client}
        or die "accesstoken needs profile object";

    $self->{NOA_token}     = $args->{access_token};
    $self->{NOA_refresh}   = $args->{refresh_token};
    $self->{NOA_scope}     = $args->{scope};
    $self->{NOA_type}      = $args->{token_type};
    $self->{NOA_autofresh} = $args->{auto_refresh};
    $self->{NOA_error}     = $args->{error};
    $self->{NOA_error_uri} = $args->{error_uri};
    $self->{NOA_error_descr} = $args->{error_description} || $args->{error};
    $self;
}

#--------------

sub refresh_token() {shift->{NOA_refresh}}
sub token_type()    {shift->{NOA_type}}
sub scope()         {shift->{NOA_scope}}
sub profile()       {shift->{NOA_profile}}
sub auto_refresh()  {shift->{NOA_autofresh}}
sub error()         {shift->{NOA_error}}
sub error_uri()     {shift->{NOA_error_uri}}
sub error_description() {shift->{NOA_error_descr}}


sub access_token()
{   my $self = shift;

    $self->refresh
        if  $self->auto_refresh
        || ($self->refresh_token && $self->expired);

    $self->{NOA_token};
}


sub expires_at() { shift->{NOA_expires} }


sub expires_in() { shift->expires_at - time() }


sub expired(;$)
{   my ($self, $after) = @_;
    my $when = $self->expires_at or return;
    $after = 15 unless defined $after;
    $when < time() + $after;
}


sub update_token($$$)
{   my ($self, $token, $type, $exp) = @_;
    $self->{NOA_token}   = $token;
    $self->{NOA_type}    = $type if $type;
    $self->{NOA_expires} = $exp;
    $token;
}

#--------------

sub request{ my $s = shift; $s->profile->request_auth($s, @_) }
sub get    { my $s = shift; $s->profile->request_auth($s, 'GET',    @_) }
sub post   { my $s = shift; $s->profile->request_auth($s, 'POST',   @_) }
sub delete { my $s = shift; $s->profile->request_auth($s, 'DELETE', @_) }
sub put    { my $s = shift; $s->profile->request_auth($s, 'PUT',    @_) }


sub to_string()
{   my $self = shift;
    my %data;
    @data{ qw/access_token token_type refresh_token  expires_at
              scope        state      auto_refresh/ }
  = @$self{qw/NOA_token    NOA_type   NOA_refresh    NOA_expires
              NOA_scope    NOA_state  NOA_autofresh/ };

    encode_json \%data;
}


sub refresh()
{   my $self = shift;
    $self->profile->update_access_token($self);
}

1;
