use strict;
use Test::More tests => 8;
use Linux::Statistics;

my %DiskStats = (
   Major => undef,
   Minor => undef,
   ReadRequests => undef,
   ReadBytes => undef,
   WriteRequests => undef,
   WriteBytes => undef,
   TotalRequests => undef,
   TotalBytes => undef,
);

my $obj = Linux::Statistics->new(DiskStats => 1);
sleep(1);
my $stats = $obj->getStats;

for my $dev (keys %{$stats->{DiskStats}}) {
   ok(defined $stats->{DiskStats}->{$dev}->{$_}, "checking DiskStats $_") for keys %DiskStats;
   last; # we check only one device, that should be enough
}
