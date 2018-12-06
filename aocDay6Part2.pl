#!/usr/bin/perl -w

my @coords;
my $dist;
my $xdist;
my $ydist;
my $alldist;
my $safezones = 0;

open (INFILE, "<inputfile.txt");
while (my $line = <INFILE>){
    chomp $line;
    push @coords, $line;
}

for my $x (0..1000){
    for my $y (0..1000){
        $alldist = 0;
        for my $index (0..$#coords){
            my @indices = split /,/, $coords[$index];
            $indices[1] =~ s/^\s+//;
            $xdist = abs($indices[0] - $x);
            $ydist = abs($indices[1] - $y);
            $dist = $xdist + $ydist;
            $alldist += $dist;
        }
        if ($alldist < 10000){$safezones++;}
    }
}

print "I found $safezones safe zones\n";