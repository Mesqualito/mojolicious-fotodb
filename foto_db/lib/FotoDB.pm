package FotoDB;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');

  # Configure the application
  $self->secrets($config->{secrets});

  # Default layout
  $self->defaults(layout => 'base');

  # Router
    my $r = $self->routes;

  # GET / -> Main::index()
  # as the index page doesn't require any additional data, we can directly render a template in the route definition
  # $r->get('/')->to(template => 'main/index');

  # we can also change to route to use a controller to manually render data:
  # $r->get('/')->to(controller => 'Main', action => 'index');
  $r->get('/')->to('main#index'); # short

  $r->get('/login')->name('login_form')->to(template => 'login/login_form');
  $r->post('/login')->name('do_login')->to('Login#on_user_login');

}

1;
