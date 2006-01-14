#!/usr/bin/perl -w
use strict;
use Fcntl qw(:DEFAULT :flock);
use Linux::Statistics;
use Data::Dumper;

print "\nThis little script is written for the issue that you want to report bugs to\n";
print "the author of this module. It generates the file output_proc_check.txt with a\n";
print "lot of helpful informations.\n\n";
print "Do you want to generate this output? (y|n) ";

chomp(my $answer = <STDIN>);

exit unless $answer eq 'y';

print "\nMany thanks for your strives :-)\n";
print "Please send the output to <jschulz\@bloonix.de>.\n\n";

sysopen(STDOUT,"output_proc_check.txt",O_WRONLY | O_EXCL | O_APPEND | O_CREAT) or die $!;
sysopen(STDERR,"output_proc_check.txt",O_WRONLY | O_APPEND) or die $!;
sysopen(WARNING,"output_proc_check.txt",O_WRONLY | O_APPEND) or die $!;

sub warnHandler {
   print WARNING @_;
}

$SIG{__WARN__} = \&warnHandler;

my $obj = Linux::Statistics->new( SysInfo   => 1,
                                  ProcStats => 1,
                                  MemStats  => 1,
                                  PgSwStats => 1,
                                  NetStats  => 1,
                                  SockStats => 1,
                                  DiskStats => 1,
                                  DiskUsage => 1,
                                  LoadAVG   => 1,
                                  FileStats => 1,
                                  Processes => 1,
                                  TimeStamp => 1 );

sleep(1);

print Dumper($obj->getStats);

my @file = (
   '/proc/1/statm',
   '/proc/1/stat',
   '/proc/1/status',
   '/proc/1/cmdline',
   '/proc/stat',
   '/proc/meminfo',
   '/proc/sysinfo',
   '/proc/cpuinfo',
   '/proc/vmstat',
   '/proc/loadavg',
   '/proc/net/sockstat',
   '/proc/net/dev',
   '/proc/diskstats',
   '/proc/partitions',
   '/proc/uptime',
   '/proc/sys/kernel/hostname',
   '/proc/sys/kernel/domainname',
   '/proc/sys/kernel/ostype',
   '/proc/sys/kernel/osrelease',
   '/proc/sys/kernel/version',
   '/proc/sys/fs/file-nr',
   '/proc/sys/fs/inode-nr',
   '/proc/sys/fs/dentry-state'
);

foreach my $file (@file) {
   print "#" x 50 . "\n";
   print "Output from $file\n";
   print "#" x 50 . "\n";
   if (open F,'<',$file) {
      while (<F>) { print; }
      close F;
   } else { print "Just a warning: can't open $file\n"; }
}
