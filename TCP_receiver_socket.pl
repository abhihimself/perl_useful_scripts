#!/usr/bin/perl
#tcpserver.pl
use strict;
use IO::Socket::INET;

# flush after every write
$| = 1;
my ($socket, $client_socket ,$data);
my ($peer_address, $peer_port);


$socket = IO::Socket::INET->new(
LocalHost => '127.0.0.1',
LocalPort => '8185',
PeerHost => '127.0.0.1',
PeerPort => '8080',
Proto => 'tcp'
#Listen => '5',
#Reuse => 1

) or die("Unable to connect to server socket $!");
#sleep(5);
my $client_data= "HELLO Data from client";
$socket->send($client_data);


$socket->recv($data,1024);
my $current_time=localtime();
print "Data received at client socket: $data at time $current_time","\n";



#sleep(5);
$socket->close;