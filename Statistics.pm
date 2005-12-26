=head1 NAME

Linux::Statistics - Collect system statistics.

=head1 SYNOPSIS

use Linux::Statistics;

my $obj = Linux::Statistics->new( SysInfo   => 1,
                                  ProcStats => 1,
                                  MemStats  => 1,
                                  PgSwStats => 1,
                                  NetStats  => 1,
                                  SockStats => 1,
                                  DiskStats => 1,
                                  DiskUsage => 1,
                                  LoadAVG   => 1,
                                  Processes => 1,
                                  TimeStamp => 1 );

sleep(1);

my $stats = $obj->getStats;

=head1 DESCRIPTION

This module collects system statistics like processor workload, memory usage and other
system informations from the /proc filesystem. It is tested on x86 hardware with the
distributions SuSE, SLES (s390 and s390x), Red Hat, Debian and Mandrake on kernel versions
2.4 and 2.6 but should also running on other linux distributions with the same kernel
release number. To run this module it is necessary to start it as root or another user
with the authorization to read the /proc filesystem and the /etc/passwd file.

=head2 NOTE

The method new() checks the options and initialize different statitistics if they're required.
If you want to get useful statistics for the options ProcStats, NetStats, DiskStats, PgSwStats
and Processes then it's necessary to sleep for a while - at least one second - between the calls
of new() and getStats(). If you shouldn't do that it's possible that this statistics will be null.
The reason is that this statistics are deltas since the last time that the new method was called
and the call of getStats().

The getStats() function collects the requested informations and actualize the initalized values.
This way making it possible that the method new() doesn't must called again and again if you want
to collect the statistics in a loop. The exception is that you must call the method new() if you
want to add or remove a option.

=head1 OPTIONS

All options returns a multidimensional hash as a reference with the collected system informations.

=head2 SysInfo

Generated from I</proc/sys/kernel/hostname> *domainname *ostype *osrelease *version
and I</proc/sysinfo>, I</proc/cpuinfo>, I</proc/meminfo>, I</proc/uptime>.

   Hostname        -  This is the host name.
   Domain          -  This is the host domain name.
   Kernel          -  This is the kernel name.
   Release         -  This is the release number.
   Version         -  This is the version number.
   MemTotal        -  The total size of memory.
   SwapTotal       -  The total size of swap space.
   CPU_Power       -  The power of the CPUs in mhz or bogomips.
   CountCPUs       -  The total number of CPUs.
   ModelName       -  The model name.
   Uptime          -  This is the uptime of the system.
   IdleTime        -  This is the idle time of the system idletime.

=head2 ProcStats

Generated from I</proc/stat>.

   User            -  Percentage of CPU utilization at the user level.
   Nice            -  Percentage of CPU utilization at the user level with nice priority.
   System          -  Percentage of CPU utilization at the system level.
   Idle            -  Percentage of time the CPU is in idle state.
   IOWait          -  Percentage of time the CPU is in idle state because an i/o operation is waiting for a disk.
   Total           -  Total percentage of CPU utilization at user and system level.
   New             -  Number of new processes that were produced per second.

=head2 MemStats

Generated from I</proc/meminfo>.

   MemUsed         -  Total size of used memory in kilobytes.
   MemFree         -  Total size of free memory in kilobytes.
   MemUsedFree     -  Total size of used memory in percent.
   MemTotal        -  Total size of memory in kilobytes.
   Buffers         -  Total size of buffers used from memory in kilobytes.
   Cached          -  Total size of cached memory in kilobytes.
   SwapUsed        -  Total size of swap space is used is kilobytes.
   SwapFree        -  Total size of swap space is free in kilobytes.
   SwapUsedPro     -  Total size of swap space is used in percent.
   SwapTotal       -  Total size of swap space in kilobytes.

=head2 PgSwStats

Generated from I</proc/stat> or I</proc/vmstat>.

   PageIn          -  Number of kilobytes the system has paged in from disk per second.
   PageOut         -  Number of kilobytes the system has paged out to disk per second.
   SwapIn          -  Number of kilobytes the system has swapped in from disk per second.
   SwapOut         -  Number of kilobytes the system has swapped out to disk per second.

=head2 NetStats

