use strict;
use warnings;
use Linux::Statistics;

my $test  = 0;
my $stats = {};

$stats = getStats( SysInfo   => 1 ) or $test++;
$stats = getStats( ProcStats => 1 ) or $test++;
$stats = getStats( MemStats  => 1 ) or $test++;
$stats = getStats( PgSwStats => 1 ) or $test++;
$stats = getStats( NetStats  => 1 ) or $test++;
$stats = getStats( SockStats => 1 ) or $test++;
$stats = getStats( DiskStats => 1 ) or $test++;
$stats = getStats( DiskUsage => 1 ) or $test++;
$stats = getStats( LoadAVG   => 1 ) or $test++;
$stats = getStats( Processes => 1 ) or $test++;
$stats = getStats( TimePoint => 1 ) or $test++;

print "Tests $test/11 failed\n";
