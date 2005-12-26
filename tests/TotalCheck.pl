#!/usr/bin/perl -w
use strict;
use Linux::Statistics;

my %options = (
   'SysInfo' => {
      'Hostname' => undef,
      'Domain' => undef,
      'Kernel' => undef,
      'Release' => undef,
      'Version' => undef,
      'MemTotal' => undef,
      'SwapTotal' => undef,
      'CPU_Power' => undef,
      'CountCPUs' => undef,
      'ModelName' => undef,
      'Uptime' => undef,
      'IdleTime' => undef,
   },
   'ProcStats' => {
      'User' => undef,
      'Nice' => undef,
      'System' => undef,
      'Idle' => undef,
      'IOWait' => undef,
      'Total' => undef,
      'New' => undef,
   },
   'MemStats' => {
      'MemUsed' => undef,
      'MemFree' => undef,
      'MemUsedPro' => undef,
      'MemTotal' => undef,
      'Buffers' => undef,
      'Cached' => undef,
      'SwapUsed' => undef,
      'SwapFree' => undef,
      'SwapUsedPro' => undef,
      'SwapTotal' => undef,
   },
   'PgSwStats' => {
      'PageIn' => undef,
      'PageOut' => undef,
      'SwapIn' => undef,
      'SwapOut' => undef,
   },
   'NetStats' => {
      'RxBytes' => undef,
      'RxPackets' => undef,
      'RxErrs' => undef,
      'RxDrop' => undef,
      'RxFifo' => undef,
      'RxFrame' => undef,
      'RxCompr' => undef,
      'RxMulti' => undef,
      'TxBytes' => undef,
      'TxPacktes' => undef,
      'TxErrs' => undef,
      'TxDrop' => undef,
      'TxFifo' => undef,
      'TxColls' => undef,
      'TxCarr' => undef,
      'TxCompr' => undef,
   },
   'SockStats' => {
      'Used' => undef,
      'Tcp' => undef,
      'Udp' => undef,
      'Raw' => undef,
      'IpFrag'     => undef,
   },
   'DiskStats' => {
      'Major' => undef,
      'Minor' => undef,
      'ReadRequests' => undef,
      'ReadBytes' => undef,
      'WriteRequests' => undef,
      'WriteBytes' => undef,
      'TotalRequests' => undef,
      'TotalBytes' => undef,
   },
   'DiskUsage' => {
      'Total' => undef,
      'Usage' => undef,
      'Free' => undef,
      'UsagePro' => undef,
      'MountPoint' => undef,
   },
   'LoadAVG' => {
      'AVG_1' => undef,
      'AVG_5' => undef,
      'AVG_15' => undef,
      'RunQueue' => undef,
      'Count' => undef,
   },
   'Processes' => {
      'PPid' => undef,
      'Owner' => undef,
      'State' => undef,
      'PGrp' => undef,
      'Session' => undef,
      'TTYnr' => undef,
      'MinFLT' => undef,
      'CMinFLT' => undef,
      'MayFLT' => undef,
      'CMayFLT' => undef,
      'CUTime' => undef,
      'STime' => undef,
      'UTime' => undef,
      'CSTime' => undef,
      'Prior' => undef,
      'Nice' => undef,
      'StartTime' => undef,
      'ActiveTime' => undef,
      'VSize' => undef,
      'NSwap' => undef,
      'CNSwap' => undef,
      'CPU' => undef,
      'Size' => undef,
      'Resident' => undef,
      'Share' => undef,
      'TRS' => undef,
      'DRS' => undef,
      'LRS' => undef,
      'DT' => undef,
      'Comm' => undef,
      'CMDLINE' => undef,
      'Pid' => undef,
   },
   'TimeStamp' => {
      'Date' => undef,
      'Time' => undef,
   },
);

my $err = 0;
my $ok  = 0;

for my $opt (sort keys %options) {
   my $obj = Linux::Statistics->new( $opt => 1 );
   sleep(1);
   my $stats = $obj->getStats;

   if ($opt =~ /SysInfo|ProcStats|MemStats|PgSwStats|SockStats|LoadAVG|TimeStamp/) {
      for my $key (keys %{$options{$opt}}) {
         print "$opt:$key" . ' ' x (30-length("$opt:$key"));

         if (defined $stats->{$opt}->{$key} && $stats->{$opt}->{$key} =~ /./) {
            print "... ok\n";
            $ok++;
         }
         else {
            print "... false\n" unless $key eq 'Domain';
            print "... false ... or /proc/sys/kernel/domainname could be empty\n" if $key eq 'Domain';
            $err++;
         }
      }
   }
   elsif ($opt =~ /NetStats|DiskStats|DiskUsage|Processes/) {
      for my $dev (keys %{$stats->{$opt}}) {
         for my $key (keys %{$options{$opt}}) {
            print "$opt:$key" . ' ' x (30-length("$opt:$key"));

            if (defined $stats->{$opt}->{$dev}->{$key} && $stats->{$opt}->{$dev}->{$key} =~ /./) {
               print "... ok\n";
               $ok++;
            }
            else {
               print "... false\n";
               $err++;
            }
         }

         # we test just one device/disk/pid, that should be enough ...

         last;
      }
   }
   else {
      die "That's bad, detected errors in test.pl script ... $opt not found";
   }
}

printf "\nTests %d/%d failed\n", $err, $err+$ok;