Generated from I</proc/net/dev>.

   RxBytes         -  Number of bytes received per second.
   RxPackets       -  Number of packets received per second.
   RxErrs          -  Number of errors that happend per second while received packets.
   RxDrop          -  Number of packets that were dropped per second.
   RxFifo          -  Number of FIFO overruns that happend per second on received packets.
   RxFrame         -  Number of carrier errors that happend per second on received packets.
   RxCompr         -  Number of compressed packets received per second.
   RxMulti         -  Number of multicast packets received per second.
   TxBytes         -  Number of bytes transmitted per second.
   TxPacktes       -  Number of packets transmitted per second.
   TxErrs          -  Number of errors that happend while transmitting packets.
   TxDrop          -  Number of packets that were dropped per second.
   TxFifo          -  Number of FIFO overruns that happend per second on transmitted packets.
   TxColls         -  Number of collisions that were detected.
   TxCarr          -  Number of carrier errors that happend per second on transmitted packets.
   TxCompr         -  Number of compressed packets transmitted per second.

=head2 NetStatsSum

   This are just some summaries of NetStats.

   RxBytes         -  Total number of bytes received per second.
   TxBytes         -  Total number of bytes transmitted per second.

=head2 SockStats

Generated from I</proc/net/sockstat>.

   Used            -  Total number of used sockets.
   Tcp             -  Number of tcp sockets in use.
   Udp             -  Number of udp sockets in use.
   Raw             -  Number of raw sockets in use.
   IpFrag          -  Number of ip fragments in use.

=head2 DiskStats

Generated from I</proc/diskstats> or I</proc/partitions>.

   Major           -  The mayor number of the disk
   Minor           -  The minor number of the disk
   ReadRequests    -  Number of read requests that were made per second to physical disk.
   ReadBytes       -  Number of bytes that were read per second from physical disk.
   WriteRequests   -  Number of write requests that were made per second to physical disk.
   WriteBytes      -  Number of bytes that were written per second to physical disk.
   TotalRequests   -  Total number of requests were made per second from/to physical disk.
   TotalBytes      -  Total number of bytes transmitted per second from/to physical disk.

=head2 DiskStatsSum

   This are just some summaries of DiskStats.

   ReadRequests    -  Total number of read requests were made per second to all physical disks.
   ReadBytes       -  Total number of bytes reads per second from all physical disks.
   WriteRequests   -  Total number of write requests were made per second to all physical disks.
   WriteBytes      -  Total number of bytes written per second to all physical disks.
   Requests        -  Total number of requests were made per second from/to all physical disks.
   Bytes           -  Total number of bytes transmitted per second from/to all physical disks.

=head2 DiskUsage

Generated with I</bin/df -k>.

   Total           -  The total size of the disk.
   Usage           -  The used disk space in kilobytes.
   Free            -  The free disk space in kilobytes.
   UsagePro        -  The used disk space in percent.
   MountPoint      -  The moint point of the disk.

=head2 LoadAVG

Generated with I</proc/loadavg>.

   AVG_1           -  The average processor workload of the last minute.
   AVG_5           -  The average processor workload of the last five minutes.
   AVG_15          -  The average processor workload of the last fifteen minutes.
   RunQueue        -  The number of processes waiting for runtime.
   Count           -  The total amount of processes on the system.

=head2 Processes

Generated with I</proc/E<lt>numberE<gt>/statm>, I</proc/E<lt>numberE<gt>/stat>, I</proc/E<lt>numberE<gt>/status>, I</proc/E<lt>numberE<gt>/cmdline> and I</etc/passwd>.

   PPid            -  The parent process ID of the process.
   Owner           -  The owner name of the process.
   State           -  The status of the process.
   PGrp            -  The group ID of the process.
   Session         -  The session ID of the process.
   TTYnr           -  The tty the process use.
   MinFLT          -  The number of minor faults the process made per second.
   CMinFLT         -  The number of minor faults the child process made per second.
   MayFLT          -  The number of mayor faults the process made per second.
   CMayFLT         -  The number of mayor faults the child process made per second.
   CUTime          -  The number of jiffies the process waited for childrens have been scheduled in user mode.
   STime           -  The number of jiffies the process have beed scheduled in kernel mode.
   UTime           -  The number of jiffies the process have beed scheduled in user mode.
   CSTime          -  The number of jiffies the process waited for childrens have been scheduled in kernel mode.
   Prior           -  The priority of the process (+15).
   Nice            -  The nice level of the process.
   StartTime       -  The time in jiffies the process started after system boot.
   ActiveTime      -  The time in D:H:M (days, hours, minutes) the process is active.
   VSize           -  The size of virtual memory of the process.
   NSwap           -  The size of swap space of the process.
   CNSwap          -  The size of swap space of the childrens of the process.
   CPU             -  The CPU number the process was last executed on.
   Size            -  The total program size of the process.
   Resident        -  Number of resident set size, this includes the text, data and stack space.
   Share           -  Total size of shared pages of the process.
   TRS             -  Total text size of the process.
   DRS             -  Total data/stack size of the process.
   LRS             -  Total library size of the process.
   DT              -  Total size of dirty pages of the process (unused since kernel 2.6).
   Comm            -  Command of the process.
   CMDLINE         -  Command line of the process.
   Pid             -  The process ID.

