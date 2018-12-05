#!/usr/bin/perl

my @letters;

open (INFILE, "<inputfile.txt");
while (my $line = <INFILE>){
    chomp $line;
    @letters = split ("", $line);
}

print "I have read in an array with terminal index $#letters.\n";

my %uniqueletters;

for my $y (0..$#letters){
    $uniqueletters{lc($letters[$y])} = 0;
}

for my $keyletter (keys %uniqueletters){
    
    my @newletters = grep {!/$keyletter/i} @letters;

READING:

my $storedletter = '0';
my $storedcase = 'x';
my $case = 'y';
my $letter = '1';
    
 for my $x (0..$#newletters){

        $letter = lc($newletters[$x]);
        if ($newletters[$x] !~ /[a-z]/){$case="u";} else {$case="l";}

        if ($storedletter eq $letter && $storedcase ne $case){

            my $previousletterindex = $x-1;
            splice (@newletters, $previousletterindex, 2);

            $storedletter = $letter;
            $storedcase = $case;
            goto READING;
            
        }
        
        $storedletter = $letter;
        $storedcase = $case;

}

print "After removing all instances of $keyletter and looping my array's terminal index is $#newletters\n";

}

close INFILE;

open (OUTFILE, ">finalletterarray.txt");
print OUTFILE @letters;
close OUTFILE;

