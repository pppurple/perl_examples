#!/usr/local/bin/perl

use strict;
use warnings;

use lib './lib';
use lib '../gen-perl';

use Thrift;
use Thrift::BinaryProtocol;
use Thrift::Socket;
use Thrift::BufferedTransport;

use exampleThrift::Types;
use exampleThrift::PeopleService;

use Data::Dumper;

my $socket    = new Thrift::Socket('localhost',8080);
my $transport = new Thrift::BufferedTransport($socket,1024,1024);
my $protocol  = new Thrift::BinaryProtocol($transport);
my $client    = new exampleThrift::PeopleServiceClient($protocol);

eval{
    $transport->open();
    
    my $response = $client->searchByName("Wall");
    print "response: " . Dumper($response);

#    print "@$response[0]->{name} \n";
#    print "@$response[0]->{age} \n";
#    print "@$response[0]->{country} \n";
#    print "@$response[0]->{hobby} \n";

    $transport->close();

}; if($@){
    warn(Dumper($@));
}
