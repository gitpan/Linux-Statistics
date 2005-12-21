=head1 NAME

Linux::Statistics - collect system statistics

=head1 SYNOPSIS

use Linux::Statistics;

$stats = getStats( SysInfo   => 1,
                   ProcStats => 1,
                   MemStats  => 1,
                   PgSwStats => 1,
                   NetStats  => 1,
                   SockStats => 1,
                   DiskStats => 1,
                   DiskUsage => 1,
                   LoadAVG   => 1,
                   Processes => 1,
                   TimePoint => 1 );

=head1 DESCRIPTION

This module collects system statistics like processor workload, memory usage and other
system informations from the /proc filesystem. It is tested on x86 hardware with the
distributions SuSE, SLES (s390 and s390x), Red Hat, Debian and Mandrake on kernel versions
2.4 and 2.6 but it should also running on other linux distributions with the same kernel
release number. To run this module it is necessary to start it as root or another user
with the authorization to read the /proc filesystem and the /etc/passwd file.

=head1 OPTIONS

Each option returns a hash reference with the collected system informations.

=head2 SysInfo

Generated from I</proc/sys/kernel/hostname> *domainname *ostype *osrelease *version
and I</proc/sysinfo>, I</proc/cpuinfo>, I</proc/meminfo>, I</proc/uptime>.

   SysHostname           -  This is the host name.
   SysDomain             -  This is the host domain name.
   SysKernel             -  This is the kernel name.
   SysRelease            -  This is the release number.
   SysVersion            -  This is the version number.
   SysMemTotal           -  The total size of memory.
   SysSwapTotal          -  The total size of swap space.
   SysCPU_Power          -  The power of the CPUs in mhz or bogomips.
   SysCountCPUs          -  The total number of CPUs.
   SysModelName          -  The model name.
   SysUptime             -  This is the uptime of the system.
   SysIdleTime           -  This is the idle time of the system idletime.

=head2 ProcStats

Generated from I</proc/stat>.

   ProcUser              -  Percentage of CPU utilization at the user level.
   ProcNice              -  Percentage of CPU utilization at the user level with nice priority.
   ProcSystem            -  Percentage of CPU utilization at the system level.
   ProcIdle              -  Percentage of time the CPU is in idle state.
   ProcIOWait            -  Percentage of time the CPU is in idle state because an i/o operation is waiting for a disk.
   ProcTotal             -  Total percentage of CPU utilization at user and system level.
   ProcNew               -  Number of new processes that were produced per second.

=head2 MemStats

Generated from I</proc/meminfo>.

   MemUsed               -  Total size of used memory in kilobytes.
   MemFree               -  Total size of free memory in kilobytes.
   MemUsedPro            -  Total size of used memory in percent.
   MemTotal              -  Total size of memory in kilobytes.
   MemBuffers            -  Total size of buffers used from memory in kilobytes.
   MemCached             -  Total size of cached memory in kilobytes.
   MemSwapUsed           -  Total size of swap space is used is kilobytes.
   MemSwapFree           -  Total size of swap space is free in kilobytes.
   MemSwapUsedPro        -  Total size of swap space is used in percent.
   MemSwapTotal          -  Total size of swap space in kilobytes.

=head2 PgSwStats

Generated from I</proc/stat> or I</proc/vmstat>.

   PageIn                -  Number of kilobytes the system has paged in from disk per second.
   PageOut               -  Number of kilobytes the system has paged out to disk per second.
   SwapIn                -  Number of kilobytes the system has swapped in from disk per second.
   SwapOut               -  Number of kilobytes the system has swapped out to disk per second.

=head2 NetStats

Generated from I</proc/net/dev>.

   NetRxBytes            -  Number of bytes received per second.
   NetRxPackets          -  Number of packets received per second.
   NetRxErrs             -  Number of errors that happend per second while received packets.
   NetRxDrop             -  Number of packets that were dropped per second.
   NetRxFifo             -  Number of FIFO overruns that happend per second on received packets.
   NetRxFrame            -  Number of carrier errors that happend per second on received packets.
   NetRxCompr            -  Number of compressed packets received per second.
   NetRxMulti            -  Number of multicast packets received per second.
   NetTxBytes            -  Number of bytes transmitted per second.
   NetTxPacktes          -  Number of packets transmitted per second.
   NetTxErrs             -  Number of errors that happend while transmitting packets.
   NetTxDrop             -  Number of packets that were dropped per second.
   NetTxFifo             -  Number of FIFO overruns that happend per second on transmitted packets.
   NetTxColls            -  Number of collisions that were detected.
   NetTxCarr             -  Number of carrier errors that happend per second on transmitted packets.
   NetTxCompr            -  Number of compressed packets transmitted per second.

=head2 NetSumStats

   This are just some summaries of NetStats.

   NetRxBytes            -  Total number of bytes received per second.
   NetTxBytes            -  Total number of bytes transmitted per second.

=head2 SockStats

