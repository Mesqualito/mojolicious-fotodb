#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use Mojo::File 'path';
use Carp::Assert;
use Array::Compare;

# Testing https://mojolicious.org/perldoc/Mojo/File#to_array

my $path = path('/home/xxx/.vimrc');

my @test = ("home", "xxx", ".vimrc");

my $test_new = ['home', 'xxx', '.vimrc'];
my @special_test_array = @$test_new;

@test == @special_test_array or die "Wrong test assertion!";

my $path_strings = $path->to_array;
my @path_array = @$path_strings;

unshift @test, '';

# ----- Assertion strategy 1 -----

my $comp = Array::Compare->new;
if ($comp->compare(\@path_array, \@test)) {
    print "Arrays are now the same\n";
} else {
    print "Arrays are still different\n";
};

# ----- Assertion strategy 2 -----

assert(@test == @path_array);

# ----- Assertion strategy 3 -----

foreach (@path_array) {
    print "\$_ is \'$_\'\n";
}
foreach (@test) {
    print "\$_ is \'$_\'\n";
}

