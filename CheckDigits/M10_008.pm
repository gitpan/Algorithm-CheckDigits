package Algorithm::CheckDigits::M10_008;

use 5.006;
use strict;
use warnings;
use integer;

our $VERSION = '0.53';

our @ISA = qw(Algorithm::CheckDigits);

my @weight = ( 1,3,1,7,3,9,1 );

sub new {
	my $proto = shift;
	my $type  = shift;
	my $class = ref($proto) || $proto;
	my $self  = bless({}, $class);
	$self->{type} = lc($type);
	return $self;
} # new()

sub is_valid {
	my ($self,$number) = @_;
	if ($number =~ /^(\d{6})(\d)$/) {
		return $2 == $self->_compute_checkdigit($1);
	}
	return ''
} # is_valid()

sub complete {
	my ($self,$number) = @_;
	if ($number =~ /^\d{6}$/) {
		return  $number . $self->_compute_checkdigit($number);
	}
	return '';
} # complete()

sub basenumber {
	my ($self,$number) = @_;
	if ($number =~ /^(\d{6})(\d)$/) {
		return $1 if ($2 == $self->_compute_checkdigit($1));
	}
	return '';
} # basenumber()

sub checkdigit {
	my ($self,$number) = @_;
	if ($number =~ /^(\d{6})(\d)$/) {
		return $2 if ($2 == $self->_compute_checkdigit($1));
	}
	return '';
} # checkdigit()

sub _compute_checkdigit {
	my $self   = shift;
	my $number = shift;

	if ($number =~ /^\d{6}$/) {

		my @digits = split(//,$number);
		my $sum    = 0;

		for (my $i = 0; $i <= $#digits; $i++) {

			$sum += $weight[$i] * $digits[$i];

		}
		return (10 - ($sum % 10) % 10);
	}
	return -1;
} # _compute_checkdigit()

# Preloaded methods go here.

1;
__END__

=head1 NAME

CheckDigits::M10_008 - compute check digits for Sedol (GB)

=head1 SYNOPSIS

  use Algorithm::CheckDigits;

  $sedol = CheckDigits('sedol');

  if ($sedol->is_valid('0123457')) {
	# do something
  }

  $cn = $sedol->complete('012345');
  # $cn = '0123457'

  $cd = $sedol->checkdigit('0123457');
  # $cd = '7'

  $bn = $sedol->basenumber('0123457');
  # $bn = '012345'
  
=head1 DESCRIPTION

=head2 ALGORITHM

=over 4

=item 1

Beginning left all numbers are weighted with 1,3,1,7,3,9 and 1
(checkdigit)

=item 2

The sum of all products is computed.

=item 3

The check digit is the difference of the sum from step 3 to the next
multiple of 10.

=back

=head2 METHODS

=over 4

=item is_valid($number)

Returns true only if C<$number> consists solely of numbers and the last digit
is a valid check digit according to the algorithm given above.

Returns false otherwise,

=item complete($number)

The check digit for C<$number> is computed and concatenated to the end
of C<$number>.

Returns the complete number with check digit or '' if C<$number>
does not consist solely of digits and spaces.

=item basenumber($number)

Returns the basenumber of C<$number> if C<$number> has a valid check
digit.

Return '' otherwise.

=item checkdigit($number)

Returns the checkdigit of C<$number> if C<$number> has a valid check
digit.

Return '' otherwise.

=back

=head2 EXPORT

None by default.

=head1 AUTHOR

Mathias Weidner, E<lt>mathias@weidner.in-bad-schmiedeberg.deE<gt>

=head1 SEE ALSO

L<perl>,
L<CheckDigits>,
F<www.pruefziffernberechnung.de>.

=cut
