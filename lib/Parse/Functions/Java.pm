package Parse::Functions::Java;

use 5.008;
use strict;
use warnings;
use Parse::Functions;

our $VERSION = '0.01';
our @ISA     = qw(Parse::Functions);

######################################################################

my $newline =
	qr{\cM?\cJ}; # recognize newline even if encoding is not the platform default (will not work for MacOS classic)
my $method_search_regex = qr{
			/\*.+?\*/          # block comment
			|
			\/\/.+?$newline    # line comment
			|
			(?:^|$newline)     # text start or newline 
			\s* 
			(?:
			  (?:
				(?: public|protected|private|abstract|static|
				final|native|synchronized|transient|volatile|
				strictfp)
				\s+
			  ){0,2}            # zero to 2 method modifiers
			  (?: <\w+>\s+ )?   # optional: generic type parameter
			  (?: [\w\[\]<>]+)  # return data type
			  \s+
			  (\w+)             # method name
			  \s*
			  \(.*?\)           # parentheses around the parameters
			)
	}sx;

sub find {
	my ($self, $text, $sort) = @_;

	my @functions = grep { defined $_ } $text =~ /$method_search_regex/g;

	return @{ $self->sort_functions( \@functions, $sort ) };
}

1;

# Copyright 2008-2013 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.

