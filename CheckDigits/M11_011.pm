package Algorithm::CheckDigits::M11_011;

use 5.006;
use strict;
use warnings;
use integer;

require Exporter;

our @ISA = qw(Exporter Algorithm::CheckDigits);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use CheckDigits ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( 'new', @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = ();

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
	if ($number =~ /^([0-9]+)(\d)$/) {
		return $2 == $self->_compute_checkdigits($1);
	}
	return ''
} # is_valid()

sub complete {
	my ($self,$number) = @_;
	if ($number =~ /^([0-9]+)$/
	   and (my $cd = $self->_compute_checkdigits($1)) ne '') {
		return $1 . $cd;
	}
	return '';
} # complete()

sub basenumber {
	my ($self,$number) = @_;
	if ($number =~ /^([0-9]+)(\d)$/) {
		return $1 if ($2 == $self->_compute_checkdigits($1));
	}
	return '';
} # basenumber()

sub checkdigit {
	my ($self,$number) = @_;
	if ($number =~ /^([0-9]+)(\d)$/) {
		return $2 if ($2 == $self->_compute_checkdigits($1));
	}
	return '';
} # checkdigit()

sub _compute_checkdigits {
	my $self   = shift;
	my $number = shift;

	$number =~ s/\.//g;

	my @digits = split(//,$number);
	my $len = scalar(@digits) + 1;
	my $sum = 0;
	for (my $i = 0; $i <= $#digits; $i++) {
		$sum += ($len - $i) * $digits[$i];
	}
	$sum %= 11;
	return ($sum == 10) ? '' : $sum;
} # _compute_checkdigit()

# Preloaded methods go here.

1;
__END__

=head1 NAME

CheckDigits::M11_011 - compute check digits for VAT Registration Number (NL)

=head1 SYNOPSIS

  use CheckDigits;

  $ustid = CheckDigits('ustid_nl');

  if ($ustid->is_valid('123456782')) {
	# do something
  }

  $cn = $ustid->complete('12345678');
  # $cn = '123456782'

  $cd = $ustid->checkdigit('123456782');
  # $cd = '2'

  $bn = $ustid->basenumber('123456782');
  # $bn = '12345678';
  
=head1 DESCRIPTION

=head2 ALGORITHM

=over 4

=item 1

Beginning right with the digit before the checkdigit all digits are
weighted with their position. I.e. the digit before the checkdigit is
multiplied with 2, the next with 3 and so on.

=item 2

The weighted digits are added.

=item 3

The sum from step 2 is taken modulo 11.

=item 4

If the sum from step 3 is 10, the number is discarded.

=back

=head2 METHODS

=over 4

=item is_valid($number)

Returns true only if C<$number> consists solely of numbers and hyphens
and the two digits in the middle
are valid check digits according to the algorithm given above.

Returns false otherwise,

=item complete($number)

The check digit for C<$number> is computed and inserted into the
middle of C<$number>.

Returns the complete number with check digit or '' if C<$number>
does not consist solely of digits, hyphens and spaces.

=item basenumber($number)

Returns the basenumber of C<$number> if C<$number> has a valid check
digit.

Return '' otherwise.

=item checkdigit($number)

Returns the check digits of C<$number> if C<$number> has valid check
digits.

Return '' otherwise.

=back

=head2 EXPORT

None by default.

=head1 AUTHOR

Mathias Weidner, E<lt>mathias@weidner.in-bad-schmiedeberg.deE<gt>

=head1 SEE ALSO

L<perl>,
L<CheckDigits>,
F<www.pruefziffernberechnung.de>,

=cut