Generated from I</proc/net/sockstat>.

   SockTcpSockets        -  Number of tcp sockets in use.
   SockUdpSockets        -  Number of udp sockets in use.
   SockRawSockets        -  Number of raw sockets in use.
   SockTotalSockets      -  Total number of sockets in use.

=head2 DiskStats

Generated from I</proc/diskstats> or I</proc/partitions>.

   DiskMajor             -  The mayor number of the disk
   DiskMinor             -  The minor number of the disk
   DiskReadRequests      -  Number of read requests that were made per second to physical disk.
   DiskReadBytes         -  Number of bytes that were read per second from physical disk.
   DiskWriteRequests     -  Number of write requests that were made per second to physical disk.
   DiskWriteBytes        -  Number of bytes that were written per second to physical disk.
   DiskTotalRequests     -  Total number of requests were made per second from/to physical disk.
   DiskTotalBytes        -  Total number of bytes transmitted per second from/to physical disk.

=head2 DiskSumStats

   This are just some summaries of DiskStats.

   DiskSumReadRequests   -  Total number of read requests were made per second to all physical disks.
   DiskSumReadBytes      -  Total number of bytes reads per second from all physical disks.
   DiskSumWriteRequests  -  Total number of write requests were made per second to all physical disks.
   DiskSumWriteBytes     -  Total number of bytes written per second to all physical disks.
   DiskSumRequests       -  Total number of requests were made per second from/to all physical disks.
   DiskSumBytes          -  Total number of bytes transmitted per second from/to all physical disks.

=head2 DiskUsage

Generated with I</bin/df -k>.

   DiskU_Total           -  The total size of the disk.
   DiskU_Usage           -  The used disk space in kilobytes.
   DiskU_Free            -  The free disk space in kilobytes.
   DiskU_UsagePro        -  The used disk space in percent.
   DiskU_MountPoint      -  The moint point of the disk.
   DiskU_Name            -  The disk name.

=head2 LoadAVG

Generated with I</proc/loadavg>.

   ProcAVG_1             -  The average processor workload of the last minute.
   ProcAVG_5             -  The average processor workload of the last five minutes.
   ProcAVG_15            -  The average processor workload of the last fifteen minutes.
   ProcRunQueue          -  The number of processes waiting for runtime.
   ProcCount             -  The total amount of processes on the system.

=head2 Processes

Generated with I</proc/E<lt>numberE<gt>/statm>, I</proc/E<lt>numberE<gt>/stat>, I</proc/E<lt>numberE<gt>/status>, I</proc/E<lt>numberE<gt>/cmdline> and I</etc/passwd>.

   sProcPPid             -  The parent process ID of the process.
   sProcOwner            -  The owner name of the process.
   sProcState            -  The status of the process.
   sProcPGrp             -  The group ID of the process.
   sProcSession          -  The session ID of the process.
   sProcTTYnr            -  The tty the process use.
   sProcMinFLT           -  The number of minor faults the process made per second.
   sProcCMinFLT          -  The number of minor faults the child process made per second.
   sProcMayFLT           -  The number of mayor faults the process made per second.
   sProcCMayFLT          -  The number of mayor faults the child process made per second.
   sProcCUTime           -  The number of jiffies the process waited for childrens have been scheduled in user mode.
   sProcSTime            -  The number of jiffies the process have beed scheduled in kernel mode.
   sProcUTime            -  The number of jiffies the process have beed scheduled in user mode.
   sProcCSTime           -  The number of jiffies the process waited for childrens have been scheduled in kernel mode.
   sProcPrior            -  The priority of the process (+15).
   sProcNice             -  The nice level of the process.
   sProcStartTime        -  The time in jiffies the process started after system boot.
   sProcVSize            -  The size of virtual memory of the process.
   sProcNSwap            -  The size of swap space of the process.
   sProcCNSwap           -  The size of swap space of the childrens of the process.
   sProcProc             -  The CPU number the process was last executed on.
   sProcSize             -  The total program size of the process.
   sProcResident         -  Number of resident set size, this includes the text, data and stack space.
   sProcShare            -  Total size of shared pages of the process.
   sProcTRS              -  Total text size of the process.
   sProcDRS              -  Total data/stack size of the process.
   sProcLRS              -  Total library size of the process.
   sProcDT               -  Total size of dirty pages of the process (unused since kernel 2.6).
   sProcComm             -  Command of the process.
   sProcCMDLINE          -  Command line of the process.
   sProcPid              -  The process ID.

=head2 TimePoint

Generated with I<localtime(time)>.

   Date                  -  The current date.
   Time                  -  The current time.

=head1 EXAMPLES

