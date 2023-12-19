use strict;
use warnings;

# variables
my $test1_answer = 4361;
my $test2_answer = 0;

sub part1 ($) {
  open(FH, '<', shift) or die $!;

  my $sum = 0;
  my @nums = ();

  my @lines = <FH>;
  my @chars = map { split //, $_ } @lines;

  foreach my $i (0..@chars-1) {
    if ($i == 0) {
      print "begin\n";
    }
    if ($i == @chars-1) {
      print "end\n";
    }
    my $len = $@{$chars[0]};
    print $len;
    foreach my $j (0..$len-1) {
      # print "$@{$chars->[$i]}[$j]";
    }
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
