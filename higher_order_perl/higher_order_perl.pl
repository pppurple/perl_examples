#!/usr/local/bin/perl
use strict;
use warnings;

sub test {
	my $func = shift;
	$func->();
}

test(sub {print "hello"});

