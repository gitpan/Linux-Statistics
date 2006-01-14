use strict;
use Test::More tests => 12;
use Linux::Statistics;

my %SysInfo = (
      Hostname => undef,
      Domain => undef,
      Kernel => undef,
      Release => undef,
      Version => undef,
      MemTotal => undef,
      SwapTotal => undef,
      CPU_Power => undef,
      CountCPUs => undef,
      ModelName => undef,
      Uptime => undef,
      IdleTime => undef,
);

my $obj = Linux::Statistics->new(SysInfo => 1);
my $stats = $obj->getStats;
ok(defined $stats->{SysInfo}->{$_}, "checking SysInfo $_") for keys %SysInfo;
