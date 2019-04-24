use strict;
use warnings;

use Mojolicious::Lite;

get '/' => {text => "I\'ll try to ♥ Mojolicious and will test whether to use it dockerized for the IPTC-Fotodatabase-Project bound to a dockerized CouchDB!\n"};

app->start;