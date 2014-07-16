#!/usr/bin/perl

use POE;
use POE::Component::FastCGI;

use DBI;
use DBD::mysql;

use strcict;

my $dbh = DBI->connect("dbi:mysql:vul:localhost", "vul",  "vul") or die "Cant connect MYSQl";

POE::Component::FastCGI->new(
   Address => '/var/run/hh.sock',
   Handlers =>  [
        			[ '/' => 'poe_event_name' ],
				]
     Session => 'MAIN',
  );

  sub default {
     my($request) = @_;

     my $response = $request->make_response;
     $response->header("Content-type" => "text/html");
     $response->content("A page");
     $response->send;
  }
