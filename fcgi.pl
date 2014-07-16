#!/usr/bin/perl

use AnyEvent;
use AnyEvent::FCGI;
use DBI;
use DBD::mysql;
use Data::Dump;

use strict;

open STDERR, '>>', '/tmp/fcgi.log' or die 'Cant open '.$!;

my $dbh = DBI->connect("dbi:mysql:hh:localhost", 'hh',  'hh') or die "Cant connect MYSQl";

my $fcgi = new AnyEvent::FCGI(
		socket     => '/var/run/hh.socket',
        on_request => &cb_req_handler
    );

#    my $timer = AnyEvent->timer(
#        after => 10,
#        interval => 0,
#        cb => sub {
#            # shut down server after 10 seconds
#            $fcgi = undef;
#        }
#    );

AnyEvent->loop;

sub cb_req_handler
{
            my $request = shift;
			dd $request;

			my $tmpl = `cat tmpl/firms`;
			
            $request->respond($tmpl, 'Content-Type' => 'text/plain',);
                #'OH HAI! QUERY_STRING is ' . $request->param('QUERY_STRING'),
      
}
