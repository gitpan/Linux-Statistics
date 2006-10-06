#!/usr/bin/perl -w
use strict;
use Test::More tests => 5;
use Linux::Statistics;

my %DiskUsage = (
   Total => undef,
   Usage => undef,
   Free => undef,
   UsagePer => undef,
   MountPoint => undef,
);

my $obj = Linux::Statistics->new(DiskUsage => 1);
sleep(1);
my $stats = $obj->getStats;

for my $dev (keys %{$stats->{DiskUsage}}) {
   ok(defined $stats->{DiskUsage}->{$dev}->{$_}, "checking DiskUsage $_") for keys %DiskUsage;
   last; # we check only one device, that should be enough
}
