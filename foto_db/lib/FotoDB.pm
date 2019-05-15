package FotoDB;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
    my $self = shift;

    # Load configuration from hash returned by config file
    my $config = $self->plugin('Config');

    # Allows to set the signing key as an array,
    # where the first key will be used for all new sessions
    # and the other keys are still used for validation, but not for new sessions.
    # default: $self->secrets($config->{secrets});
    $self->secrets([ 'This secret is used for new sessions 7Zgdhrenm81asjenrtUGcVq',
        'This secret is used __only__ for validation Ma5EdxFq2uZi63pD2q' ]);

    # the cookie name
    $self->app->sessions->cookie_name('fotodb');

    # Expiration reduced to 10 minutes
    $self->app->sessions->default_expiration('600');

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
    $r->route('/logout')->name('do_logout')->to(cb => sub {
        my $self = shift;

        # Expire the session (deleted upon next request)
        $self->session(expires => 1);

        # Go back to home
        $self->redirect_to('home');
    });

    # When a route is tied to an 'under' action, all requests first execute this action.
    # Only if returns a true value, the actual route action is executed.
    # We can use this to force authentication for a whole set of routes, by adding a route action
    my $authorized = $r->under('/admin')->to('Login#is_logged_in');

    # The $authorized object behaves just like the router object.
    # For the restricted area, we can use it to define new, restricted routes.
    $authorized->get('/')->name('restricted_area')->to(template => 'admin/overview');
    $authorized->get('create')->name('create_post')->to(template => 'admin/create_post');
    $authorized->post('/create')->name('publish_post')->to('Post#create');


    # The placeholder is denoted by :id and is restricted using the regex pattern qr/\d+/ to accept numeric values only.
    # Note: Do not use start/end markers ^$ or capturing groups, as the regex is actually combined in a larger route regex pattern

    # on GET we display a template asking to confirm the deletion:
    $authorized->get('/delete/:id', [id => qr/\d+/])->name('delete_post')->to(template => 'admin/delete_post_confirm');

    # on POST we delete the post:
    $authorized->post('/delete/:id', [id => qr/\d+/]->name('delete_post_confirmed')->to('Post#delete');

    my $schema = FotoDB::Schema->connect('dbi:SQLite:../../../fotodb.db');
    $self->helper(db => sub { return $schema; });
}

1;
