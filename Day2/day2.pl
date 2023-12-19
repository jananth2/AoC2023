use strict;
use warnings;

# variables
my $test1_answer = 8;
my $test2_answer = 2286;

sub part1 ($) {
  open(FH, '<', shift) or die $!;

  my $sum = 0;
  while(<FH>) {
    my ($R, $G, $B) = (0, 0, 0);
    
    my @games = split /:/;
    shift @games;

    my @rounds = split(/;/, $games[0]);
    foreach (@rounds) {
      my @grabs = split /,/;
      foreach (@grabs) {
	my ($n, $color) = split;
	$R = int($n) if $color eq "red"   and int($n) > $R;
	$G = int($n) if $color eq "green" and int($n) > $G;
	$B = int($n) if $color eq "blue"  and int($n) > $B;
      }
    }
    
    $sum += $. if ($R <= 12 and $G <= 13 and $B <= 14);
  }
  
  close(FH);
  return $sum;
}

sub part2 ($) {
  open(FH, '<', shift) or die $!;

  my $sum = 0;
  while(<FH>) {
    my ($R, $G, $B) = (0, 0, 0);
    
    my @games = split /:/;
    shift @games;

    my @rounds = split(/;/, $games[0]);
    foreach (@rounds) {
      my @grabs = split /,/;
      foreach (@grabs) {
	my ($n, $color) = split;
	$R = int($n) if $color eq "red"   and int($n) > $R;
	$G = int($n) if $color eq "green" and int($n) > $G;
	$B = int($n) if $color eq "blue"  and int($n) > $B;
      }
    }
    
    $sum += $R * $G * $B;
  }
  
  close(FH);
  return $sum;
}

die unless part1("input_test1.txt") == $test1_answer;
print "Part 1: ", part1("input.txt"), "\n";

die unless part2("input_test1.txt") == $test2_answer;
print "Part 2: ", part2("input.txt"), "\n";
