use strict;
use warnings;
use Smart::Comments;

my $test1_answer = 6440;
my $test2_answer = 5905;

sub part1 ($) {
    open(FH, '<', shift) or die $!;
    
    my $sum = 0;
    my $n_hands = 0;
    my @hands;
    while (<FH>) {
	chomp;
	my ($hand, $bid) = split " ";

	sub process {
	    my @uniq;
	    my @letters = unpack('C*',$_[0]);
	  
	    my $n_uniq = scalar grep { ++$uniq[$_] == 1 } @letters;
	    my $n_twice = (scalar grep { $uniq[$_] == 2 } @letters)/2;

	    return 0 if $n_uniq == 1;
	    return 1 if $n_uniq == 2 and $n_twice == 0;
	    return 2 if $n_uniq == 2 and $n_twice == 1;
	    return 3 if $n_uniq == 3 and $n_twice == 0;
	    return 4 if $n_uniq == 3 and $n_twice == 2;
	    return 5 if $n_uniq == 4;
	    return 6 if $n_uniq == 5;
	    die;
	}

	my $hand_idx = process($hand);
	push @{$hands[$hand_idx]}, $_;
	$n_hands++;
    }
    close(FH);

    my %order;
    @order{"2".."9", "T", "J", "Q", "K", "A"} = (1..13);

    foreach (0..$#hands) {
	next unless defined $hands[$_];
	@{$hands[$_]} = sort {
	      $order{substr($b, 0, 1)} <=> $order{substr($a, 0, 1)} or
	      $order{substr($b, 1, 1)} <=> $order{substr($a, 1, 1)} or
	      $order{substr($b, 2, 1)} <=> $order{substr($a, 2, 1)} or
	      $order{substr($b, 3, 1)} <=> $order{substr($a, 3, 1)} or
	      $order{substr($b, 4, 1)} <=> $order{substr($a, 4, 1)}
	  } @{$hands[$_]};

	foreach (@{$hands[$_]}) {
	    $sum += int((split(" ", $_))[1]) * $n_hands--;
	}
    }
    
    return $sum;
}

sub part2 ($) {
    open(FH, '<', shift) or die $!;

    my $sum = 0;
    my $n_hands = 0;
    my %order;
    @order{"J", "2".."9", "T", "Q", "K", "A"} = (1..13);

    my @hands;
    while (<FH>) {
	chomp;
	my ($hand, $bid) = split " ";

	sub process2 {
	    my @uniq;
	    my @letters = unpack('C*',$_[0]);
	    my $n_uniq = scalar grep { ++$uniq[$_] == 1 } @letters;

	    if ($n_uniq > 1) {
		my $mc = (sort { $uniq[$a] <=> $uniq[$b] } grep { $_ != ord("J") } @letters)[-1];
		@letters = map { $_ == ord("J") ? $mc : $_ } @letters;
	    }
	    @uniq = ();
	    $n_uniq = scalar grep { ++$uniq[$_] == 1 } @letters;
	    my $n_twice = (scalar grep { $uniq[$_] == 2 } @letters)/2;
	    
	    return 0 if $n_uniq == 1;
	    return 1 if $n_uniq == 2 and $n_twice == 0;
	    return 2 if $n_uniq == 2 and $n_twice == 1;
	    return 3 if $n_uniq == 3 and $n_twice == 0;
	    return 4 if $n_uniq == 3 and $n_twice == 2;
	    return 5 if $n_uniq == 4;
	    return 6 if $n_uniq == 5;
	    die;
	}

	my $hand_idx = process2($hand);
	push @{$hands[$hand_idx]}, $_;
	$n_hands++;
    }
    close(FH);


    foreach (0..$#hands) {
	next unless defined $hands[$_];
	@{$hands[$_]} = sort {
	      $order{substr($b, 0, 1)} <=> $order{substr($a, 0, 1)} or
	      $order{substr($b, 1, 1)} <=> $order{substr($a, 1, 1)} or
	      $order{substr($b, 2, 1)} <=> $order{substr($a, 2, 1)} or
	      $order{substr($b, 3, 1)} <=> $order{substr($a, 3, 1)} or
	      $order{substr($b, 4, 1)} <=> $order{substr($a, 4, 1)}
	  } @{$hands[$_]};

	foreach (@{$hands[$_]}) {
	    $sum += int((split(" ", $_))[1]) * $n_hands--;
	}
    }
  
    return $sum;
}

die unless part1("input_test1.txt") == $test1_answer;
print "Part 1: ", part1("input.txt"), "\n";

die unless part2("input_test1.txt") == $test2_answer;
print "Part 2: ", part2("input.txt"), "\n";
