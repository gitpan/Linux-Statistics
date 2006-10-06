use strict;
use Test::More tests => 5;
use Linux::Statistics;

my %LoadAVG = (
   AVG_1 => undef,
   AVG_5 => undef,
   AVG_15 => undef,
   RunQueue => undef,
   Count => undef,
);

my $obj = Linux::Statistics->new(LoadAVG => 1);
my $stats = $obj->getStats;
ok(defined $stats->{LoadAVG}->{$_}, "checking LoadAVG $_") for keys %LoadAVG;
