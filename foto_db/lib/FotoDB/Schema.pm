package FotoDB::Schema;

# based on the DBIx::Class Schema base class
use base qw/DBIx::Class::Schema/;

# This will load any classes within
# FotoDB::Schema::Result and FotoDB::Schema::ResultSet (if any)
__PACKAGE__->load_namespaces();

# DSN syntax
# dbi:DriverName:database=database_name;host=hostname;port=port
# For SQLite:
my $schema = FotoDB::Schema->connect('dbi:SQLite:fotodb.db');

my $rs = $schema->resultset('Post');

# adding a post to the database
# INSERT INTO posts (author, title, content, date_published) VALUES ('first', ...)
    $rs->create({
        author  => 'Max First',
        title   => 'Some interesting story',
        content => 'This really is interesting ...',
    });

# searching for posts
# SELECT * FROM posts WHERE author = 'Max First';
my $query_rs = $rs->search({ author => 'Max First' });

my $first = $query_rs->first;
print $first->title;

# Iterate all posts by this author
while (my $post = $rs->next) {
    print $post->title;
}

# updating a post
my $first = $rs->first;

# UPDATE posts SET author = "Max Peter Jr." WHERE id = 1
$first->update({ firstname => 'Max Peter Jr.'});

# deleting posts
# SELECT * FROM posts WHERE id IN (1, 2, 3, .., 10)
my $delete_rs = $rs->search({ id => { '-in' => [ 1 .. 10] } });

# How many are we going to delete
print $delete_rs->count;

$delete_rs->delete;


1;
