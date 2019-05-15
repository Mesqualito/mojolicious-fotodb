package FotoDB::Login;
use Mojo::Base 'Mojolicious::Controller';

# Mocked function to check the correctness
# of a username/password combination.
sub user_exists {
    my ($username, $password) = @_;

    return ($username eq 'foo' && $password eq 'bar');
}

# Called upon form submit
sub on_user_login {
    my $self = shift;

    # Grab the request parameters
    my $username = $self->param('username');
    my $password = $self->param('password');

    return $self->render(text => 'Logged in!')
        if (user_exists($username, $password);

    return $self->render(text => 'Wrong username/password', status => 403);
}

1;
