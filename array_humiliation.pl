#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# arrays
my @plain_array = ("four", "five");

# last element of an array
# $#plain_array == "five" or die "@%$#\\ ?!";
# gives error:
# /usr/bin/perlbrew exec -q --with perl-5.29.10 /home/xxx/perl5/perlbrew/perls/perl-5.29.10/bin/perl5.29.10 /home/jhassfurter/IdeaProjects/mojolicious-fotodb/array_humiliation.pl
# $# is no longer supported as of Perl 5.30 at /home/xxx/IdeaProjects/mojolicious-fotodb/array_humiliation.pl line 9.
# :-)))))

# references to arrays
my $scalar_ref = \@plain_array;

# scalars which build up an array
my $array_of_scalars = ['one', 'two', 'three'];

# flat arrays with "explicit array-typing"
unshift @plain_array, @$array_of_scalars;

# nested arrays
push @plain_array, $scalar_ref;

# dereferencing nested arrays
# deep crap for mixed ones?
my $i=0;
my $size = @plain_array;
print "Array-length: $size \n";
foreach (@plain_array) {
    my $scalar_in_array = $plain_array[$i];
    if(!ref($scalar_in_array)) {
        print "$plain_array[$i] \n";
    } else {
        &array_in_array($i);
    };
    $i++;
};

sub array_in_array{
    my $j = 0;
    foreach(@{ $plain_array[$i] }) {
        print "$plain_array[$i][$j] \n";
        $j++;
    };
}


