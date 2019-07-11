use Mojolicious::Lite;

get '/:name' => {name => '🌍 world!'} => sub {
	my $c = shift;
	$c->stash(inline => 'Hello <%= $name %>');
};

app->start;
