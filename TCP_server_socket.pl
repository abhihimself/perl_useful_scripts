#!/usr/bin/perl
#tcpserver.pl
use strict;
use IO::Socket::INET;
use IO::Select;

# flush after every write
$| = 1;
my ($socket, $client_socket);
my ($peer_address, $peer_port);

$socket = IO::Socket::INET->new(
LocalHost => '127.0.0.1',
LocalPort => '8080',
Proto => 'tcp',
Listen => '5',
Reuse => 1

) or die("Unable to create socket $!");

print "Server is waiting for client connection at port 8080","\n";

while(1){
	$client_socket= $socket->accept();
	
	 $peer_address=$client_socket->peerhost();
	 $peer_port=$client_socket->peerport();
	 
	 print "Accepted New Client Connection From : $peer_address, $peer_port\n ";
	# sleep(5);
	my $data_to_send="hello Data from server";
	$client_socket->send("$data_to_send");
	 
	 my $data_to_receive;
	 $client_socket->recv($data_to_receive, 1024);
	 my $current_time=localtime();
	 print "Received from $data_to_receive at time $current_time","\n"	

}
$socket->close();