use strict;
use warnings;

# change daily
my $day            = 1;
my $test1_answer   = 142;
my $test2_answer   = 281;

# constant
my $input_fn       = "input${day}.txt";
my $input_test1_fn = "input${day}_test1.txt";
my $input_test2_fn = "input${day}_test2.txt";

sub part1 ($) {
  open(FH, '<', shift) or die $!;

  my $sum = 0;
  while (<FH>) {
    /^.*?(\d)/ unless /^.*?(\d).*(\d).*?$/;
    $sum += int($2 ? $1.$2 : $1.$1);
  }

  close(FH);
  
  return $sum;
}

sub part2 ($) {
  open(FH, '<', shift) or die $!;

  my %map = (
	     "one"	=> 1, "1" => 1,
	     "two"	=> 2, "2" => 2,
	     "three"	=> 3, "3" => 3,
	     "four"	=> 4, "4" => 4,
	     "five"	=> 5, "5" => 5,
	     "six"	=> 6, "6" => 6,
	     "seven"	=> 7, "7" => 7,
	     "eight"	=> 8, "8" => 8,
	     "nine"	=> 9, "9" => 9,
	     );
  my $number = "one|two|three|four|five|six|seven|eight|nine";
  
  my $sum = 0;
  while (<FH>) {
    /^.*?(\d|$number)/ unless /^.*?(\d|$number).*(\d|$number).*?$/;
    $sum += int($2 ? $map{$1}.$map{$2} : $map{$1}.$map{$1});
  }

  close(FH);
  
  return $sum;
}

die unless part1($input_test1_fn) == $test1_answer;
print "Part 1: ", part1($input_fn), "\n";

die unless part2($input_test2_fn) == $test2_answer;
print "Part 2: ", part2($input_fn), "\n";