=head4 A very simple perl script could looks like this:

         #!/usr/bin/perl -w
         use strict;
         use Linux::Statistics;

         my $stats = getStats( ProcStats => 1 );

         print "Report/Statistic for ProcStats\n";
         print "  ProcUser      $stats->{'ProcStats'}->{'ProcUser'}\n";
         print "  ProcNice      $stats->{'ProcStats'}->{'ProcNice'}\n";
         print "  ProcSystem    $stats->{'ProcStats'}->{'ProcSystem'}\n";
         print "  ProcIdle      $stats->{'ProcStats'}->{'ProcIdle'}\n";
         print "  ProcIOWait    $stats->{'ProcStats'}->{'ProcIOWait'}\n";
         print "  ProcTotal     $stats->{'ProcStats'}->{'ProcTotal'}\n";
         print "  ProcNew       $stats->{'ProcStats'}->{'ProcNew'}\n";

=head4 Or this:

         #!/usr/bin/perl -w
         use strict;
         use Linux::Statistics;

         my $stats = getStats( NetStats => 1 );

         foreach my $device (keys %{$stats->{'NetStats'}}) {
            print "Statistics for device $device ...\n";

            while (my ($key,$value) = each %{$stats->{'NetStats'}->{$device}}) {
               print ' ' x 2 . "$key" . ' ' x (30-length($key)) . "$value\n";
            }
         }

         print "\nTotal network statistics ...\n";

         while (my ($key,$value) = each %{$stats->{'NetSumStats'}}) {
            print ' ' x 2 . "$key" . ' ' x (30-length($key)) . "$value\n";
         }

=head4 This also:

         #!/usr/bin/perl -w
         use strict;
         use Linux::Statistics;

         my $stats = getStats( Processes => 1 );

         # print a formated header

         print "$_". ' ' x (12-length($_)) for qw/PID PPID OWNER STATE SIZE VSIZE COMMAND/;
         print "\n";

         foreach my $pid (keys %{$stats->{'Processes'}}) {
            print "$stats->{'Processes'}->{$pid}->{$_}". ' ' x (12-length($stats->{'Processes'}->{$pid}->{$_}))
               for qw/sProcPid sProcPPid sProcOwner sProcState sProcSize sProcVSize sProcCMDLINE/;
            print "\n";
         }

=head4 It is also possible to create a hash reference with options.

      $options = {
         SysInfo   => 1,
         ProcStats => 1,
         MemStats  => 1,
         PgSwStats => 1,
         NetStats  => 1,
         SockStats => 1,
         DiskStats => 1,
         DiskUsage => 1,
         LoadAVG   => 1,
         Processes => 1,
         TimePoint => 1
      };

      $stats = getStats( $options );

=head4 If you're not sure you can use the the Data::Dumper module to learn more about the hash structure.

         #!/usr/bin/perl -w
         use strict;
         use Linux::Statistics;
         use Data::Dumper;

         my $stats = getStats( Processes => 1 );

         print Dumper($stats);

=head4 Have a lot of fun with this module :-)

=head1 SEE ALSO

The manpage of proc(5) or I</usr/src/linux/Documentation/filesystems/proc.txt>.

=head1 AUTHOR

Jonny Schulz. Please report all bugs to <jschulz@bloonix.de>.

=head1 COPYRIGHT

Copyright (c) 2005, 2006 by Jonny Schulz. All rights reserved.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

package Linux::Statistics;

use strict;
require Exporter;
our @ISA     = qw(Exporter);
our @EXPORT  = qw(getStats);
our $VERSION = '1.00';

# Disk statictics are since 2.4 kernel found in /proc/partitions, but since
# kernel 2.6 this statistics are now in /proc/diskstats. Further the paging
# and swapping statistics are no more in /proc/stat but also in /proc/vmstat.
# Here are now all neccessary files for this module.

my %file = (
   'passwd'     => '/etc/passwd',
   'procdir'    => '/proc',
   'stats'      => '/proc/stat',
   'meminfo'    => '/proc/meminfo',
   'sysinfo'    => '/proc/sysinfo',
   'cpuinfo'    => '/proc/cpuinfo',
   'vmstat'     => '/proc/vmstat',
   'loadavg'    => '/proc/loadavg',
   'sockstats'  => '/proc/net/sockstat',
   'netstats'   => '/proc/net/dev',
   'diskstats'  => '/proc/diskstats',
   'partitions' => '/proc/partitions',
   'uptime'     => '/proc/uptime',
   'hostname'   => '/proc/sys/kernel/hostname',
   'domain'     => '/proc/sys/kernel/domainname',
   'kernel'     => '/proc/sys/kernel/ostype',
   'release'    => '/proc/sys/kernel/osrelease',
   'version'    => '/proc/sys/kernel/version',
);

# The sectors are equivalent with blocks and have a size of 512 bytes since 2.4
# kernels. This value is needed to calculate the amount of disk i/o's in bytes.

my $block_size = 512;

# This function collects all statistic informations and return the data as a hash reference.

