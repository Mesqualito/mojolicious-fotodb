package Person;
use strict;
use warnings FATAL => 'all';

# see:
# - https://www.youtube.com/watch?v=7i-B-vOyV3c
# - http://www.perl-community.de/bat/poard/thread/16013
# - https://metacpan.org/pod/release/RJBS/perl-5.12.3/pod/perlsub.pod#DESCRIPTION


# sub's in Perl sind immer "call-by-reference"!
# deswegen anonyme Skalare/Arrays immer kopieren, z.B.: my @func_array = @_
sub name {
    # 1. Argument: $self = Referenz zu genau diesem Hash-Objekt aus dem Package Person
    # 2. Argument: optionaler, zusätzlicher Parameter für diese Funktion "name", eine Referenz auf ein Array mit Argument-Elementen
    # $_ = anonymer, lokaler "default"-Skalar, wird bei sub-Aufruf erstellt
    # @_ = anonymes, lokales Array, dessen Elemente $_[0], $_[1] (...) Aliasse auf die aktuellen Funktions-Parameter sind; wird bei sub-Aufruf erstellt
    my ($self, $n) = @_;

    # if somebody passes in a name, then
    # the value of the Hash-Key 'name' of the Person-Object is to be equal to '$n'
    $n && ($self->{'name'} = $n);

    # entweder die Funktion 'name' hat die Eigenschaft 'name' des Person-Objektes verändert
    # oder es wird der vorher existierende Wert der Eigenschaft 'name' zurück gegeben
    return $self->{'name'};

}

# https://www.perlmonks.org/?node_id=301355
# Short-Circuit in logical expression ("determine the truth of the statement by evaluating the fewest number of operands possible"
# ---------------------------------------------------------
# $this && $that   |    If $this is true, return $that,
# $this and $that  |    else return $this.
# -----------------+---------------------------------------
# $this || $that   |    If $this is true, return $this,
# $this or $that   |    else return $that.
# ---------------------------------------------------------


# Clearing Namespace

# The construct 'local *name;' creates a whole new symbol table entry for the glob name in the current package/function.
# That means that all variables in its glob slot ($name, @name, %name, &name, and the name filehandle) are dynamically reset.
#
# This implies, among other things, that any magic eventually carried by those variables is locally lost.
# In other words, saying local */ will not have any effect on the internal value of the input record separator.
#
# Notably, if you want to work with a brand new value of the default scalar $_
# and avoid the potential problem about $_ previously carrying a magic value,
# you should use local *_ instead of local $_.


1;
