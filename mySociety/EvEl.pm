#!/usr/bin/perl
# 
# THIS FILE WAS AUTOMATICALLY GENERATED BY ./rabxtopl.pl, DO NOT EDIT DIRECTLY
# 
# EvEl.pm:
# Generic email sending and mailing list functionality, with bounce detection
#
# Copyright (c) 2005 UK Citizens Online Democracy. All rights reserved.
# WWW: http://www.mysociety.org
#
# $Id: EvEl.pm,v 1.25 2006-09-01 11:47:15 francis Exp $

package mySociety::EvEl;

use strict;

use RABX;
use mySociety::Config;

=item configure [URL]

Set the RABX URL which will be used to call the functions. If you don't
specify the URL, mySociety configuration variable EVEL_URL will be used
instead.

=cut
my $rabx_client = undef;
sub configure (;$) {
    my ($url) = @_;
    $url = mySociety::Config::get('EVEL_URL') if !defined($url);
    $rabx_client = new RABX::Client($url) or die qq(Bad RABX proxy URL "$url");
}

=item EvEl::construct_email SPEC

  Construct a wire-format (RFC2822) email message according to SPEC, which
  is an associative array containing elements as follows:

  * _body_

    Text of the message to send, as a UTF-8 string with "\n" line-endings.

  * _unwrapped_body_

    Text of the message to send, as a UTF-8 string with "\n" line-endings.
    It will be word-wrapped before sending.

  * _template_, _parameters_

    Templated body text and an associative array of template parameters.
    _template contains optional substititutions <?=$values['name']?>, each
    of which is replaced by the value of the corresponding named value in
    _parameters_. It is an error to use a substitution when the
    corresponding parameter is not present or undefined. The first line of
    the template will be interpreted as contents of the Subject: header of
    the mail if it begins with the literal string 'Subject: ' followed by a
    blank line. The templated text will be word-wrapped to produce lines of
    appropriate length.

  * To

    Contents of the To: header, as a literal UTF-8 string or an array of
    addresses or [address, name] pairs.

  * From

    Contents of the From: header, as an email address or an [address, name]
    pair.

  * Cc

    Contents of the Cc: header, as for To.

  * Subject

    Contents of the Subject: header, as a UTF-8 string.

  * Message-ID

    Contents of the Message-ID: header, as a US-ASCII string.

  * _any other element_

    interpreted as the literal value of a header with the same name.

  If no Message-ID is given, one is generated. If no To is given, then the
  string "Undisclosed-Recipients: ;" is used. If no From is given, a
  generic no-reply address is used. It is an error to fail to give a body,
  unwrapped body or a templated body; or a Subject.

=cut
sub construct_email ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('EvEl.construct_email', @_);
}

=item EvEl::send MESSAGE RECIPIENTS

  Send a MESSAGE to the given RECIPIENTS. MESSAGE is either the full text
  of a message (in its RFC2822, on-the-wire format) or an associative array
  as passed to construct_email. RECIPIENTS is either one email address
  string, or an array of them for multiple recipients.

=cut
sub send ($$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('EvEl.send', @_);
}

=item EvEl::is_address_bouncing ADDRESS

  Return true if we have received bounces for the ADDRESS.

=cut
sub is_address_bouncing ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('EvEl.is_address_bouncing', @_);
}

=item EvEl::list_create SCOPE TAG NAME MODE [LOCALPART DOMAIN]

  Create a new mailing list for the given SCOPE (e.g. "pledgebank") and TAG
  (a unique reference for this list within SCOPE). NAME is the
  human-readable name of the list and MODE the posting-mode. Possible MODES
  are:

  * any

    anyone may post;

  * subscribers

    only subscribers may post;

  * admins

    only administrators may post; or

  * none

    nobody may post, so messages can only be submitted through the EvEl
    API.

  If MODE is anything other than "none", then LOCALPART and DOMAIN must be
  specified. These indicate the address for submissions to the list; if
  specified, LOCALPART "@" DOMAIN must form a valid mail address.

=cut
sub list_create ($$$$;$$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('EvEl.list_create', @_);
}

=item EvEl::list_destroy SCOPE TAG

  Delete the list identified by the given SCOPE and TAG.

=cut
sub list_destroy ($$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('EvEl.list_destroy', @_);
}

=item EvEl::list_subscribe SCOPE TAG ADDRESS [ISADMIN]

  Subscribe ADDRESS to the list identified by SCOPE and TAG. Make the user
  an administrator if ISADMIN is true. If the ADDRESS is already on the
  list, then set their administrator status according to ISADMIN.

=cut
sub list_subscribe ($$$;$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('EvEl.list_subscribe', @_);
}

=item EvEl::list_unsubscribe SCOPE TAG ADDRESS

  Remove ADDRESS from the list identified by SCOPE and TAG.

=cut
sub list_unsubscribe ($$$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('EvEl.list_unsubscribe', @_);
}

=item EvEl::list_attribute

=cut
sub list_attribute () {
    configure() if !defined $rabx_client;
    return $rabx_client->call('EvEl.list_attribute', @_);
}

=item EvEl::list_send SCOPE TAG MESSAGE

  Send MESSAGE (on-the-wire message data, including all headers) to the
  list identified by SCOPE and TAG.

=cut
sub list_send ($$$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('EvEl.list_send', @_);
}

=item EvEl::list_members

=cut
sub list_members () {
    configure() if !defined $rabx_client;
    return $rabx_client->call('EvEl.list_members', @_);
}


1;
