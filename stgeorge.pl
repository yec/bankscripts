#!/usr/bin/perl
use WWW::Mechanize;

$userid = '';
$securitynumber = '';
$password = '';
$accountpos = 3; # The position of the account on the my accounts page

# Login url
$url = 'https://ibanking.stgeorge.com.au/InternetBanking/welcome.jsp';

my $m = WWW::Mechanize->new();
$m->get($url);
$m->form_name('logonForm');
$m->field('userId', $userid);
$m->field('securityNumber', $securitynumber);
$m->field('password', $password);
$response = $m->submit();
#print $response->content();

$m->form_name('splashScreenForm');
$m->submit();
$m->follow_link( url_regex => qr/viewAccountDetails/i, n => $accountpos );
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
