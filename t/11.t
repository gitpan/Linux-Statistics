use strict;
use Test::More tests => 32;
use Linux::Statistics;

my %Processes = (
   PPid => undef,
   Owner => undef,
   State => undef,
   PGrp => undef,
   Session => undef,
   TTYnr => undef,
   MinFLT => undef,
   CMinFLT => undef,
   MayFLT => undef,
   CMayFLT => undef,
   CUTime => undef,
   STime => undef,
   UTime => undef,
   CSTime => undef,
   Prior => undef,
   Nice => undef,
   StartTime => undef,
   ActiveTime => undef,
   VSize => undef,
   NSwap => undef,
   CNSwap => undef,
   CPU => undef,
   Size => undef,
   Resident => undef,
   Share => undef,
   TRS => undef,
   DRS => undef,
   LRS => undef,
   DT => undef,
   Comm => undef,
   CMDLINE => undef,
   Pid => undef,
);

my $obj = Linux::Statistics->new(Processes => 1);
sleep(1);
my $stats = $obj->getStats;

for my $dev (keys %{$stats->{Processes}}) {
   ok(defined $stats->{Processes}->{$dev}->{$_}, "checking Processes $_") for keys %Processes;
   last; # we check only one device, that should be enough
}
