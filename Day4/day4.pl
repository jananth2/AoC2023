use strict;
use warnings;

# variables
my $test1_answer = 13;
my $test2_answer = 30;

sub part1 ($) {
  open(FH, '<', shift) or die $!;

  my $sum = 0;
  my @nums = ();
  
  while(<FH>) {
    my @card = split /:/;
    my ($winning, $mine) = split /\|/, $card[1];
    my @winning_nums = split " ", $winning;
    my @my_nums = split " ", $mine;
    
    my %nums = ();
    foreach my $n (@my_nums) {
      $nums{$n} = 1;
    }

    my $matches = 0;
    foreach my $n (@winning_nums) {
      if (exists $nums{$n}) {
	$matches = (($matches == 0) ? 1 : $matches * 2);
      }
    }
    $sum += $matches;
  }
  
  close(FH);
  return $sum;
}

sub part2 ($) {
  open(FH, '<', shift) or die $!;

  my $sum = 0;
  my @nums = ();
  my %T = ();
  
  while(<FH>) {
    $T{$.}++;

    my @card = split /:/;
    my ($winning, $mine) = split /\|/, $card[1];
    my @winning_nums = split " ", $winning;
    my @my_nums = split " ", $mine;
    
    my %nums = ();
    foreach my $n (@my_nums) {
      $nums{$n} = 1;
    }

    my $matches = 0;
    foreach my $n (@winning_nums) {
      if (exists $nums{$n}) {
	# $matches = (($matches == 0) ? 1 : $matches * 2);
	$matches++;
	$T{$. + $matches} += $T{$.};
      }
    }
    $sum += $T{$.};
  }
  
  close(FH);
  return $sum;
}

die unless part1("input_test1.txt") == $test1_answer;
print "Part 1: ", part1("input.txt"), "\n";

die unless part2("input_test1.txt") == $test2_answer;
print "Part 2: ", part2("input.txt"), "\n";
