use strict;
use Test::More tests => 7;
use Linux::Statistics;

my %ProcStats = (
   User => undef,
   Nice => undef,
   System => undef,
   Idle => undef,
   IOWait => undef,
   Total => undef,
   New => undef,
);

my $obj = Linux::Statistics->new(ProcStats => 1);
sleep(1);
my $stats = $obj->getStats;
ok(defined $stats->{ProcStats}->{$_}, "checking ProcStats $_") for keys %ProcStats;
