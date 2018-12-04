#!/usr/bin/perl -w

my %guards;
my @lines;

open (INFILE, "<inputfile.txt");
while (my $line = <INFILE>){
	chomp $line;
	push @lines, $line;
}
close INFILE;

my @sortedlines = sort @lines;
my $activeguard;
my $begincount;
my $endcount;
my @items;
my @minute;

for my $x (0..$#sortedlines){
	my @words =  split /\s/, $sortedlines[$x];
	if ($sortedlines[$x] =~ /Guard/){
		$activeguard = $words[3];
	}
	elsif($sortedlines[$x] =~ /falls/){
		@items = split /:/, $words[1];
		@minute = split /]/, $items[1];
		$begincount = $minute[0];
	}
	else{
		@items = split /:/, $words[1];
		@minute = split /]/, $items[1];
		$endcount = $minute[0]-1;
		
		for my $i ($begincount..$endcount){
			$guards{$activeguard}[$i]++;
		}
	}
}

my $winningguard = "Bob";
my $winningnumber = 0;

foreach my $key (keys %guards){
	my $count = 0;
	for my $j (0..$#{$guards{$key}}){
		$count += $guards{$key}[$j];
	}
	if ($count > $winningnumber){$winningguard = $key; $winningnumber = $count;}
}

print "Winning guard is $winningguard\n";
print "Winning minutes is $winningnumber\n";

my @guardminutes;

for my $l (0..$#sortedlines){
	my @words =  split /\s/, $sortedlines[$l];
	if ($sortedlines[$l] =~ /Guard/){
		$activeguard = $words[3];
	}
	if($sortedlines[$l] =~ /falls/ && $activeguard eq $winningguard){
		@items = split /:/, $words[1];
		@minute = split /]/, $items[1];
		$begincount = $minute[0];
	}
	if($sortedlines[$l] =~ /wakes/ && $activeguard eq $winningguard){
		@items = split /:/, $words[1];
		@minute = split /]/, $items[1];
		$endcount = $minute[0]-1;
		
		for my $i ($begincount..$endcount){
			$guardminutes[$i]++;
		}
	}
}	

my $bestminute;
my $bestminutecount=0;

for my $t (0..$#guardminutes){
	if ($guardminutes[$t] > $bestminutecount){
		$bestminute = $t;
		$bestminutecount = $guardminutes[$t];
	}
}

print "His best minute was $bestminute\n";
print "He was asleep on that minute $bestminutecount times\n";

my $globalbestguard = "Set this";
my $globalbestminute;
my $globalbestminutecount=0;

foreach my $key2 (keys %guards){

@guardminutes = ();

for my $l (0..$#sortedlines){
	my @words =  split /\s/, $sortedlines[$l];
	if ($sortedlines[$l] =~ /Guard/){
		$activeguard = $words[3];
	}
	if($sortedlines[$l] =~ /falls/ && $activeguard eq $key2){
		@items = split /:/, $words[1];
		@minute = split /]/, $items[1];
		$begincount = $minute[0];
	}
	if($sortedlines[$l] =~ /wakes/ && $activeguard eq $key2){
		@items = split /:/, $words[1];
		@minute = split /]/, $items[1];
		$endcount = $minute[0]-1;
		
		for my $i ($begincount..$endcount){
			$guardminutes[$i]++;
		}
	}
}	

my $bestminute;
my $bestminutecount=0;

for my $t (0..$#guardminutes){
	if ($guardminutes[$t] > $globalbestminutecount){
		$globalbestguard = $key2;
		$globalbestminute = $t;
		$globalbestminutecount = $guardminutes[$t];
		
		print "I just found that guard $key2 was asleep at minute $t a total of $guardminutes[$t] times\n";
	}
}

}

print "The global best guard was $globalbestguard\n";
print "The global best minute was $globalbestminute\n";
print "He was asleep on that minute $globalbestminutecount times\n";