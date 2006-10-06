use strict;
use Test::More tests => 10;
use Linux::Statistics;

my %FileStats = (
   fhAlloc => undef,
   fhFree => undef,
   fhMax => undef,
   inAlloc => undef,
   inFree => undef,
   inMax => undef,
   Dentries => undef,
   Unused => undef,
   AgeLimit => undef,
   WantPages => undef,
);

my $obj = Linux::Statistics->new(FileStats => 1);
my $stats = $obj->getStats;
ok(defined $stats->{FileStats}->{$_}, "checking FileStats $_") for keys %FileStats;
