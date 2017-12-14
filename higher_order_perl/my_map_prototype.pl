#!/usr/local/bin/perl
use strict;
use warnings;

sub my_map (&@) {
	my $func = shift;
	my @result;
	for (@_) {
		push @result, $func->($_);
	}
	return @result;
}

my @nums = 1 .. 9;
my @double = my_map {$_[0] * 2} @nums;

print "before: @nums \n";
print "after: @double \n";