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

# ------- Mojolicious again -------

# look at a path

# ["home", "xxx", ".vimrc"]
$path->to_array;

# "/home/xxx"
$path->dirname;

# ".vimrc"
$path->basename;

# manipulate a path
$path = path('/home/xxx');

# "/home/xxx/.ssh/known_hosts"
$path->child('.ssh', 'known_hosts');

# "/home/xyz/.bashrc"
$path->sibling('xyz', '.bashrc');


# chain to create directories and files

$path = path('/home/xxx');

$path->child('myapp')->make_path;

$path->child('myapp', 'README.md')->spurt('Hello Mojo!');


# list all files in a directory

$path = path('/home/xxx');

for my $file ($path->list_tree->each) {
    print "list_tree (recursively): $file\n";
};

for my $file ($path->list->each) {
    print "list (non-recursively): $file\n";
};


# these methods return collections
# of mutual file objects (e.g. for one-liners)
path('/home/xxx')->list->each(sub { print "$_->slurp \n" });
