use strict;
use warnings;
use Data::Dumper;
use lib './lib';
use DBI;

my $sth;
my $ret;

my $dbh = DBI->connect('dbi:Crate:[127.0.0.1:4200]', '', '', { RaiseError => 1, AutoCommit => 1 });



my $tables = $dbh->crate_tables_list();
print Dumper $tables;

my $table = $dbh->crate_table_info("articles");
print Dumper $table;

my $structure = $dbh->crate_table_columns("articles");
print Dumper $structure;
