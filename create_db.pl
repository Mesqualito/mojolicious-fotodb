#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use File::Basename;
use lib dirname (__FILE__) . "/foto_db/lib";
use FotoDB::Schema;

my $schema = FotoDB::Schema->connect('dbi:SQLite:fotodb.db');
$schema->deploy();
