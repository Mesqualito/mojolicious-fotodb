package FotoDB;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');

  # Configure the application
  $self->secrets($config->{secrets});

  # main router object
  my $r = $self->routes;

  # route definition to controller
  # long form:
  # $r->route('/')->via('GET')->to(controller => 'Example', action => 'welcome')
  $r->get('/')->to('example#welcome');
}

1;
