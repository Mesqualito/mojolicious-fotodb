use utf8;
package FotoDB::Schema;

use strict;
use warnings;

# based on the DBIx::Class Schema base class
use base qw/DBIx::Class::Schema/;

our $VERSION = 1;

# This will load any classes within
# FotoDB::Schema::Result and FotoDB::Schema::ResultSet (if any)
__PACKAGE__->load_namespaces();

1;
