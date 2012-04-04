#!/usr/bin/perl
package BankConfig;
use strict;
use warnings;

sub config {
    return (
        'userid' => '',
        'securitynumber' => '',
        'password' => '',
        'accountpos' => 3 # The position of the account on the my accounts page
    );
}

1;

