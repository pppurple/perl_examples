#!/usr/local/bin/perl
use strict;
use warnings;

sub my_grep {
	my ($func, $list) = @_;
	my @result;
	for (@$list) {
		push @result, $_ if ($func->($_)); 
	}
	return @result;
}

my @nums = 1 .. 9;
my @odd = my_grep(sub {$_[0] % 2}, \@nums);

print "before: @nums \n";
print "after: @odd \n";