sub getStats {

   my %param;

   if (ref $_[0] eq 'HASH') {
      %param = %{$_[0]};
   }
   elsif (@_ & 1) {
      die 'Statistics: not enough arguments ...';
   }
   else {
      %param = @_;
   }

   my $t_stats = {};
   my $stats   = {};

   # set a time stamp for the statistics

   if ($param{'TimePoint'}) {
      my @tm = (localtime)[reverse 0..5];

      $tm[0] += 1900;
      $tm[1]++;

      $stats->{'TimePoint'}->{'Time'} = sprintf '%02d:%02d:%02d', @tm[0..2];
      $stats->{'TimePoint'}->{'Date'} = sprintf '%04d-%02d-%02d', @tm[3..5];
   }

   # get the statistics

   foreach my $opt (qw/SysInfo MemStats SockStats DiskUsage LoadAVG Processes/) {
      no strict 'refs';
      $stats->{$opt} = &$opt() if $param{$opt};
   }

   # some statistics must run twice because the differences are needed

   $t_stats->{'ProcStats'} = ProcStats() if $param{'ProcStats'};
   $t_stats->{'PgSwStats'} = PgSwStats() if $param{'PgSwStats'};

   ($t_stats->{'NetStats'},$t_stats->{'NetSumStats'})   = NetStats()  if $param{'NetStats'};
   ($t_stats->{'DiskStats'},$t_stats->{'DiskSumStats'}) = DiskStats() if $param{'DiskStats'};

   # wait a second until the next step

   sleep(1) if %{$t_stats};

   # now we calculate the difference

   if ($param{'ProcStats'}) {
      $stats->{'ProcStats'} = ProcStats();

      foreach my $x (keys %{$stats->{'ProcStats'}}) {
         $stats->{'ProcStats'}->{$x} -= $t_stats->{'ProcStats'}->{$x};
      }

      foreach (qw/ProcUser ProcNice ProcSystem ProcIdle ProcIOWait/) {
         $stats->{'ProcStats'}->{$_} = sprintf('%.2f',100 * $stats->{'ProcStats'}->{$_} / $stats->{'ProcStats'}->{'Uptime'});
      }

      $stats->{'ProcStats'}->{'ProcTotal'} = $stats->{'ProcStats'}->{'ProcUser'} + $stats->{'ProcStats'}->{'ProcNice'} + $stats->{'ProcStats'}->{'ProcSystem'};
      delete $stats->{'ProcStats'}->{'Uptime'};
   }

   if ($param{'PgSwStats'}) {
      $stats->{'PgSwStats'} = PgSwStats();

      foreach my $x (keys %{$stats->{'PgSwStats'}}) {
         $stats->{'PgSwStats'}->{$x} -= $t_stats->{'PgSwStats'}->{$x};
      }
   }

   if ($param{'NetStats'}) {
      ($stats->{'NetStats'},$stats->{'NetSumStats'}) = NetStats();

      foreach my $x (keys %{$stats->{'NetStats'}}) {
         foreach my $y (keys %{$stats->{'NetStats'}->{$x}}) {
            $stats->{'NetStats'}->{$x}->{$y} -= $t_stats->{'NetStats'}->{$x}->{$y};
         }
      }

      foreach my $x (keys %{$stats->{'NetSumStats'}}) {
         $stats->{'NetSumStats'}->{$x} -= $t_stats->{'NetSumStats'}->{$x};
      }
   }

   if ($param{'DiskStats'}) {
      ($stats->{'DiskStats'},$stats->{'DiskSumStats'}) = DiskStats();

      foreach my $x (keys %{$stats->{'DiskStats'}}) {
         foreach my $y (keys %{$stats->{'DiskStats'}->{$x}}) {
            $stats->{'DiskStats'}->{$x}->{$y} -= $t_stats->{'DiskStats'}->{$x}->{$y};
         }
      }

      foreach my $x (keys %{$stats->{'DiskSumStats'}}) {
         $stats->{'DiskSumStats'}->{$x} -= $t_stats->{'DiskSumStats'}->{$x};
      }
   }

   return $stats if $stats;
   return undef;
}

