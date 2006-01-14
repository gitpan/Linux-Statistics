use strict;
use Test::More tests => 4;
use Linux::Statistics;

my %PgSwStats = (
   PageIn => undef,
   PageOut => undef,
   SwapIn => undef,
   SwapOut => undef,
);

my $obj = Linux::Statistics->new(PgSwStats => 1);
sleep(1);
my $stats = $obj->getStats;
ok(defined $stats->{PgSwStats}->{$_}, "checking PgSwStats $_") for keys %PgSwStats;
