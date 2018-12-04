#!/usr/bin/perl -w

## build the 1000 x 1000 multidimensional array

my @twodimensionalarray;
for my $t (0..1000){
	for my $u (0..1000){
		$twodimensionalarray[$t][$u] = 0;
	}
}

## increment each square being used on each line

open (INFILE, "<inputfile.txt");
while (my $line = <INFILE>){

	chomp $line;
	my @characters = split("", $line);
	my @words = split /\s/, $line;
	my @words2 = split /:/, $words[2];
	my @coords = split /,/, $words2[0];
	my @dimensions = split /x/, $words[3];
	
	for my $y (0..$dimensions[1]-1){
		for my $x (0..$dimensions[0]-1){
			$twodimensionalarray[$coords[0] + $x][$coords[1] + $y]++;
		}
	}
}
close INFILE;

## now check all the squares and count the ones used multiple times

my $totalcounter = 0;
for my $j (0..1000){
	for my $k (0..1000){
		if ($twodimensionalarray[$j][$k] > 1){$totalcounter++;}
	}
}

print "I found $totalcounter squares used multiple times.\n";

## read through the file again, this time checking the number of times calculated that each square was used
## this time, increment a counter if a square was used multiple times and notify if the counter was never incremented

open (INFILE, "<inputfile.txt");
while (my $line = <INFILE>){

	my $isright = 1;

	chomp $line;
	my @characters = split("", $line);
	my @words = split /\s/, $line;
	my @words2 = split /:/, $words[2];
	my @coords = split /,/, $words2[0];
	my @dimensions = split /x/, $words[3];
	
	for my $y (0..$dimensions[1]-1){
		for my $x (0..$dimensions[0]-1){
			if ($twodimensionalarray[$coords[0] + $x][$coords[1] + $y] > 1){$isright++;}
		}
	}
		
	if ($isright == 1){print "Rectangle $words[0] does not overlap with any other rectangles.\n";}	
	
}
close INFILE;