sub SysInfo {
   my %sys;
   $sys{'SysHostname'} = <FH> if open(FH,"<$file{'hostname'}") or die "Statistics: can't open $file{'hostname'}";
   $sys{'SysDomain'}   = <FD> if open(FD,"<$file{'domain'}")   or die "Statistics: can't open $file{'domain'}";
   $sys{'SysKernel'}   = <FK> if open(FK,"<$file{'kernel'}")   or die "Statistics: can't open $file{'kernel'}";
   $sys{'SysRelease'}  = <FR> if open(FR,"<$file{'release'}")  or die "Statistics: can't open $file{'release'}";
   $sys{'SysVersion'}  = <FV> if open(FV,"<$file{'version'}")  or die "Statistics: can't open $file{'version'}";
   my $uptime          = <FU> if open(FU,"<$file{'uptime'}")   or die "Statistics: can't open $file{'uptime'}";

   open(FM,"<$file{'meminfo'}") or die "Statistics: can't open $file{'meminfo'}\n";

   while (<FM>) {
      if (/^MemTotal:\s+(\d+ \w+)/) {
         $sys{'SysMemTotal'} = $1;
      }
      elsif (/^SwapTotal:\s+(\d+ \w+)/) {
         $sys{'SysSwapTotal'} = $1;
      }
   }

   close FM;

   if (open(FS,"<$file{'sysinfo'}")) {
      my $ctrlp = ();
      my $type  = ();

      while (<FS>) {
         $ctrlp = $1 if /^VM00 Control Program:\s+(.*)/;
         $type  = $1 if /^Type:\s+(\d+)/;
      }

      close FS;

      open(FC,"<$file{'cpuinfo'}") or die "Statistics: can't open $file{'cpuinfo'}";

      while (<FC>) {
         $sys{'SysCPU_Power'} = "$2 $1" if /^(bogomips per cpu): (\d+)/;
         $sys{'SysCountCPUs'} = $1      if /^# processors\s+: (\d+)/;
         $sys{'SysModelName'} = $1      if /^vendor_id\s+: (.*)/;
      }

      $sys{'SysModelName'} = "$sys{'SysModelName'}, $type, $ctrlp" if $type && $ctrlp;

      close FC;
   }
   elsif (open(FC,"<$file{'cpuinfo'}")) {
      --$sys{'SysCountCPUs'};

      while (<FC>) {
         $sys{'SysCountCPUs'}++     if /^processor\s+:/;
         $sys{'SysModelName'} = $1  if /^model name\s+: (.*)/;
         $sys{'SysCPU_Cache'} = $1  if /^cache size\s+: (.*)/;

         if (/^cpu MHz\s+: (.*)/) {
            if ($sys{'SysCPU_Power'}) {
               $sys{'SysCPU_Power'} = "$sys{'SysCPU_Power'}, $1 MHz";
            }
            elsif (defined $sys{'SysCPU_Power'}) {
               $sys{'SysCPU_Power'} = "$1 MHz";
            }
            else {
               $sys{'SysCPU_Power'} = 0;
            }
         }
      }

      close FC;
   }
   else {
      die "Statistics: can't open $file{'sysinfo'} or $file{'cpuinfo'}";
   }

   foreach my $Sec (split / /, $uptime) {
      $Sec = sprintf('%li',$Sec);

      my $Day  = 0;
      my $Hour = 0;
      my $Min  = 0;

      if ($Sec >= 86400) {
         $Day = sprintf('%i',$Sec / 86400);
         $Sec = $Sec % 86400;
      }

      if ($Sec >= 3600) {
         $Hour = sprintf('%i',$Sec / 3600);
         $Sec  = $Sec % 3600;
      }

      if ($Sec >= 60) {
         $Min = sprintf('%i',$Sec / 60);
         $Sec = $Sec % 60;
      }

      unless (defined $sys{'SysUptime'}) {
         $sys{'SysUptime'} = "${Day}d ${Hour}h ${Min}m ${Sec}s";
         next;
      }

      $sys{'SysIdleTime'} = "${Day}d ${Hour}h ${Min}m ${Sec}s";
   }

   foreach my $key (keys %sys) {
      chomp $sys{$key};
      $sys{$key} =~ s/\t/ /g;
      $sys{$key} =~ s/\s+/ /g;
   }

   return \%sys;
}

sub ProcStats {
   my %stat;

   open(STAT,"<$file{'stats'}") or die "Statistics: can't open $file{'stats'}";

   while (<STAT>) {
      if (/^cpu\s+(.*)$/) {
         ( $stat{'ProcUser'}
         , $stat{'ProcNice'}
         , $stat{'ProcSystem'}
         , $stat{'ProcIdle'}
         , $stat{'ProcIOWait'}
         ) = split /\s+/, $1;

         # ProcIOWait is only set as fifth parameter
         # by kernel versions higher than 2.4

         $stat{'ProcIOWait'} = 0 unless defined $stat{'ProcIOWait'};
         $stat{'Uptime'} = $stat{'ProcUser'} + $stat{'ProcNice'} + $stat{'ProcSystem'} + $stat{'ProcIdle'} + $stat{'ProcIOWait'};
      }
      elsif (/^processes: (\d+)$/) {
         $stat{'ProcNew'} = $1;
      }
   }

   close STAT;

   return \%stat;
}

sub MemStats {
   my %mem;

   open(MEM,"<$file{'meminfo'}") or die "Statistics: can't open $file{'meminfo'}";

   while (<MEM>) {
      if ( /^MemTotal:(\s+|)(\d+)/ ) {
         $mem{'MemTotal'} = $2;
      }
      elsif ( /^MemFree:(\s+|)(\d+)/ ) {
         $mem{'MemFree'} = $2;
      }
      elsif ( /^Buffers:(\s+|)(\d+)/ ) {
         $mem{'MemBuffers'} = $2;
      }
      elsif ( /^Cached:(\s+|)(\d+)/ ) {
         $mem{'MemCached'} = $2;
      }
      elsif ( /^SwapTotal:(\s+|)(\d+)/ ) {
         $mem{'MemSwapTotal'} = $2;
      }
      elsif ( /^SwapFree:(\s+|)(\d+)/ ) {
         $mem{'MemSwapFree'} = $2;
      }
   }

   close MEM;

   $mem{'MemUsed'}        = sprintf('%u',$mem{'MemTotal'} - $mem{'MemFree'});
   $mem{'MemUsedPro'}     = sprintf('%.2f',100 * $mem{'MemUsed'} / $mem{'MemTotal'});
   $mem{'MemSwapUsed'}    = sprintf('%u',$mem{'MemSwapTotal'} - $mem{'MemSwapFree'});
   $mem{'MemSwapUsedPro'} = sprintf('%.2f',100 * $mem{'MemSwapUsed'} / $mem{'MemSwapTotal'});

   return \%mem;
}

