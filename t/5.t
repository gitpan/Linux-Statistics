use strict;
use Test::More tests => 16;
use Linux::Statistics;

my %NetStats = (
   RxBytes => undef,
   RxPackets => undef,
   RxErrs => undef,
   RxDrop => undef,
   RxFifo => undef,
   RxFrame => undef,
   RxCompr => undef,
   RxMulti => undef,
   TxBytes => undef,
   TxPacktes => undef,
   TxErrs => undef,
   TxDrop => undef,
   TxFifo => undef,
   TxColls => undef,
   TxCarr => undef,
   TxCompr => undef,
);

my $obj = Linux::Statistics->new(NetStats => 1);
sleep(1);
my $stats = $obj->getStats;

for my $dev (keys %{$stats->{NetStats}}) {
   ok(defined $stats->{NetStats}->{$dev}->{$_}, "checking NetStats $_") for keys %NetStats;
   last; # we check only one device, that should be enough
}
