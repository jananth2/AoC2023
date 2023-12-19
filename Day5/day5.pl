use strict;
use warnings;
use List::Util qw(min first);

my $test1_answer = 35;
my $test2_answer = 46;

sub part1 ($) {
    open(FH, '<', shift) or die $!;

    my $sum = 0;
    my @seeds = split /:/, <FH>;
    shift @seeds;
    @seeds = split " ", $seeds[0];
    @seeds = map { int } @seeds;

    my @seed_soil = ();
    my @soil_fertilizer = ();
    my @fertilizer_water = ();
    my @water_light = ();
    my @light_temperature = ();
    my @temperature_humidity = ();
    my @humidity_location = ();

    my @nums = ();
    my $hr = undef;
    while (<FH>) {
	chomp;
	next if $_ eq "";

	@_ = split " ";
    
	if ($_[0] eq "seed-to-soil") {
	    $hr = \@seed_soil;
	} elsif ($_[0] eq "soil-to-fertilizer") {
	    $hr = \@soil_fertilizer;
	} elsif ($_[0] eq "fertilizer-to-water") {
	    $hr = \@fertilizer_water;
	} elsif ($_[0] eq "water-to-light") {
	    $hr = \@water_light;
	} elsif ($_[0] eq "light-to-temperature") {
	    $hr = \@light_temperature;
	} elsif ($_[0] eq "temperature-to-humidity") {
	    $hr = \@temperature_humidity;
	} elsif ($_[0] eq "humidity-to-location") {
	    $hr = \@humidity_location;
	} else {
	    @nums = map { int } @_;
	    push @$hr, [@nums];
	}
    }

    sub mymap ($$) {
	my $mapping = undef;
	my $hashref = shift;
	my $i       = shift;

	my @arr = @$hashref;
	my $valid = first { @$_[1] <= $i && @$_[1]+@$_[2] > $i } @arr;

	unless (defined $valid) {
	    $mapping = $i;
	} else {
	    $mapping = ($i - @$valid[1]) + @$valid[0];
	}

	return $mapping;
    }

    $sum = min map { mymap(\@humidity_location,
			   mymap(\@temperature_humidity,
				 mymap(\@light_temperature,
				       mymap(\@water_light,
					     mymap(\@fertilizer_water,
						   mymap(\@soil_fertilizer,
							 mymap(\@seed_soil, $_))))))) } @seeds;

    close(FH);
    return $sum;
}