sub PgSwStats {
   my %stat;

   open(STAT,"<$file{'stats'}") or die "Statistics: can't open $file{'stats'}\n";

   while (<STAT>) {
      if (/^page (\d+) (\d+)$/) {
         $stat{'PageIn'}  = $1;
         $stat{'PageOut'} = $2;
      }
      elsif (/^swap (\d+) (\d+)$/) {
         $stat{'SwapIn'}  = $1;
         $stat{'SwapOut'} = $2;
      }
   }

   close STAT;

   # if paging and swapping are not found in /proc/stat
   # then let's try a look into /proc/vmstat (since 2.6)

   unless (defined $stat{'MemSwapOut'}) {
      open(VMSTAT,"<$file{'vmstat'}") or die "Statistics: can't open $file{'vmstat'}";

      while (<VMSTAT>) {
         if (/^pgpgin (\d+)$/) {
            $stat{'PageIn'} = $1;
         }
         elsif (/^pgpgout (\d+)$/) {
            $stat{'PageOut'} = $1;
         }
         elsif (/^pswpin (\d+)$/) {
            $stat{'SwapIn'} = $1;
         }
         elsif (/^pswpout (\d+)$/) {
            $stat{'SwapOut'} = $1;
         }
      }

      close VMSTAT;
   }

   return \%stat;
}

sub NetStats {
   my (%net,%sum);

   open(NET,"<$file{'netstats'}") or die "Statistics: can't open $file{'netstats'}";

   while (<NET>) {
      if (/^(\s+|)(\w+):(\s+|)(.*)/) {
         ( $net{$2}{'NetRxBytes'}
         , $net{$2}{'NetRxPackets'}
         , $net{$2}{'NetRxErrs'}
         , $net{$2}{'NetRxDrop'}
         , $net{$2}{'NetRxFifo'}
         , $net{$2}{'NetRxFrame'}
         , $net{$2}{'NetRxCompr'}
         , $net{$2}{'NetRxMulti'}
         , $net{$2}{'NetTxBytes'}
         , $net{$2}{'NetTxPacktes'}
         , $net{$2}{'NetTxErrs'}
         , $net{$2}{'NetTxDrop'}
         , $net{$2}{'NetTxFifo'}
         , $net{$2}{'NetTxColls'}
         , $net{$2}{'NetTxCarr'}
         , $net{$2}{'NetTxCompr'}
         ) = split /\s+/, $4;

         $sum{'NetRxBytes'} += $net{$2}{'NetRxBytes'};
         $sum{'NetTxBytes'} += $net{$2}{'NetTxBytes'};
      }
   }

   close NET;

   return (\%net,\%sum);
}

sub SockStats {
   my %sock;

   open(SOCK,"<$file{'sockstats'}") or die "Statistics: can't open $file{'sockstats'}";

   while (<SOCK>) {
      if (/sockets: used (\d+)/) {
         $sock{'SockTotalSockets'} = $1;
      }
      elsif (/TCP: inuse (\d+)/) {
         $sock{'SockTcpSockets'} = $1;
      }
      elsif (/UDP: inuse (\d+)/) {
         $sock{'SockUdpSockets'} = $1;
      }
      elsif (/RAW: inuse (\d+)/) {
         $sock{'SockRawSockets'} = $1;
      }
   }

   close SOCK;

   return \%sock;
}

