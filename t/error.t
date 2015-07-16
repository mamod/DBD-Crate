use strict;
use warnings;
use lib './lib';
use DBI;
use DBD::Crate;
use Test::More;
use Data::Dumper;

my $dbh = DBI->connect('dbi:Crate:127.0.0.1:4200');
ok($dbh);
my $sth;

my $table_name = "my_crate_test_table_error";

{ #delete table
    $sth = $dbh->prepare("drop table if exists $table_name");
    $sth->execute();
}

{ #execute on unknown table
	$sth = $dbh->prepare("select * from $table_name");
	my $r = $sth->execute();
	ok(!$r);
	is($sth->err, 4041);
	is($sth->errstr, "SQLActionException[Table '$table_name' unknown]");
}

{
	$sth = $dbh->prepare("create table $table_name (id int primary key)");
	my $ret = $sth->execute();
	is($ret, 1);
	is($sth->errstr, undef);
}

{
	$sth = $dbh->prepare("create table $table_name (id int primary key)");
	my $ret = $sth->execute();
	is($ret, undef);
	is($sth->errstr, "SQLActionException[The table '$table_name' already exists.]");
	is($sth->err, 4093);
}

{ #create invalid table name

	$sth = $dbh->prepare("create table _XXY (id int primary key)");
	my $ret = $sth->execute();
	ok(!$ret);
	is($sth->err, 4002);
	is($sth->errstr, 'SQLActionException[table name "_xxy" is invalid.]');
}

{ #delete table
    $sth = $dbh->prepare("drop table if exists $table_name");
    $sth->execute();
}

done_testing(12);
