#!/usr/bin/env perl
use v5.20;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use Validate::Tiny ':all';

# Jim's Library
sub jim_s_validrange {
    my ( $value, $params ) = @_;

    if ( $value < 1  ) { return 'Pat, I want a positive number.'; }
    if ( $value > 40 ) { return 'Whoa, Nellie'; }
    return;
}


# program's subroutines
# Yes, I was watching 'Last Man Standing'
sub mikebaxter ($username,$age) {
    my %input = ( _username => $username, _age => $age);

    my $rules = {
#        fields => [qw/_username _age/], # List of fields to look for
        fields  => [],                  # List of fields to look for
        filters => [],                  # Filters to run on all fields
        checks  => [                    # Checks to perform on all fields
            _username => [ is_required(), is_long_between( 1, 25, 'string is bad' ), ],
	    _age      => [ is_required(), \&jim_s_validrange ,                       ],
        ],
    };
 
    my $result = validate( \%input, $rules ); # Validate the input againts the rules
 
    if     ( $result->{success} ) { my $values_hash = $result->{data};  say "good";}
    else                          { my $errors_hash = $result->{error}; say "bad"; }
}

mikebaxter('jime',10);
mikebaxter('jime',101);
mikebaxter('',101);
