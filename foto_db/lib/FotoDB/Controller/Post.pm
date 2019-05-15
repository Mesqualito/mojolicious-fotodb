package FotoDB::Post;
use Mojo::Base 'Mojolicious::Controller';
use DateTime;

sub create {
    my $self = shift;

    # Grab the request parameters
    my $title = $self->param('title');
    my $content = $self->param('content');

    # Persist the post
    $self->db->resultset('Post')->create({
        title          => $title,
        content        => $content,

        # Use the username as author name for now
        author         => $self->session('username'),

        # Published now
        date_published => DateTime->now->iso8601,
    });

    # provide a way to send messages to the next request through the session cookie:
    $self->flash(post_saved => 1);

    $self->redirect_to('restricted_area');

}

sub delete {
    my $self = shift;

    my $posts = $self->db->resultset('Post');
    $self->app->log->info($self->stash('id'));
    $posts->search({ id => $self->stash('id') })->delete;

    $self->flash(post_deleted => '1');
    $self->redirect_to('restricted_area');
}

1;
