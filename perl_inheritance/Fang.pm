# https://fang.fhws.de/technomathematik/
package Fang;
use strict;
use warnings FATAL => 'all';

# "." is not in @INC any longer!
# see: https://metacpan.org/pod/release/XSAWYERX/perl-5.26.0/pod/perldelta.pod#Removal-of-the-current-directory-%28%22.%22%29-from-@INC
BEGIN {
    my $dir = "../perl_inheritance";
    chdir $dir or die "Can't chdir to $dir: $!\n";
    # safe now
    push @INC, '.';
}

use parent Person;

sub id {
    my ($self, $id) = @_;
    if ($id) { $self->{'id'} = $id }
    return $self->

}


1;
