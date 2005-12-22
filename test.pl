#!/usr/bin/perl -w
use strict;
#use warnings;
use Linux::Statistics;

my %options = (
   'SysInfo' => {
      'SysHostname' => undef,
      'SysDomain' => undef,
      'SysKernel' => undef,
      'SysRelease' => undef,
      'SysVersion' => undef,
      'SysMemTotal' => undef,
      'SysSwapTotal' => undef,
      'SysCPU_Power' => undef,
      'SysCountCPUs' => undef,
      'SysModelName' => undef,
      'SysUptime' => undef,
      'SysIdleTime' => undef,
   },
   'ProcStats' => {
      'ProcUser' => undef,
      'ProcNice' => undef,
      'ProcSystem' => undef,
      'ProcIdle' => undef,
      'ProcIOWait' => undef,
      'ProcTotal' => undef,
      'ProcNew' => undef,
   },
   'MemStats' => {
      'MemUsed' => undef,
      'MemFree' => undef,
      'MemUsedPro' => undef,
      'MemTotal' => undef,
      'MemBuffers' => undef,
      'MemCached' => undef,
      'MemSwapUsed' => undef,
      'MemSwapFree' => undef,
      'MemSwapUsedPro' => undef,
      'MemSwapTotal' => undef,
   },
   'PgSwStats' => {
      'PageIn' => undef,
      'PageOut' => undef,
      'SwapIn' => undef,
      'SwapOut' => undef,
   },
   'NetStats' => {
      'NetRxBytes' => undef,
      'NetRxPackets' => undef,
      'NetRxErrs' => undef,
      'NetRxDrop' => undef,
      'NetRxFifo' => undef,
      'NetRxFrame' => undef,
      'NetRxCompr' => undef,
      'NetRxMulti' => undef,
      'NetTxBytes' => undef,
      'NetTxPacktes' => undef,
      'NetTxErrs' => undef,
      'NetTxDrop' => undef,
      'NetTxFifo' => undef,
      'NetTxColls' => undef,
      'NetTxCarr' => undef,
      'NetTxCompr' => undef,
   },
   'SockStats' => {
      'SockTcpSockets' => undef,
      'SockUdpSockets' => undef,
      'SockRawSockets' => undef,
      'SockTotalSockets' => undef,
   },
   'DiskStats' => {
      'DiskMajor' => undef,
      'DiskMinor' => undef,
      'DiskReadRequests' => undef,
      'DiskReadBytes' => undef,
      'DiskWriteRequests' => undef,
      'DiskWriteBytes' => undef,
      'DiskTotalRequests' => undef,
      'DiskTotalBytes' => undef,
   },
   'DiskUsage' => {
      'DiskU_Total' => undef,
      'DiskU_Usage' => undef,
      'DiskU_Free' => undef,
      'DiskU_UsagePro' => undef,
      'DiskU_MountPoint' => undef,
   },
   'LoadAVG' => {
      'ProcAVG_1' => undef,
      'ProcAVG_5' => undef,
      'ProcAVG_15' => undef,
      'ProcRunQueue' => undef,
      'ProcCount' => undef,
   },
   'Processes' => {
      'sProcPPid' => undef,
      'sProcOwner' => undef,
      'sProcState' => undef,
      'sProcPGrp' => undef,
      'sProcSession' => undef,
      'sProcTTYnr' => undef,
      'sProcMinFLT' => undef,
      'sProcCMinFLT' => undef,
      'sProcMayFLT' => undef,
      'sProcCMayFLT' => undef,
      'sProcCUTime' => undef,
      'sProcSTime' => undef,
      'sProcUTime' => undef,
      'sProcCSTime' => undef,
      'sProcPrior' => undef,
      'sProcNice' => undef,
      'sProcStartTime' => undef,
      'sProcVSize' => undef,
      'sProcNSwap' => undef,
      'sProcCNSwap' => undef,
      'sProcProc' => undef,
      'sProcSize' => undef,
      'sProcResident' => undef,
      'sProcShare' => undef,
      'sProcTRS' => undef,
      'sProcDRS' => undef,
      'sProcLRS' => undef,
      'sProcDT' => undef,
      'sProcComm' => undef,
      'sProcCMDLINE' => undef,
      'sProcPid' => undef,
   },
   'TimePoint' => {
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

   if ($opt =~ /SysInfo|ProcStats|MemStats|PgSwStats|SockStats|LoadAVG|TimePoint/) {
      for my $key (keys %{$options{$opt}}) {
         print "$opt:$key" . ' ' x (30-length("$opt:$key"));

         if (defined $stats->{$opt}->{$key} && $stats->{$opt}->{$key} =~ /./) {
            print "... ok\n";
            $ok++;
         }
         else {
            print "... false\n" unless $key eq 'SysDomain';
            print "... false ... or /proc/sys/kernel/domainname could be empty\n" if $key eq 'SysDomain';
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
