use strict;
use Test::More tests => 10;
use Linux::Statistics;

my %SysInfo = (
      Hostname => undef,
      Domain => undef,
      Kernel => undef,
      Release => undef,
      Version => undef,
      MemTotal => undef,
      SwapTotal => undef,
      CountCPUs => undef,
      Uptime => undef,
      IdleTime => undef,
);

my $obj = Linux::Statistics->new(SysInfo => 1);
my $stats = $obj->getStats;
ok(defined $stats->{SysInfo}->{$_}, "checking SysInfo $_") for keys %SysInfo;
