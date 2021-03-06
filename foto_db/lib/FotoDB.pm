package FotoDB;
use Mojo::Base 'Mojolicious';
BEGIN {
    my $dir = "/home/jhassfurter/IdeaProjects/mojolicious-fotodb/foto_db";
    chdir $dir or die "Can't chdir to $dir: $!\n";
    # safe now
    push @INC, ['.'];
}
use FotoDB::Schema;

# This method will run once at server start
sub startup {
    my $self = shift;

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

    # Router
    my $r = $self->routes;

    # GET / -> Main::index()
    # as the index page doesn't require any additional data, we can directly render a template in the route definition
    # we can also change to route to use a controller to manually render data:
    # $r->get('/')->to(controller => 'Main', action => 'index');
    # or: $r->get('/')->to('main#index');
    $r->get('/')->to(template => 'main/index');

    # Login routes
    $r->get('/login')->name('login_form')->to(template => 'login/login_form');
    $r->post('/login')->name('do_login')->to('Login#on_user_login');

    # When a route is tied to an 'under' action, all requests first execute this action.
    # Only if returns a true value, the actual route action is executed.
    # We can use this to force authentication for a whole set of routes, by adding a route action
    my $authorized = $r->under('/admin')->to('Login#is_logged_in');
    # The $authorized object behaves just like the router object.
    # For the restricted area, we can use it to define new, restricted routes.
    $authorized->get('/')->name('restricted_area')->to(template => 'admin/overview');

    # Write new post
    $authorized->get('create')->name('create_post')->to(template => 'admin/create_post');
    $authorized->post('/create')->name('publish_post')->to('Post#create');

    # Delete posts
    # The placeholder is denoted by :id and is restricted using the regex pattern qr/\d+/ to accept numeric values only.
    # Note: Do not use start/end markers ^$ or capturing groups, as the regex is actually combined in a larger route regex pattern

    # on GET we display a template asking to confirm the deletion:
    $authorized->get('/delete/:id', [id => qr/\d+/])->name('delete_post')->to(template => 'admin/delete_post_confirm');
    # on POST we delete the post:
    $authorized->post('/delete/:id', [id => qr/\d+/])->name('delete_post_confirmed')->to('Post#delete');

    # Logout routes
    $r->route('/logout')->name('do_logout')->to(cb => sub {
        my $self = shift;

        # Expire the session (deleted upon next request)
        $self->session(expires => 1);

        # Go back to home
        $self->redirect_to('home');
    });

    my $schema = FotoDB::Schema->connect('dbi:SQLite:share/fotodb-schema.db');
    $self->helper(db => sub { return $schema; });
}

1;
