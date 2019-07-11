use Mojolicious::Lite;

get '/' => {text => 'Hello World!'} => sub {
	my $c = shift;
	$c->render;
};

app->start;
