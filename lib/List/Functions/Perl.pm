package List::Functions::Perl;

use 5.008;
use strict;
use warnings;

use List::Functions;

our $VERSION = '0.01';
our @ISA = qw(List::Functions);

# TODO: the regex containing func|method should either reuse what
# Padre has in PPIx::EditorTools::Outline or copy the list from there
# for now let's leave it as it is and focus on improving the Outline
# code and then we'll see if we reuse or copy paste.

# recognize newline even if encoding is not the platform default (will not work for MacOS classic)
my $newline = qr{\cM?\cJ};

our $sub_search_re = qr{
		(?:
			${newline}__(?:DATA|END)__\b.*
			|
			$newline$newline=\w+.*?$newline\s*?$newline=cut\b(?=.*?(?:$newline){1,2})
			|
			(?:^|$newline)\s*
			(?:
				(?:sub|func|method|before|after|around|override|augment)\s+(\w+(?:::\w+)*)
				|
				\* (\w+(?:::\w+)*) \s*=\s* (?: sub\b | \\\& )
			)
		)
	}sx;

sub find {
	my ($self, $text, $sort) = @_;

	my @functions = grep { defined $_ } $text =~ /$sub_search_re/g;

	return $self->sort_functions( \@functions, $sort );
}

1;

# Copyright 2008-2013 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.

