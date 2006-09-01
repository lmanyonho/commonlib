#!/usr/bin/perl
# 
# THIS FILE WAS AUTOMATICALLY GENERATED BY ./rabxtopl.pl, DO NOT EDIT DIRECTLY
# 
# DaDem.pm:
# Client interface for DaDem.
#
# Copyright (c) 2005 UK Citizens Online Democracy. All rights reserved.
# WWW: http://www.mysociety.org
#
# $Id: DaDem.pm,v 1.32 2006-09-01 11:47:15 francis Exp $

package mySociety::DaDem;

use strict;

use RABX;
use mySociety::Config;

=item configure [URL]

Set the RABX URL which will be used to call the functions. If you don't
specify the URL, mySociety configuration variable DADEM_URL will be used
instead.

=cut
my $rabx_client = undef;
sub configure (;$) {
    my ($url) = @_;
    $url = mySociety::Config::get('DADEM_URL') if !defined($url);
    $rabx_client = new RABX::Client($url) or die qq(Bad RABX proxy URL "$url");
}

=item UNKNOWN_AREA 3001

  Area ID refers to a non-existent area.

=cut
use constant UNKNOWN_AREA => 3001;

=item REP_NOT_FOUND 3002

  Representative ID refers to a non-existent representative.

=cut
use constant REP_NOT_FOUND => 3002;

=item AREA_WITHOUT_REPS 3003

  Area ID refers to an area for which no representatives are returned.

=cut
use constant AREA_WITHOUT_REPS => 3003;

=item PERSON_NOT_FOUND 3004

  Preson ID refers to a non-existent person.

=cut
use constant PERSON_NOT_FOUND => 3004;

=item CONTACT_FAX 101

  Means of contacting representative is fax.

=cut
use constant CONTACT_FAX => 101;

=item CONTACT_EMAIL 102

  Means of contacting representative is email.

=cut
use constant CONTACT_EMAIL => 102;

=item DaDem::get_representatives ID_or_ARRAY [ALL]

  Given the ID of an area (or an ARRAY of IDs of several areas), return a
  list of the representatives returned by that area, or, for an array, a
  hash mapping area ID to a list of representatives for each; or, on
  failure, an error code. The default is to return only current
  reprenatives. If ALL has value 1, then even deleted representatives are
  returned. 

=cut
sub get_representatives ($;$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.get_representatives', @_);
}

=item DaDem::get_area_status AREA_ID

  Get the electoral status of area AREA_ID. Can be any of these: none - no
  special status pending_election - representative data invalid due to
  forthcoming election recent_election - representative data invalid
  because we haven't updated since election

=cut
sub get_area_status ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.get_area_status', @_);
}

=item DaDem::get_area_statuses

  Get the current electoral statuses. Can be any of these: none - no
  special status pending_election - representative data invalid due to
  forthcoming election recent_election - representative data invalid
  because we haven't updated since election

=cut
sub get_area_statuses () {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.get_area_statuses', @_);
}

=item DaDem::search_representatives QUERY

  Given search string, returns list of the representatives whose names,
  party, email or fax contain the string (case insensitive). Returns the id
  even if the string only appeared in the history of edited
  representatives, or in deleted representatives.

=cut
sub search_representatives ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.search_representatives', @_);
}

=item DaDem::get_user_corrections

  Returns list of user submitted corrections to democratic data. Each entry
  in the list is a hash of data about the user submitted correction.

=cut
sub get_user_corrections () {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.get_user_corrections', @_);
}

=item DaDem::get_bad_contacts

  Returns list of representatives whose contact details are bad. That is,
  listed as 'unknown', listed as 'fax' or 'email' without appropriate
  details being present, or listed as 'either'. (There's a new policy to
  discourages 'eithers' at all, as they are confusing).

  TODO: Check 'via' type as well somehow.

=cut
sub get_bad_contacts () {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.get_bad_contacts', @_);
}

=item DaDem::get_representative_info ID

  Given the ID of a representative, return a reference to a hash of
  information about that representative, including:

  * type

    Three-letter OS-style code for the type of voting area (for instance,
    CED or ward) for which the representative is returned.

  * name

    The representative's name.

  * method

    How to contact the representative.

  * email

    The representative's email address (only specified if method is
    'email').

  * fax

    The representative's fax number (only specified if method is 'fax').

  or, on failure, an error code.

