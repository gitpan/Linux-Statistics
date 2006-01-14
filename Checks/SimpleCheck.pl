#!/usr/bin/perl -w
use strict;
use Linux::Statistics;
use Data::Dumper;

my %Options = (
   11 => 'SysInfo',
   12 => 'ProcStats',
   13 => 'MemStats',
   14 => 'PgSwStats',
   15 => 'NetStats',
   16 => 'SockStats',
   17 => 'DiskStats',
   18 => 'DiskUsage',
   19 => 'LoadAVG',
   20 => 'FileStats',
   21 => 'Processes',
   22 => 'TimeStamp',
);

unless (@ARGV && $ARGV[0] =~ /^\d+$/ && $Options{$ARGV[0]}) {
   print "Usage: $0 <number>\n";
   print "$_ - $Options{$_}\n" for sort keys %Options;
   exit(1);
}

my $obj = Linux::Statistics->new( $Options{$ARGV[0]} => 1 );
sleep(1) if $Options{$ARGV[0]} =~ /^(ProcStats|PgSwStats|NetStats|DiskStats|Processes)$/;
my $stats = $obj->getStats;

print Dumper($stats);
