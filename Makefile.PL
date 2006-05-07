use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'              => 'Linux::Statistics',
    'VERSION_FROM'      => 'lib/Linux/Statistics.pm',
    'ABSTRACT_FROM'     => 'lib/Linux/Statistics.pm',
    'PREREQ_PM'         => {
        'Test::More'    => '0',
    }
);
