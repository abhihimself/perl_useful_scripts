#!/usr/bin/perl
#tcpserver.pl
use strict;
use IO::Socket::INET;
use IO::Select;
my $data;
my @ready_clients;
my $select =IO::Select->new() or die("unable to create select $!");

my $socket=IO::Socket::INET->new(
LocalHost => '127.0.0.1',
LocalPort => '8080',
Listen => '5',
Proto => 'tcp',
Reuse => 1
) or die ("unable to create socket $!");

$select->add($socket);
print "Server socket is up for connections at port 8080","\n";

while(@ready_clients =$select->can_read(5)){
	
	
	#print @ready_clients ;
     foreach my $fh(@ready_clients){
		if($fh == $socket){
			my $new = $socket->accept;
			$select->add($new);
		}
		elsif($fh!= $socket){
			my $data_to_receive;
			 $fh->recv($data_to_receive, 1024);
			 print $data_to_receive,"\n";
		}

	}
	
	
}
while(@ready_clients =$select->can_write(5)){
foreach my $fn(@ready_clients){
	my $data_to_send='Hello from server';
	$fn->send("$data_to_send");
}	
}
