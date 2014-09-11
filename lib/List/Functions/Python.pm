package List::Functions::Python;

use 5.008;
use strict;
use warnings;
use List::Functions;

our $VERSION = '0.01';
our @ISA     = qw(List::Functions);

######################################################################

my $n = "\\cM?\\cJ";
our $function_search_re = qr/
		(?:
			\"\"\".*?\"\"\"
			|
			(?:^|$n)\s*
			(?:
				(?:def)\s+(\w+)
				|
				(?:(\w+)\s*\=\s*lambda)
			)
		)
	/sx;

sub find {
	my ($self, $text, $sort) = @_;

	my @functions = grep { defined $_ } $text =~ /$function_search_re/g;

	return @{ $self->sort_functions( \@functions, $sort ) };
}

1;

# Copyright 2008-2013 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.

