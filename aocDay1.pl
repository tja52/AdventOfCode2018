#!/usr/bin/perl -w

my $x = 0;
my %frequency;
$frequency{$x} = 0;
my $timetostop = 0;

while ($timetostop == 0){
open (INFILE, "<inputfile.txt");
while (my $line = <INFILE>){
    chomp $line;
    $x += $line;
    if (exists $frequency{$x}){print "I found $x\n";break;}
    $frequency{$x} = 0;
    }
close INFILE;
}