=head2 TimeStamp

Generated with I<localtime(time)>.

   Date            -  The current date.
   Time            -  The current time.

=head1 EXAMPLES

=head4 A very simple perl script could looks like this:

         #!/usr/bin/perl -w
         use strict;
         use Linux::Statistics;

         my $obj   = Linux::Statistics->new( ProcStats => 1 );
         sleep(1);
         my $stats = $obj->getStats;

         print "Statistics for ProcStats\n";
         print "  User      $stats->{ProcStats}->{User}\n";
         print "  Nice      $stats->{ProcStats}->{Nice}\n";
         print "  System    $stats->{ProcStats}->{System}\n";
         print "  Idle      $stats->{ProcStats}->{Idle}\n";
         print "  IOWait    $stats->{ProcStats}->{IOWait}\n";
         print "  Total     $stats->{ProcStats}->{Total}\n";
         print "  New       $stats->{ProcStats}->{New}\n";

=head4 Or this:

         #!/usr/bin/perl -w
         use strict;
         use Linux::Statistics;

         my $obj = Linux::Statistics->new( NetStats => 1 );
         sleep(1);
         my $stats = $obj->getStats;

         foreach my $device (keys %{$stats->{NetStats}}) {
            print "Statistics for device $device ...\n";

            while (my ($key,$value) = each %{$stats->{NetStats}->{$device}}) {
               print ' ' x 2, "$key", ' ' x (30-length($key)), "$value\n";
            }
         }

         print "\nTotal network statistics ...\n";

         while (my ($key,$value) = each %{$stats->{NetStatsSum}}) {
            print ' ' x 2, "$key", ' ' x (30-length($key)), "$value\n";
         }

=head4 This also:

         #!/usr/bin/perl -w
         use strict;
         use Linux::Statistics;

         my $obj = Linux::Statistics->new( Processes => 1 );
         sleep(1);
         my $stats = $obj->getStats;

         print "$_", ' ' x (12-length($_)) for qw(Pid PPid Owner State Size VSize CMDLINE);
         print "\n";

         foreach my $pid (keys %{$stats->{Processes}}) {
            print "$stats->{Processes}->{$pid}->{$_}", ' ' x (12-length($stats->{Processes}->{$pid}->{$_}))
               for qw(Pid PPid Owner State Size VSize CMDLINE);
            print "\n";
         }

=head4 You can also collect the statistics in a loop:

         #!/usr/bin/perl -w
         use strict;
         use Linux::Statistics;

         $| = 1;

         my $obj   = Linux::Statistics->new( ProcStats => 1, TimeStamp => 1 );

         print "Report/Statistic for ProcStats\n";
         print ' ' x (8-length($_)), "$_" for qw(Time User Nice System Idle IOWait Total New);
         print "\n";

         while (1) {
            sleep(1);
            my $stats = $obj->getStats;

            print "$stats->{TimeStamp}->{Time}";
            print ' ' x (8-length($stats->{ProcStats}->{$_})), "$stats->{ProcStats}->{$_}" for keys %{$stats->{ProcStats}};
            print "\n";
         }

=head4 It is also possible to create a hash reference with options.

         my $options = {
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
            TimeStamp => 1
         };

         my $obj = Linux::Statistics->new( $options );
         sleep(1);
         my $stats = $obj->getStats;

=head4 If you're not sure you can use the the Data::Dumper module to learn more about the hash structure.

         #!/usr/bin/perl -w
         use strict;
         use Linux::Statistics;
         use Data::Dumper;

         my $obj = Linux::Statistics->new( Processes => 1 );
         sleep(1);
         my $stats = $obj->getStats;

         print Dumper($stats);

=head4 You can find a very simple script for tests under the installation directory
Linux-Statistics-<version>/tests/. The script called SimpleCheck.pl and shows you the collected
data with Data::Dumper.

=head4 Have a lot of fun with this module :-)

=head1 SEE ALSO

The manpage of proc(5) or I</usr/src/linux/Documentation/filesystems/proc.txt>.

=head1 REPORTING BUGS

Please report all bugs to <jschulz@bloonix.de>.

You can send me additional informations generated by a script if you like.
The script should lie under the Linus-Statistics-<version>/tests/ directory
and it called ProcCheck.pl. This script generates an output for all statistics
with Data::Dumper and an output of all necessary files from the /proc filesystem.
Take a look into this script and take care that it only generates data from
this files. The output file called output_proc_check.txt.
 
=head1 AUTHOR

Jonny Schulz <jschulz@bloonix.de>.

=head1 COPYRIGHT

