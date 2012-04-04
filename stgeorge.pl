#!/usr/bin/perl

use WWW::Mechanize;
require 'bankconfig.pm';

use strict;
use warnings;

# Login url
my $url = 'https://ibanking.stgeorge.com.au/InternetBanking/welcome.jsp';

my %config = BankConfig::config();

my $m = WWW::Mechanize->new();

$m->get($url);

$m->submit_form(
    form_name => 'logonForm',
    fields => {
        'userId' => $config{'userid'},
        'securityNumber' => $config{'securitynumber'},
        'password' => $config{'password'},
    }
);

print $m->content();

$m->form_name('splashScreenForm');
$m->submit();
$m->follow_link( url_regex => qr/viewAccountDetails/i, n => $config{'accountpos'} );
#print $m->content();

$m->submit_form(
    form_name => 'accountDetailForm',
    fields => {selectedOption => 3}
);

$m->submit_form(
    form_name => 'accountDetailForm',
    fields => {
        exportFileFormat => 'QIF',
        dispatchCommand => 'downloadButton'
    }
);

print $m->content();
