use strict;
use warnings;

my $test1_answer = 0;
my $test2_answer = 0;

sub part1 ($) {
  open(FH, '<', shift) or die $!;

  my $sum = 0;
  while(<FH>) {

  }
  
  close(FH);
  return $sum;
}

sub part2 ($) {
  open(FH, '<', shift) or die $!;

  my $sum = 0;
  while(<FH>) {

  }

  close(FH);
  return $sum;
}

die unless part1("input_test1.txt") == $test1_answer;
print "Part 1: ", part1("input.txt"), "\n";

# die unless part2("input_test2.txt") == $test2_answer;
# print "Part 2: ", part2("input.txt"), "\n";