Copyright (c) 2005, 2006 by Jonny Schulz. All rights reserved.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

package Linux::Statistics;

use strict;
require Exporter;
our @ISA     = qw(Exporter);
our @EXPORT  = qw(new getStats);
our $VERSION = '1.10';

# Disk statictics are since 2.4 kernel found in /proc/partitions, but since
# kernel 2.6 this statistics are now in /proc/diskstats. Further the paging
# and swapping statistics are no more in /proc/stat but also in /proc/vmstat.
# Here are now all neccessary files for this module.

my %file = (
   passwd     => '/etc/passwd',
   procdir    => '/proc',
   stats      => '/proc/stat',
   meminfo    => '/proc/meminfo',
   sysinfo    => '/proc/sysinfo',
   cpuinfo    => '/proc/cpuinfo',
   vmstat     => '/proc/vmstat',
   loadavg    => '/proc/loadavg',
   sockstats  => '/proc/net/sockstat',
   netstats   => '/proc/net/dev',
   diskstats  => '/proc/diskstats',
   partitions => '/proc/partitions',
   uptime     => '/proc/uptime',
   hostname   => '/proc/sys/kernel/hostname',
   domain     => '/proc/sys/kernel/domainname',
   kernel     => '/proc/sys/kernel/ostype',
   release    => '/proc/sys/kernel/osrelease',
   version    => '/proc/sys/kernel/version',
);

# The sectors are equivalent with blocks and have a size of 512 bytes since 2.4
# kernels. This value is needed to calculate the amount of disk i/o's in bytes.

my $block_size = 512;

sub new {
   my $class = shift;
   my %self;

   if (ref $_[0] eq 'HASH') {
      $self{options} = $_[0];
   } elsif (@_ & 1) {
      die 'Statistics: not enough arguments ...';
   } else {
      $self{options} = {@_};
   }

   # we initialize necessary values
   foreach my $opt (keys %{$self{options}}) {
      no strict 'refs';

      if ($opt =~ /^(ProcStats|PgSwStats)$/) {
         $self{istat}{$opt} = &$opt();
      } elsif ($opt =~ /^Processes$/) {
         $self{istat}{uptime} = (split /\s+/, <FU>)[0] if open FU,'<',$file{uptime};
         $self{istat}{$opt} = initProcesses();
      } elsif ($opt =~ /^(NetStats|DiskStats)$/) {
         ($self{istat}{$opt},$self{istat}{"${opt}Sum"}) = &$opt();
      } elsif ($opt !~ /^(SysInfo|MemStats|SockStats|DiskUsage|LoadAVG|Processes|TimeStamp)$/) {
         die "Statistics: invalid argument $opt";
      }
   }
   
   return bless \%self, $class;
}

# This function collects all statistic informations and return the data as a hash reference.

