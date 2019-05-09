#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use CGI;
use CGI::Carp qw(fatalsToBrowser);

my $cgi = new CGI;

print $cgi->header('text/html'), "Mr. Mr. Browser :-)"