sub DiskStats {
   my (%disk,%sum);

   # one of the both must be opened for the disk statistics!
   # if diskstats (2.6) are not found then let's try to read
   # the partitions (2.4)

   if (open(DISK,"<$file{'diskstats'}")) {
      while (<DISK>) {
         if (/^\s+(\d+)\s+(\d+)\s+(\w+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)$/) {
            next if $4 == 0 && $8 == 0;
            $disk{$3}{'DiskMajor'}          = $1;
            $disk{$3}{'DiskMinor'}          = $2;
            $disk{$3}{'DiskReadRequests'}   = $4;
            $disk{$3}{'DiskReadBytes'}      = $6 * $block_size;
            $disk{$3}{'DiskWriteRequests'}  = $8;
            $disk{$3}{'DiskWriteBytes'}     = $9 * $block_size;
            $disk{$3}{'DiskTotalRequests'} += $disk{$3}{'DiskReadRequests'} + $disk{$3}{'DiskWriteRequests'};
            $disk{$3}{'DiskTotalBytes'}    += $disk{$3}{'DiskReadBytes'} + $disk{$3}{'DiskWriteBytes'};
         }
         elsif (/^\s+(\d+)\s+(\d+)\s+(\w+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)$/) {
            $disk{$3}{'DiskMajor'}          = $1;
            $disk{$3}{'DiskMinor'}          = $2;
            $disk{$3}{'DiskReadRequests'}   = $4;
            $disk{$3}{'DiskReadBytes'}      = $5 * $block_size;
            $disk{$3}{'DiskWriteRequests'}  = $6;
            $disk{$3}{'DiskWriteBytes'}     = $7 * $block_size;
            $disk{$3}{'DiskTotalRequests'} += $disk{$3}{'DiskReadRequests'} + $disk{$3}{'DiskWriteRequests'};
            $disk{$3}{'DiskTotalBytes'}    += $disk{$3}{'DiskReadBytes'} + $disk{$3}{'DiskWriteBytes'};
         }
         else {
            next;
         }

         $sum{'DiskSumReadRequests'}  += $disk{$3}{'DiskReadRequests'};
         $sum{'DiskSumReadBytes'}     += $disk{$3}{'DiskReadBytes'};
         $sum{'DiskSumWriteRequests'} += $disk{$3}{'DiskWriteRequests'};
         $sum{'DiskSumWriteBytes'}    += $disk{$3}{'DiskWriteBytes'};
         $sum{'DiskSumRequests'}      += $disk{$3}{'DiskTotalRequests'};
         $sum{'DiskSumBytes'}         += $disk{$3}{'DiskTotalBytes'};
      }

      close DISK;
   }
   elsif (open(DISK,"<$file{'partitions'}")) {
      while (<DISK>) {
         tr/A-Z/a-z/;

         if (/^\s+(\d+)\s+(\d+)\s+(\d+)\s+(\w+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)$/) {
            next if $5 == 0 && $9 == 0;
            $disk{$4}{'DiskMajor'}          = $1;
            $disk{$4}{'DiskMinor'}          = $2;
            $disk{$4}{'DiskReadRequests'}   = $5;
            $disk{$4}{'DiskReadBytes'}      = $7 * $block_size;
            $disk{$4}{'DiskWriteRequests'}  = $9;
            $disk{$4}{'DiskWriteBytes'}     = $10 * $block_size;
            $disk{$4}{'DiskTotalRequests'} += $disk{$4}{'ReadRequests'} + $disk{$4}{'WriteRequests'};
            $disk{$4}{'DiskTotalBytes'}    += $disk{$4}{'ReadBytes'} + $disk{$4}{'WriteBytes'};
            $sum{'DiskSumReadRequests'}    += $disk{$4}{'DiskReadRequests'};
            $sum{'DiskSumReadBytes'}       += $disk{$4}{'DiskReadBytes'};
            $sum{'DiskSumWriteRequests'}   += $disk{$4}{'DiskWriteRequests'};
            $sum{'DiskSumWriteBytes'}      += $disk{$4}{'DiskWriteBytes'};
            $sum{'DiskSumRequests'}        += $disk{$4}{'DiskTotalRequests'};
            $sum{'DiskSumBytes'}           += $disk{$4}{'DiskTotalBytes'};
         }
      }

      close DISK;
   }
   else {
      die "Statistics: can't open $file{'diskstats'} or $file{'partitions'}";
   }

   return (\%disk,\%sum);
}

sub DiskUsage {

   # It is not possible to get the disk usage from the proc filesystem.
   # So it is neccessary to execute the df command. In the near future
   # i will build my own disk free function, but for moment that should
   # be enough. The -k option gives the output in kilobytes.

   open(DFK,"/bin/df -k |") or die "Statistics: can't execute /bin/df -k";

   my (%disk_usage,$disk_name);

   while (<DFK>) {
      s/%//g;

      if (/^(.+?)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(.*)$/) {
         $disk_usage{$1}{'DiskU_Total'}      = $2;
         $disk_usage{$1}{'DiskU_Usage'}      = $3;
         $disk_usage{$1}{'DiskU_Free'}       = $4;
         $disk_usage{$1}{'DiskU_UsagePro'}   = $5;
         $disk_usage{$1}{'DiskU_MountPoint'} = $6;
      }
      elsif (/^(.+?)(\s|)$/ && !$disk_name) {

         # it can be that the disk name is to long and the rest
         # of the disk information are in the next line ...

         $disk_name = $1;
      }
      elsif (/^\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(.*)$/ && $disk_name) {

         # this line should contain the rest informations for the
         # disk name that we stored in the last loop

         $disk_usage{$disk_name}{'DiskU_Total'}      = $1;
         $disk_usage{$disk_name}{'DiskU_Usage'}      = $2;
         $disk_usage{$disk_name}{'DiskU_Free'}       = $3;
         $disk_usage{$disk_name}{'DiskU_UsagePro'}   = $4;
         $disk_usage{$disk_name}{'DiskU_MountPoint'} = $5;

         undef $disk_name;
      }
      else {

         # okay, it should never be the issue that we get a
         # line that we couldn't split, but for sure we undef
         # the disk_name if it's set

         undef $disk_name if $disk_name;
      }
   }

   close DFK;

   return \%disk_usage;
}

