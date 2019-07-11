use Mojolicious::Lite;

get '/:name' => {name => '🌍 world!'} => sub {
	my $c = shift;
	$c->render('hello');
};

app->start;

__DATA__

@@ hello.html.ep
Hello <%= $name %>
