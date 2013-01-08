# Copyrights 2012-2013 by [Mark Overmeer].
#  For other contributors see Changes.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.00.
package Net::OAuth2::Profile::WebServer;
use vars '$VERSION';
$VERSION = '0.50';

use base 'Net::OAuth2::Profile';

use warnings;
use strict;

use Net::OAuth2::AccessToken;
use HTTP::Request;
use MIME::Base64  'encode_base64';


sub init($)
{   my ($self, $args) = @_;
    $args->{grant_type}  ||= 'authorization_code';
    $self->SUPER::init($args);
    $self->{NOPW_redirect} = $args->{redirect_uri};
    $self->{NOPW_referer}  = $args->{referer};
    $self;
}

#-------------------

sub redirect_uri() {shift->{NOPW_redirect}}
sub referer(;$)
{   my $s = shift; @_ ? $s->{NOPW_referer} = shift : $s->{NOPW_referer} }

#--------------------

sub authorize(@)
{   my ($self, @req_params) = @_;
    my $request = $self->build_request
      ( $self->authorize_method
      , $self->authorize_url
      , $self->authorize_params(@req_params)
      );

    my $ua        = $self->user_agent;
    my $old_redir = $ua->requests_redirectable;
    $ua->requests_redirectable([]);

    my $response  = $self->request($request);

    $ua->requests_redirectable($old_redir);
    $response;
}


sub get_access_token($@)
{   my ($self, $code, @req_params) = @_;

    # rfc6749 section "2.3.1. Client Password"
    # header is always supported, client_id/client_secret may be.  We do both.
    my $params  = $self->access_token_params(code => $code, @req_params);
    my $request = $self->build_request
      ( $self->access_token_method
      , $self->access_token_url
      , $params
      );
    my $basic = encode_base64 "$params->{client_id}:$params->{client_secret}";
    $request->headers->header(Authorization => "Basic $basic");
    my $response = $self->request($request);

    Net::OAuth2::AccessToken->new(client => $self
      , $self->params_from_response($response, 'access token'));
}


sub update_access_token($@)
{   my ($self, $access, @req_params) = @_;
    my $refresh =  $access->refresh_token
        or die 'unable to refresh token without refresh_token';

    my $req   = $self->build_request
      ( $self->refresh_token_method
      , $self->refresh_token_url
      , $self->refresh_token_params(refresh_token => $refresh, @req_params)
      );

    my $resp  = $self->request($req);
    my $data  = $self->params_from_response($resp, 'update token');

    my $token = $data->{access_token}
        or die "no access token found in refresh data";

    my $type  = $data->{token_type};

    my $exp   = $data->{expires_in}
        or die  "no expires_in found in refresh data";

    $access->update_token($token, $type, $exp+time());
}

sub authorize_params(%)
{   my $self   = shift;
    my $params = $self->SUPER::authorize_params(@_);
    $params->{response_type} ||= 'code';
    $params->{redirect_uri}  ||= $self->redirect_uri;
    $params;
}

sub access_token_params(%)
{   my $self   = shift;
    my $params = $self->SUPER::access_token_params(@_);
    $params->{redirect_uri} ||= $self->redirect_uri;
    $params;
}

sub refresh_token_params(%)
{   my $self   = shift;
    my $params = $self->SUPER::refresh_token_params(@_);
    $params->{grant_type}   ||= 'refresh_token';
    $params;
}

#--------------------

sub build_request($$$)
{   my $self    = shift;
    my $request = $self->SUPER::build_request(@_);

    if(my $r = $self->referer)
    {   $request->header(Referer => $r);
    }

    $request;
}

1;