sub LoadAVG {
   my (%lavg,$proc);

   open(LAVG,"<$file{'loadavg'}") or die "Statistics: can't open $file{'loadavg'}";

   ( $lavg{'ProcAVG_1'}
   , $lavg{'ProcAVG_5'}
   , $lavg{'ProcAVG_15'}
   , $proc
   ) = (split /\s+/, <LAVG>)[0,1,2,3];

   close LAVG;

   ( $lavg{'ProcRunQueue'}
   , $lavg{'ProcCount'}
   ) = split /\//, $proc;

   return \%lavg;
}

sub Processes {
   my (%sps,%userids);

   opendir(PDIR,$file{'procdir'}) or die "Statistics: can't open directory $file{'procdir'}";

   # we get all the PIDs from the /proc filesystem. if we can't open a file
   # of a process, then it can be that the process doesn't exist any more and
   # we will delete the hash key.

   my @prc = grep /^\d+$/, readdir PDIR;

   closedir PDIR;

   # we trying to get the UIDs for each linux user

   open(PWD,"<$file{'passwd'}") or die die "Statistics: can't open $file{'passwd'}";

   while (<PWD>) {
      next if /^(#|$)/;
      my ($user,$uid) = (split /:/,$_)[0,2];
      $userids{$uid} = $user;
   }

   close PWD;

   foreach my $pid (@prc) {

      #  memory usage for each process

      if (open(MEM,"<$file{'procdir'}/$pid/statm")) {
         ( $sps{$pid}{'sProcSize'}
         , $sps{$pid}{'sProcResident'}
         , $sps{$pid}{'sProcShare'}
         , $sps{$pid}{'sProcTRS'}
         , $sps{$pid}{'sProcDRS'}
         , $sps{$pid}{'sProcLRS'}
         , $sps{$pid}{'sProcDT'}
         ) = split /\s+/, <MEM>;
         close MEM;
      }
      else {
         delete $sps{$pid};
         next;
      }

      #  different other informations for each process

      if (open(PRC,"<$file{'procdir'}/$pid/stat")) {
         ( $sps{$pid}{'sProcPid'}
         , $sps{$pid}{'sProcComm'}
         , $sps{$pid}{'sProcState'}
         , $sps{$pid}{'sProcPPid'}
         , $sps{$pid}{'sProcPGrp'}
         , $sps{$pid}{'sProcSession'}
         , $sps{$pid}{'sProcTTYnr'}
         , $sps{$pid}{'sProcMinFLT'}
         , $sps{$pid}{'sProcCMinFLT'}
         , $sps{$pid}{'sProcMayFLT'}
         , $sps{$pid}{'sProcCMayFLT'}
         , $sps{$pid}{'sProcUTime'}
         , $sps{$pid}{'sProcSTime'}
         , $sps{$pid}{'sProcCUTime'}
         , $sps{$pid}{'sProcCSTime'}
         , $sps{$pid}{'sProcPrior'}
         , $sps{$pid}{'sProcNice'}
         , $sps{$pid}{'sProcStartTime'}
         , $sps{$pid}{'sProcVSize'}
         , $sps{$pid}{'sProcNSwap'}
         , $sps{$pid}{'sProcCNSwap'}
         , $sps{$pid}{'sProcProc'}
         ) = (split /\s+/, <PRC>)[0,1,2,3,4,5,6,9,10,11,12,13,14,15,16,17,18,21,22,35,36,38];

         close PRC;
      }
      else {
         delete $sps{$pid};
         next;
      }

      # determine the owner of the process

      if (open(UID,"<$file{'procdir'}/$pid/status")) {
         while (<UID>) {
            s/\t/ /;
            next unless /^Uid:\s+(\d+)/;
            $sps{$pid}{'sProcOwner'} = $userids{$1} if $userids{$1};
         }

         $sps{$pid}{'sProcOwner'} = 'n/a' unless $sps{$pid}{'sProcOwner'};

         close UID;
      }
      else {
         delete $sps{$pid};
         next;
      }

      #  command line for each process

      if (open(CMD,"<$file{'procdir'}/$pid/cmdline")) {
         $sps{$pid}{'sProcCMDLINE'} =  <CMD>;
         $sps{$pid}{'sProcCMDLINE'} =~ s/\0/ /g if $sps{$pid}{'sProcCMDLINE'};
         $sps{$pid}{'sProcCMDLINE'} =  'n/a' unless $sps{$pid}{'sProcCMDLINE'};
         chomp $sps{$pid}{'sProcCMDLINE'};
         close CMD;
      }
   }

   return \%sps;
}

1;
