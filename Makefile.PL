use strict;
use 5.010001;
use ExtUtils::MakeMaker;
use DBI;
use DBI::DBD;

WriteMakefile(
    NAME              => 'DBD::Crate',
    VERSION_FROM      => 'lib/DBD/Crate.pm',
    ABSTRACT_FROM     => 'lib/DBD/Crate.pm',
    PREREQ_PM         => {
        'DBI'               => 1.50,
        'HTTP::Tiny'        => 0,
        'JSON::MaybeXS'     => 0,
        'Test::More'        => 0,
    },
    LICENSE        => 'perl',
    AUTHOR         => 'Mamod Mehyar <mamod.mehyar@gmail.com>',
    "TEST_REQUIRES" => {
        
    },
    META_MERGE => {
        resources => {
            repository => 'git://github.com/mamod/DBD-Crate.git',
            bugtracker => 'https://github.com/mamod/DBD-Crate/issues',
        }
    }
);

sub MY::postamble {
    return DBI::DBD::dbd_postamble(@_);
}