=cut
sub get_representative_info ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.get_representative_info', @_);
}

=item DaDem::get_representatives_info ARRAY

  Return a reference to a hash of information on all of the representative
  IDs given in ARRAY.

=cut
sub get_representatives_info ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.get_representatives_info', @_);
}

=item DaDem::get_same_person PERSON_ID

  Returns an array of representative identifiers which are known to be the
  same person as PERSON_ID. Currently, this information only covers MPs.

=cut
sub get_same_person ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.get_same_person', @_);
}

=item DaDem::store_user_correction VA_ID REP_ID CHANGE NAME PARTY NOTES EMAIL

  Records a correction to representative data made by a user on the
  website. CHANGE is either "add", "delete" or "modify". NAME and PARTY are
  new values. NOTES and EMAIL are fields the user can put extra info in.

=cut
sub store_user_correction ($$$$$$$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.store_user_correction', @_);
}

=item DaDem::admin_get_stats

  Return a hash of information about the number of representatives in the
  database. The elements of the hash are,

  * representative_count

    Number of representatives in total (including deleted, out of
    generation)

  * area_count

    Number of areas for which representative information is stored.

=cut
sub admin_get_stats () {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.admin_get_stats', @_);
}

=item DaDem::get_representative_history ID

  Given the ID of a representative, return an array of hashes of
  information about changes to that representative's contact info.

=cut
sub get_representative_history ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.get_representative_history', @_);
}

=item DaDem::get_representatives_history ID

  Given an array of ids of representatives, returns a hash from
  representative ids to an array of history of changes to that
  representative's contact info.

=cut
sub get_representatives_history ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.get_representatives_history', @_);
}

=item DaDem::admin_edit_representative ID DETAILS EDITOR NOTE

  Alters data for a representative, updating the override table
  representative_edited. ID contains the representative id, or undefined to
  make a new one (in which case DETAILS needs to contain area_id and
  area_type). DETAILS is a hash from name, party, method, email and fax to
  their new values, or DETAILS is not defined to delete the representative.
  Every value has to be present - or else values are reset to their initial
  ones when import first happened. Any modification counts as an
  undeletion. EDITOR is the name of the person who edited the data. NOTE is
  any explanation of why / where from. Returns ID, or if ID was undefined
  the new id.

=cut
sub admin_edit_representative ($$$$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.admin_edit_representative', @_);
}

=item DaDem::admin_done_user_correction ID

  Marks user correction ID as having been dealt with.

=cut
sub admin_done_user_correction ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.admin_done_user_correction', @_);
}

=item DaDem::admin_mark_failing_contact ID METHOD X EDITOR COMMENT

  Report that a delivery to representative ID by METHOD ('email' or 'fax')
  to the number or address X failed. Marks the representative as having
  unknown contact details if X is still the current contact method for that
  representative. EDITOR is the name of the entity making the correction
  (e.g. 'fyr-queue'), COMMENT is an extra comment to add to the change log
  of the representatives details.

=cut
sub admin_mark_failing_contact ($$$$$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.admin_mark_failing_contact', @_);
}

=item DaDem::admin_set_area_status AREA_ID NEW_STATUS

  Set the electoral status of an area given by AREA_ID. NEW_STATUS can have
  any of the values described for get_area_status.

=cut
sub admin_set_area_status ($$) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.admin_set_area_status', @_);
}

=item DaDem::admin_get_raw_council_status

  Returns how many councils are not in the made-live state.

=cut
sub admin_get_raw_council_status () {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.admin_get_raw_council_status', @_);
}

=item DaDem::admin_get_diligency_council TIME

  Returns how many edits each administrator has made to the raw council
  data since unix time TIME. Data is returned as an array of pairs of
  count, name with largest counts first.

=cut
sub admin_get_diligency_council ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.admin_get_diligency_council', @_);
}

=item DaDem::admin_get_diligency_reps TIME

  Returns how many edits each administrator has made to representatives
  since unix time TIME. Data is returned as an array of pairs of count,
  name with largest counts first.

=cut
sub admin_get_diligency_reps ($) {
    configure() if !defined $rabx_client;
    return $rabx_client->call('DaDem.admin_get_diligency_reps', @_);
}


1;
