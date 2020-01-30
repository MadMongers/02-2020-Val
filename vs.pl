#!/usr/bin/env perl
use v5.20;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use Validate::Simple;

# Yes, I was watching 'Last Man Standing' while typing this
sub mikebaxter ($username, $age) {
    my %input = ( _username => $username, _age => $age);
    my $specs = { _username => { type       => 'string',
                                 required   => 1,
	                         min_length => 1,
                                 max_length => 25,
                               },
                 _age       => { type => 'positive_int',
                                 lt   => 40,
                               },
                };

    my $vs1 = Validate::Simple->new( $specs );
    my $is_valid1 = $vs1->validate( \%input );

    if (!$is_valid1) {
        print join "\n",  $vs1->errors();
    }
    say "good"  if  $is_valid1;
    say "\nbad" if !$is_valid1;
}

mikebaxter('jime',10);
mikebaxter('jime',101);
mikebaxter('',10);
mikebaxter('',101);


