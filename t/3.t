use strict;
use Test::More tests => 10;
use Linux::Statistics;

my %MemStats = (
   MemUsed => undef,
   MemFree => undef,
   MemUsedPer => undef,
   MemTotal => undef,
   Buffers => undef,
   Cached => undef,
   SwapUsed => undef,
   SwapFree => undef,
   SwapUsedPer => undef,
   SwapTotal => undef,
);

my $obj = Linux::Statistics->new(MemStats => 1);
my $stats = $obj->getStats;
ok(defined $stats->{MemStats}->{$_}, "checking MemStats $_") for keys %MemStats;
