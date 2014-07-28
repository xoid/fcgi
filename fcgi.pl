#!/usr/bin/perl

use AnyEvent;
use AnyEvent::FCGI;
use DBI;
use DBD::mysql;
use Data::Dump;

use strict;
my $path = '/root/fcgi';
open STDERR, '>>', $path.'/log/fcgi.log' or die 'Cant open '.$!;

my $dbh = DBI->connect("dbi:mysql:hh:localhost", 'hh',  'hh') or die "Cant connect MYSQl";

my $fcgi = new AnyEvent::FCGI(
								socket     => $path.'fcgi.sock',
						        on_request => &cb_req_handler
						     );

my $timer = AnyEvent->timer(
						        after => 10,
						        interval => 0,
						        cb => &cb_timer
						    );

AnyEvent->loop ;

sub cb_timer
{
    # shut down server after 10 seconds
    $fcgi = undef;
}


sub cb_req_handler
{
    my $request = shift;
	dd $request;

	my $tmpl = `cat $path/tmpl/firms`;
			
    $request->respond($tmpl, 'Content-Type' => 'text/plain',);
    #'OH HAI! QUERY_STRING is ' . $request->param('QUERY_STRING'),
}
