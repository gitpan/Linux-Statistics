use strict;
use Test::More tests => 5;
use Linux::Statistics;

my %SockStats = (
   Used => undef,
   Tcp => undef,
   Udp => undef,
   Raw => undef,
   IpFrag => undef,
);

my $obj = Linux::Statistics->new(SockStats => 1);
my $stats = $obj->getStats;
ok(defined $stats->{SockStats}->{$_}, "checking SockStats $_") for keys %SockStats;
