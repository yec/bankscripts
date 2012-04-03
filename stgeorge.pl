#!/usr/bin/perl
use WWW::Mechanize;
$url = 'https://ibanking.stgeorge.com.au/InternetBanking/welcome.jsp';
my $m = WWW::Mechanize->new();
$m->get($url);
$m->form_name('logonForm');
$m->field('userId', '');
$m->field('securityNumber', '');
$m->field('password', '');
$response = $m->submit();
#print $response->content();

$m->follow_link( url_regex => qr/viewAccountDetails/i, n => 3 );
print $m->content();


#$m->submit_form(
#    form_name => 'accountDetailForm',
#    fields => {selectedOption => 3}
#);