sub part2 ($) {
    open(FH, '<', shift) or die $!;

    my @seeds = split /:/, <FH>;
    shift @seeds;
    @seeds = split " ", $seeds[0];
    @seeds = map { int } @seeds;

    foreach (0..(scalar @seeds)/2-1) {
	push @seeds, [$seeds[0], $seeds[0]+$seeds[1]-1];
	shift @seeds for (0..1);
    }

    my @seed_soil = ();
    my @soil_fertilizer = ();
    my @fertilizer_water = ();
    my @water_light = ();
    my @light_temperature = ();
    my @temperature_humidity = ();
    my @humidity_location = ();

    my @nums = ();
    my $hr = undef;
    while (<FH>) {
	chomp;
	next if $_ eq "";
	@_ = split " ";

	if ($_[0] eq "seed-to-soil") {
	    $hr = \@seed_soil;
	} elsif ($_[0] eq "soil-to-fertilizer") {
	    $hr = \@soil_fertilizer;
	} elsif ($_[0] eq "fertilizer-to-water") {
	    $hr = \@fertilizer_water;
	} elsif ($_[0] eq "water-to-light") {
	    $hr = \@water_light;
	} elsif ($_[0] eq "light-to-temperature") {
	    $hr = \@light_temperature;
	} elsif ($_[0] eq "temperature-to-humidity") {
	    $hr = \@temperature_humidity;
	} elsif ($_[0] eq "humidity-to-location") {
	    $hr = \@humidity_location;
	} else {
	    @nums = map { int } @_;
	    push @$hr, [@nums];
	}
    }
    close (FH);

    sub mymap_ ($$) {
	my $mapping = undef;
	my $hashref = shift;
	my $i       = shift;

	my @arr = @$hashref;
	my $valid = first { @$_[1] <= $i && @$_[1]+@$_[2] > $i } @arr;

	unless (defined $valid) {
	    $mapping = $i;
	} else {
	    $mapping = ($i - @$valid[1]) + @$valid[0];
	}

	return $mapping;
    }

    sub fill_in ($) {
	my $array_ref = shift;
	@_ = sort { @$a[0] <=> @$b[0] } @$array_ref;
    
	my @t = ();
	foreach (@_) {
	    push @t, [@{$_}[0], @{$_}[0]+@{$_}[2]-1];
	}

	foreach my $i (1..$#t) {
	    my $t1 = @{$t[$i-1]}[1];
	    my $t2 = @{$t[$i]}[0];
	    push @t, [$t1+1, $t2-1] unless $t1+1 == $t2;
	}

	my $first = @{$t[0]}[0];
	unshift @t, [0, $first-1] if $first != 0;
	return sort { @$a[0] <=> @$b[0] } @t;
    }

    my @r_mappings = (
	\@humidity_location,
	\@temperature_humidity,
	\@light_temperature,
	\@water_light,
	\@fertilizer_water,
	\@soil_fertilizer,
	\@seed_soil,
       );

    my @targets = fill_in(\@humidity_location);

    sub sort_ ($) {
	my $ar = shift;
	my @sorted = sort { @$a[0] <=> @$b[0] } @$ar;
	my $first = @{$sorted[0]}[0];
	unshift @sorted, [0, 0, $first] if $first != 0;
	return \@sorted;
    }

    # returns array of references
    sub transform ($$) {
	my $target_out_ar = shift;
	my $mapping_ar = shift;

	my ($OUT1, $OUT2) = @$target_out_ar;
	my @mapping       = @$mapping_ar;
	my @bounds = ();

	foreach (@mapping) {
	    my $OB1 = @{$_}[0];
	    my $OB2 = @{$_}[0]+@{$_}[2]-1;
	    my $IB1 = @{$_}[1];
	    my $IB2 = @{$_}[1]+@{$_}[2]-1;

	    next if ($OB2 < $OUT1 || $OUT2 < $OB1);

	    if ($OB1 < $OUT1) {
		my $diff = $OUT1 - $OB1;
		$OB1 = $OUT1;
		$IB1 += $diff;
	    }
	    if ($OUT2 < $OB2) {
		my $diff = $OB2 - $OUT2;
		$OB2 = $OUT2;
		$IB2 -= $diff;
	    }
	    push @bounds, [$IB1, $IB2];
	}

	push @bounds, [$OUT1, $OUT2] if (@bounds == 0);
	return @bounds;
    }

    sub check ($$) {
	my ($LC, $RC) = @{$_[0]};
	foreach (@{$_[1]}) {
	    my ($LS, $RS) = @$_;
	    next if ($RC < $LS || $RS < $LC);
	    return ($LC <= $LS) ? $LS : $LC;
	}
	return -1;
    }

    my @r_mappings_sorted = map { sort_($_) } @r_mappings;
    foreach (@targets) {
	my @input_stack = ([$_, 0]);
	my @is_tmp = ();

	until (scalar @input_stack == 0) {
	    my $q_front = shift @input_stack;
	    my ($qf, $i) = @$q_front;

	    my $is_size = scalar @input_stack;
	    @is_tmp = transform($qf, $r_mappings_sorted[$i]);

	    if ($i == $#r_mappings_sorted) {
		foreach (@is_tmp) {
		    my $res = check($_, \@seeds);
		    if ($res != -1) {
			return mymap_(\@humidity_location,
				      mymap_(\@temperature_humidity,
					     mymap_(\@light_temperature,
						    mymap_(\@water_light,
							   mymap_(\@fertilizer_water,
								  mymap_(\@soil_fertilizer,
									 mymap_(\@seed_soil, $res)))))));
		    }
		}
	    } else {
		unshift @input_stack, map { [$_, $i+1] } @is_tmp;
	    }
	}

    }
    return -1;  
}

die unless part1("input_test1.txt") == $test1_answer;
print "Part 1: ", part1("input.txt"), "\n";

die unless part2("input_test1.txt") == $test2_answer;
print "Part 2: ", part2("input.txt"), "\n";
