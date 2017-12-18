#!/usr/local/bin/perl

use strict;
use warnings;

use lib '../gen-perl';
use lib './lib';

use Thrift::Socket;
use Thrift::Server;
use Thrift::ServerSocket;

use exampleThrift::Types;
use exampleThrift::PeopleService;

package PeopleServiceHandler;
use base qw(exampleThrift::PeopleServiceIf);

sub new {
    my $classname = shift;
    my $self      = {};

    return bless($self,$classname);
}

sub searchByName{
  my $self = shift;
  my $query = shift;

  print "query: $query \n";

  # dummy response.(emulate search by query from DB)
  my $alice = new exampleThrift::Person({name => 'Alice Wall', age => 33, country => exampleThrift::Country::JAPAN, hobby => 'trick'});
  my $bobby = new exampleThrift::Person({name => 'Bobby Wall', age => 29, country => exampleThrift::Country::AMERICA, hobby => 'yo-yo'});

  my @people;
  push @people, $alice;
  push @people, $bobby;

  return \@people;
}

eval {
  my $handler       = new PeopleServiceHandler;
  my $processor     = new exampleThrift::PeopleServiceProcessor($handler);
  my $serversocket  = new Thrift::ServerSocket(8080);
  my $forkingserver = new Thrift::SimpleServer($processor, $serversocket);

  # ForkingServer that forks a new process for each request
  #my $forkingserver = new Thrift::ForkingServer($processor, $serversocket);

  print "Starting the server... \n";
  $forkingserver->serve();
  print "done.\n";

}; if ($@) {
  if ($@ =~ m/TException/ and exists $@->{message}) {
    my $message = $@->{message};
    my $code    = $@->{code};
    my $out     = $code . ':' . $message;
    die $out;
  } else {
    die $@;
  }
}

