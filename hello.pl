use Mojolicious::Lite;

get '/' => sub {
	my $c = shift;
	$c->stash(text => 'Hello 🌍 World!');
	$c->render;
};

app->start;
