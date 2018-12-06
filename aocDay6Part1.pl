#!/usr/bin/perl -w

my @coords;
my %gridscores;
my $dist;
my %infinites;
my $smallestdistance;
my $smallestdistancecoord = 0;
my $xdist;
my $ydist;
my $istie = 0;
my $highscore = 0;
my $winner;

open (INFILE, "<inputfile.txt");
while (my $line = <INFILE>){
    chomp $line;
    push @coords, $line;
}

for my $x (0..1000){
    for my $y (0..1000){
        $smallestdistance = 1000000;
        for my $index (0..$#coords){
            my @indices = split /,/, $coords[$index];
            $indices[1] =~ s/^\s+//;
            $xdist = abs($indices[0] - $x);
            $ydist = abs($indices[1] - $y);
            $dist = $xdist + $ydist;
            if ($dist < $smallestdistance){
                $istie = 0;
                $smallestdistance = $dist;
                $smallestdistancecoord  = $index;
            }
            elsif ($dist == $smallestdistance){
                $istie = 1;
                $smallestdistancecoord = "T";
            }
        }
        if ($x == 0 || $x == 1000 || $y == 0 || $y == 1000){
            $infinites{$smallestdistancecoord} = 1;
        }
        $gridscores{$smallestdistancecoord}++;
    }
}

foreach my $key (keys %gridscores){
    if ($gridscores{$key} > $highscore && !exists $infinites{$key}){
        $highscore = $gridscores{$key};
        $winner = $key;
    }
}

print "The winner is $winner and their score, including equidistant points but disqualifying infinites, is $highscore.\n";