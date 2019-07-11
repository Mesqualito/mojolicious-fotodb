use Mojolicious::Lite;

get '/:name' => {name => '🌍 world!'} => sub {
	my $c = shift;
	my $name = $c->stash('name');
	$c->stash(text => "Hello $name!")
};

app->start;