sub getStats {
   my $self    = shift;
   my $options = $self->{options};
   my $istat   = $self->{istat};
   my $rstat   = {};

   # set a time stamp for the statistics
   if ($options->{TimeStamp}) {
      my @tm = (localtime)[reverse 0..5];

      $tm[0] += 1900;
      $tm[1]++;

      $rstat->{TimeStamp}->{Time} = sprintf '%02d:%02d:%02d', @tm[3..5];
      $rstat->{TimeStamp}->{Date} = sprintf '%04d-%02d-%02d', @tm[0..2];
   }

   if ($options->{Processes}) {
      my $uptime = (split /\s+/, <FU>)[0] if open FU,'<',$file{uptime};
      $istat->{uptime} = $uptime - $istat->{uptime};
      $rstat->{Processes} = Processes();
      my $r_stat = $rstat->{Processes};
      my $i_stat = $istat->{Processes};

      for my $pid (keys %{$r_stat}) {
         # if the process doesn't exist it seems to be a new process
         if ($i_stat->{$pid}->{StartTime} && $r_stat->{$pid}->{StartTime} == $i_stat->{$pid}->{StartTime}) {
            for my $key (qw(MinFLT CMinFLT MayFLT CMayFLT UTime STime CUTime CSTime)) {
               # we held this value for the next init stat
               my $tmp                   = $r_stat->{$pid}->{$key};
               $r_stat->{$pid}->{$key} -= $i_stat->{$pid}->{$key};
               $r_stat->{$pid}->{$key}  = sprintf('%.2f', $r_stat->{$pid}->{$key} / $istat->{uptime}) if $r_stat->{$pid}->{$key} > 0;
               $i_stat->{$pid}->{$key}  = $tmp;
            }
         }
         else {
            # we initialize the new process
            for my $key (qw(MinFLT CMinFLT MayFLT CMayFLT UTime STime CUTime CSTime StartTime)) {
               $i_stat->{$pid}->{$key} = $r_stat->{$pid}->{$key};
               delete $r_stat->{$pid};
            }
         }
      }

      # our new uptime
      $i_stat->{uptime} = $uptime;
   }

   for my $opt (qw(SysInfo MemStats SockStats DiskUsage LoadAVG Processes)) {
      no strict 'refs';
      $rstat->{$opt} = &$opt() if $options->{$opt};
   }

   for my $opt (qw(ProcStats PgSwStats)) {
      if ($options->{$opt}) {
         { no strict 'refs'; $rstat->{$opt} = &$opt(); }

         while (my ($x,$y) = each %{$rstat->{$opt}}) {
            $rstat->{$opt}->{$x} -= $istat->{$opt}->{$x};
            $istat->{$opt}->{$x}  = $y;
         }
         if ($opt eq 'ProcStats') {
            foreach (qw(User Nice System Idle IOWait)) {
               $rstat->{ProcStats}->{$_} = sprintf('%.2f',100 * $rstat->{ProcStats}->{$_} / $rstat->{ProcStats}->{Uptime})
                  if $rstat->{ProcStats}->{$_};
            }

            $rstat->{ProcStats}->{Total} = $rstat->{ProcStats}->{User} + $rstat->{ProcStats}->{Nice} + $rstat->{ProcStats}->{System};
            delete $rstat->{ProcStats}->{Uptime};
         }
      }
   }

   for my $opt (qw(NetStats DiskStats)) {
      if ($options->{$opt}) {
         { no strict 'refs'; ($rstat->{$opt},$rstat->{"${opt}Sum"}) = &$opt() if $options->{$opt}; }

         foreach my $x (keys %{$rstat->{$opt}}) {
            while (my ($y,$z) = each %{$rstat->{$opt}->{$x}}) {
               $rstat->{$opt}->{$x}->{$y} -= $istat->{$opt}->{$x}->{$y};
               $istat->{$opt}->{$x}->{$y}  = $z;
            }
         }
         while (my ($x,$y) = each %{$rstat->{"${opt}Sum"}}) {
            $rstat->{"${opt}Sum"}->{$x} -= $istat->{"${opt}Sum"}->{$x};
            $istat->{"${opt}Sum"}->{$x}  = $y;
         }
      }
   }

   return $rstat if %{$rstat};
   return;
}

