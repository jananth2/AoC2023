use strict;
use warnings;
use Smart::Comments;

my $test1_answer = 288;
my $test2_answer = 71503;

sub part1 ($) {
  open(FH, '<', shift) or die $!;
  my @times = map { int } split(" ", (split /:/, <FH>)[1]);
  my @dists = map { int } split(" ", (split /:/, <FH>)[1]);

  my $ans = 1;
  foreach my $i (0..$#times) {
      $ans *= scalar grep { fn_time_to_dist($_, $times[$i]) > $dists[$i] } (0..$times[$i]);
  }
  
  sub fn_time_to_dist ($$) {
      my $time_held = int(shift);
      my $time_total = int(shift);
      my $time_left = $time_total - $time_held;
      
      my $dist = $time_held * $time_left;
      return $dist;
  }
  close(FH);

  return $ans;
}

sub part2 ($) {
  open(FH, '<', shift) or die $!;
  my @times = map { int } join("", split(" ", (split /:/, <FH>)[1]));
  my @dists = map { int } join("", split(" ", (split /:/, <FH>)[1]));

  my $ans = 1;
  foreach my $i (0..$#times) {
      $ans *= scalar grep { fn_time_to_dist($_, $times[$i]) > $dists[$i] } (0..$times[$i]);
  }
  
  sub fn_time_to_dist ($$) {
      my $time_held = int(shift);
      my $time_total = int(shift);
      my $time_left = $time_total - $time_held;
      
      my $dist = $time_held * $time_left;
      return $dist;
  }
  close(FH);

  return $ans;
}

die unless part1("input_test1.txt") == $test1_answer;
print "Part 1: ", part1("input.txt"), "\n";

die unless part2("input_test1.txt") == $test2_answer;
print "Part 2: ", part2("input.txt"), "\n";
