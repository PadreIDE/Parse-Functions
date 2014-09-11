#!/usr/bin/perl

# Tests the logic for extracting the list of functions in a program

use strict;
use warnings;
use Test::More;

plan( tests => 2 );

use List::Functions ();

my $lf = new_ok(
	'List::Functions',
);

is_deeply [ $lf->find() ], [], 'empty list';