sub SysInfo {
   my %sys;
   $sys{Hostname} = <FH> if open FH,'<',$file{hostname} or die "Statistics: can't open $file{hostname}";
   $sys{Domain}   = <FD> if open FD,'<',$file{domain}   or die "Statistics: can't open $file{domain}";
   $sys{Kernel}   = <FK> if open FK,'<',$file{kernel}   or die "Statistics: can't open $file{kernel}";
   $sys{Release}  = <FR> if open FR,'<',$file{release}  or die "Statistics: can't open $file{release}";
   $sys{Version}  = <FV> if open FV,'<',$file{version}  or die "Statistics: can't open $file{version}";
   my $uptime        = <FU> if open FU,'<',$file{uptime}   or die "Statistics: can't open $file{uptime}";

   open FM,'<',$file{meminfo} or die "Statistics: can't open $file{meminfo}";
   while (<FM>) {
      if (/^MemTotal:\s+(\d+ \w+)/) {
         $sys{MemTotal} = $1;
      } elsif (/^SwapTotal:\s+(\d+ \w+)/) {
         $sys{SwapTotal} = $1;
      }
   }
   close FM;

   if (open FS,'<',$file{sysinfo}) {
      my $ctrlp = ();
      my $type  = ();

      while (<FS>) {
         $ctrlp = $1 if /^VM00 Control Program:\s+(.*)/;
         $type  = $1 if /^Type:\s+(\d+)/;
      }

      close FS;

      open FC,'<',$file{cpuinfo} or die "Statistics: can't open $file{cpuinfo}";
      while (<FC>) {
         $sys{CPU_Power} = "$2 $1" if /^(bogomips per cpu): (\d+)/;
         $sys{CountCPUs} = $1      if /^# processors\s+: (\d+)/;
         $sys{ModelName} = $1      if /^vendor_id\s+: (.*)/;
      }

      $sys{ModelName} = "$sys{ModelName}, $type, $ctrlp" if $type && $ctrlp;
      close FC;
   }
   elsif (open FC,'<',$file{cpuinfo}) {
      --$sys{CountCPUs};

      while (<FC>) {
         $sys{CountCPUs}++     if /^processor\s+:/;
         $sys{ModelName} = $1  if /^model name\s+: (.*)/;
         $sys{CPU_Cache} = $1  if /^cache size\s+: (.*)/;

         if (/^cpu MHz\s+: (.*)/) {
            if ($sys{CPU_Power}) {
               $sys{CPU_Power} = "$sys{CPU_Power}, $1 MHz";
            } elsif (defined $sys{CPU_Power}) {
               $sys{CPU_Power} = "$1 MHz";
            } else {
               $sys{CPU_Power} = 0;
            }
         }
      }

      close FC;
   }
   else {
      die "Statistics: can't open $file{sysinfo} or $file{cpuinfo}";
   }

   foreach (split /\s+/, $uptime) {
      my $s = sprintf('%li',$_);
      my $d = 0;
      my $h = 0;
      my $m = 0;

      $s >= 86400 and $d = sprintf('%i',$s / 86400) and $s = $s % 86400;
      $s >= 3600  and $h = sprintf('%i',$s / 3600)  and $s = $s % 3600;
      $s >= 60    and $m = sprintf('%i',$s / 60)    and $s = $s % 60;

      unless (defined $sys{Uptime}) {
         $sys{Uptime} = "${d}d ${h}h ${m}m ${s}s";
         next;
      }

      $sys{IdleTime} = "${d}d ${h}h ${m}m ${s}s";
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

   open STAT,'<',$file{stats} or die "Statistics: can't open $file{stats}";

   while (<STAT>) {
      if (/^cpu\s+(.*)$/) {
         @stat{qw/User Nice System Idle IOWait/} = split /\s+/, $1;

         # IOWait is only set as fifth parameter
         # by kernel versions higher than 2.4
         $stat{IOWait} = 0 unless defined $stat{IOWait};
         $stat{Uptime} = $stat{User} + $stat{Nice} + $stat{System} + $stat{Idle} + $stat{IOWait};
      } elsif (/^processes (.*)/) {
         $stat{New} = $1;
      }
   }

   close STAT;

   return \%stat;
}

sub MemStats {
   my %mem;

   open MEM,'<',$file{meminfo} or die "Statistics: can't open $file{meminfo}";
   while (<MEM>) { $mem{$1} = $2 if /^(MemTotal|MemFree|Buffers|Cached|SwapTotal|SwapFree):\s*(\d+)/ }
   close MEM;

   $mem{MemUsed}     = sprintf('%u',$mem{MemTotal} - $mem{MemFree});
   $mem{MemUsedPro}  = sprintf('%.2f',100 * $mem{MemUsed} / $mem{MemTotal});
   $mem{SwapUsed}    = sprintf('%u',$mem{SwapTotal} - $mem{SwapFree});
   $mem{SwapUsedPro} = sprintf('%.2f',100 * $mem{SwapUsed} / $mem{SwapTotal});

   return \%mem;
}

sub PgSwStats {
   my %stat;

   open STAT,'<',$file{stats} or die "Statistics: can't open $file{stats}\n";

   while (<STAT>) {
      if (/^page (\d+) (\d+)$/) {
         @stat{qw/PageIn PageOut/} = ($1, $2);
      } elsif (/^swap (\d+) (\d+)$/) {
         @stat{qw/SwapIn SwapOut/} = ($1, $2);
      }
   }

   close STAT;

   # if paging and swapping are not found in /proc/stat
   # then let's try a look into /proc/vmstat (since 2.6)

   unless (defined $stat{SwapOut}) {
      open VMSTAT,'<',$file{vmstat} or die "Statistics: can't open $file{vmstat}";

      while (<VMSTAT>) {
         if (/^pgpgin (\d+)$/) {
            $stat{PageIn} = $1;
         } elsif (/^pgpgout (\d+)$/) {
            $stat{PageOut} = $1;
         } elsif (/^pswpin (\d+)$/) {
            $stat{SwapIn} = $1;
         } elsif (/^pswpout (\d+)$/) {
            $stat{SwapOut} = $1;
         }
      }

      close VMSTAT;
   }

   return \%stat;
}

sub NetStats {
   my (%net,%sum);

   open NET,'<',$file{netstats} or die "Statistics: can't open $file{netstats}";

   while (<NET>) {
      if (/^(\s+|)(\w+):(\s+|)(.*)/) {
         @{$net{$2}}{qw(
            RxBytes  RxPackets  RxErrs   RxDrop     RxFifo  RxFrame
            RxCompr  RxMulti    TxBytes  TxPacktes  TxErrs  TxDrop
            TxFifo   TxColls    TxCarr   TxCompr
         )} = split /\s+/, $4;

         $sum{RxBytes} += $net{$2}{RxBytes};
         $sum{TxBytes} += $net{$2}{TxBytes};
      }
   }

   close NET;

   return (\%net,\%sum);
}

sub SockStats {
   my %sock;

   open SOCK,'<',$file{sockstats} or die "Statistics: can't open $file{sockstats}";

   while (<SOCK>) {
      if (/sockets: used (\d+)/) {
         $sock{Used} = $1;
      } elsif (/TCP: inuse (\d+)/) {
         $sock{Tcp} = $1;
      } elsif (/UDP: inuse (\d+)/) {
         $sock{Udp} = $1;
      } elsif (/RAW: inuse (\d+)/) {
         $sock{Raw} = $1;
      } elsif (/FRAG: inuse (\d+)/) {
         $sock{IpFrag} = $1;
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

   if (open DISK,'<',$file{diskstats}) {
      while (<DISK>) {
         if (/^\s+(\d+)\s+(\d+)\s+(\w+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)$/) {
            next if $4 == 0 && $8 == 0;
            $disk{$3}{Major}          = $1;
            $disk{$3}{Minor}          = $2;
            $disk{$3}{ReadRequests}   = $4;
            $disk{$3}{ReadBytes}      = $6 * $block_size;
            $disk{$3}{WriteRequests}  = $8;
            $disk{$3}{WriteBytes}     = $9 * $block_size;
            $disk{$3}{TotalRequests} += $disk{$3}{ReadRequests} + $disk{$3}{WriteRequests};
            $disk{$3}{TotalBytes}    += $disk{$3}{ReadBytes} + $disk{$3}{WriteBytes};
         } elsif (/^\s+(\d+)\s+(\d+)\s+(\w+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)$/) {
            $disk{$3}{Major}          = $1;
            $disk{$3}{Minor}          = $2;
            $disk{$3}{ReadRequests}   = $4;
            $disk{$3}{ReadBytes}      = $5 * $block_size;
            $disk{$3}{WriteRequests}  = $6;
            $disk{$3}{WriteBytes}     = $7 * $block_size;
            $disk{$3}{TotalRequests} += $disk{$3}{ReadRequests} + $disk{$3}{WriteRequests};
            $disk{$3}{TotalBytes}    += $disk{$3}{ReadBytes} + $disk{$3}{WriteBytes};
         } else {
            next;
         }

         $sum{ReadRequests}  += $disk{$3}{ReadRequests};
         $sum{ReadBytes}     += $disk{$3}{ReadBytes};
         $sum{WriteRequests} += $disk{$3}{WriteRequests};
         $sum{WriteBytes}    += $disk{$3}{WriteBytes};
         $sum{Requests}      += $disk{$3}{TotalRequests};
         $sum{Bytes}         += $disk{$3}{TotalBytes};
      }

      close DISK;
   }
   elsif (open DISK,'<',$file{partitions}) {
      while (<DISK>) {
         tr/A-Z/a-z/;

         if (/^\s+(\d+)\s+(\d+)\s+(\d+)\s+(\w+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)$/) {
            next if $5 == 0 && $9 == 0;
            $disk{$4}{Major}          = $1;
            $disk{$4}{Minor}          = $2;
            $disk{$4}{ReadRequests}   = $5;
            $disk{$4}{ReadBytes}      = $7 * $block_size;
            $disk{$4}{WriteRequests}  = $9;
            $disk{$4}{WriteBytes}     = $10 * $block_size;
            $disk{$4}{TotalRequests} += $disk{$4}{ReadRequests} + $disk{$4}{WriteRequests};
            $disk{$4}{TotalBytes}    += $disk{$4}{ReadBytes} + $disk{$4}{WriteBytes};
            $sum{ReadRequests}       += $disk{$4}{ReadRequests};
            $sum{ReadBytes}          += $disk{$4}{ReadBytes};
            $sum{WriteRequests}      += $disk{$4}{WriteRequests};
            $sum{WriteBytes}         += $disk{$4}{WriteBytes};
            $sum{Requests}           += $disk{$4}{TotalRequests};
            $sum{Bytes}              += $disk{$4}{TotalBytes};
         }
      }

      close DISK;
   } else {
      die "Statistics: can't open $file{diskstats} or $file{partitions}";
   }

   return (\%disk,\%sum);
}

sub DiskUsage {
   my (%disk_usage,$disk_name);

   open DFK,"/bin/df -k |"  or die "Statistics: can't execute /bin/df -k";

   while (<DFK>) {
      s/%//g;

      if (/^(.+?)\s+(.*)$/) {
         @{$disk_usage{$1}}{qw(Total Usage Free UsagePro MountPoint)} = (split /\s+/, $2)[0..4];
      } elsif (/^(.+?)\s*$/ && !$disk_name) {
         # it can be that the disk name is to long and the rest
         # of the disk information are in the next line ...
         $disk_name = $1;
      } elsif (/^\s+(.*)$/ && $disk_name) {
         # this line should contain the rest informations for the
         # disk name that we stored in the last loop
         @{$disk_usage{$disk_name}}{qw(Total Usage Free UsagePro MountPoint)} = (split /\s+/, $1)[0..4];
         undef $disk_name;
      } else {
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

   open LAVG,'<',$file{loadavg} or die "Statistics: can't open $file{loadavg}";

   ( $lavg{AVG_1}
   , $lavg{AVG_5}
   , $lavg{AVG_15}
   , $proc
   ) = (split /\s+/, <LAVG>)[0..3];

   close LAVG;

   ( $lavg{RunQueue}
   , $lavg{Count}
   ) = split /\//, $proc;

   return \%lavg;
}

sub initProcesses {
   my %sps;

   opendir PDIR,$file{procdir}  or die "Statistics: can't open directory $file{procdir}";
   my @prc = grep /^\d+$/, readdir PDIR; 
   closedir PDIR;

   foreach my $pid (@prc) {
      if (open PRC,'<',"$file{procdir}/$pid/stat") {
         @{$sps{$pid}}{qw(MinFLT CMinFLT MayFLT CMayFLT UTime STime CUTime CSTime StartTime)} = (split /\s+/, <PRC>)[9..16,21];
         close PRC; 
      } else {
         delete $sps{$pid};
         next;
      }
   }

   return \%sps;
}

sub Processes {
   my (%sps,%userids);

   opendir PDIR,$file{procdir}  or die "Statistics: can't open directory $file{procdir}";

   # we get all the PIDs from the /proc filesystem. if we can't open a file
   # of a process, then it can be that the process doesn't exist any more and
   # we will delete the hash key.
   my @prc = grep /^\d+$/, readdir PDIR;

   closedir PDIR;

   # we trying to get the UIDs for each linux user
   open PWD,'<',$file{passwd} or die die "Statistics: can't open $file{passwd}";

   while (<PWD>) {
      next if /^(#|$)/;
      my ($user,$uid) = (split /:/,$_)[0,2];
      $userids{$uid} = $user;
   }

   close PWD;

   my $uptime = (split /\s+/, <FU>)[0] if open FU,'<',$file{uptime};

   foreach my $pid (@prc) {

      #  memory usage for each process
      if (open MEM,'<',"$file{procdir}/$pid/statm") {
         @{$sps{$pid}}{qw(Size Resident Share TRS DRS LRS DT)} = split /\s+/, <MEM>;
         close MEM;
      } else {
         delete $sps{$pid};
         next;
      }

      #  different other informations for each process
      if (open PRC,'<',"$file{procdir}/$pid/stat") {
         @{$sps{$pid}}{qw(
            Pid Comm State PPid PGrp Session TTYnr MinFLT
            CMinFLT MayFLT CMayFLT UTime STime CUTime CSTime
            Prior Nice StartTime VSize NSwap CNSwap CPU
         )} = (split /\s+/, <PRC>)[0..6,9..18,21..22,35..36,38];
         close PRC;
      } else {
         delete $sps{$pid};
         next;
      }

      # calculate the active time of each process
      my $s = sprintf('%li',$uptime - $sps{$pid}{StartTime} / 100);
      my $m = 0;
      my $h = 0;
      my $d = 0;

      $s >= 86400 and $d = sprintf('%i',$s / 86400) and $s = $s % 86400;
      $s >= 3600  and $h = sprintf('%i',$s / 3600)  and $s = $s % 3600;
      $s >= 60    and $m = sprintf('%i',$s / 60);

      $sps{$pid}{ActiveTime} = sprintf '%02d:%02d:%02d', $d, $h, $m;

      # determine the owner of the process
      if (open UID,'<',"$file{procdir}/$pid/status") {
         while (<UID>) {
            s/\t/ /;
            next unless /^Uid:\s+(\d+)/;
            $sps{$pid}{Owner} = $userids{$1} if $userids{$1};
         }

         $sps{$pid}{Owner} = 'n/a' unless $sps{$pid}{Owner};

         close UID;
      } else {
         delete $sps{$pid};
         next;
      }

      #  command line for each process
      if (open CMD,'<',"$file{procdir}/$pid/cmdline") {
         $sps{$pid}{CMDLINE} =  <CMD>;
         $sps{$pid}{CMDLINE} =~ s/\0/ /g if $sps{$pid}{CMDLINE};
         $sps{$pid}{CMDLINE} =  'n/a' unless $sps{$pid}{CMDLINE};
         chomp $sps{$pid}{CMDLINE};
         close CMD;
      }
   }

   return \%sps;
}

1;
