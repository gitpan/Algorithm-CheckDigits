package Algorithm::CheckDigits::M97_002;

use 5.006;
use strict;
use warnings;
use integer;

use Math::BigInt;

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

my %subst = (
	A => 10, B => 11, C => 12, D => 13, E => 14,
	F => 15, G => 16, H => 17, I => 18, J => 19,
	K => 20, L => 21, M => 22, N => 23, O => 24,
	P => 25, Q => 26, R => 27, S => 28, T => 29,
	U => 30, V => 31, W => 32, X => 33, Y => 34,
	Z => 35,
);

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
	if ($number =~ /^[A-Z]{2}(\d\d)\s?[\d ]{0,37}$/i) {
		return $1 eq $self->_compute_checkdigit($number);
	}
	return ''
} # is_valid()

sub complete {
	my ($self,$number) = @_;
	if ($number =~ /^([A-Z]{2})(00)(\s?[\d ]{0,37})$/i) {
		return $1 . $self->_compute_checkdigit($number) . $3;
	}
	return '';
} # complete()

sub basenumber {
	my ($self,$number) = @_;
	if ($number =~ /^([A-Z]{2})(\d\d)(\s?[\d ]{0,37})$/i) {
		return $1.'00'.$3 if ($2 eq $self->_compute_checkdigit($number));
	}
	return '';
} # basenumber()

sub checkdigit {
	my ($self,$number) = @_;
	if ($number =~ /^([A-Z]{2})(\d\d)(\s?[\d ]{0,37})$/i) {
		return $2 if ($2 eq $self->_compute_checkdigit($number));
	}
	return '';
} # checkdigit()

sub _compute_checkdigit {
	my $self   = shift;
	my $number = shift;

	$number =~ s/\s//g;

	if ($number =~ /^([A-Z])([A-Z])..([ \d]{0,37})$/i) {
		my $bignum = Math::BigInt->new($3.$subst{$1}.$subst{$2}.'00');
		my $mod    = $bignum % 97;
		return sprintf("%2.2d",(98 - $mod));
	}
	return -1;
} # _compute_checkdigit()

# Preloaded methods go here.

1;
__END__

=head1 NAME

CheckDigits::M97_002 - compute check digits for International Bank
Account Number (IBAN)

=head1 SYNOPSIS

  use CheckDigits;

  $iban = CheckDigits('iban');

  if ($iban->is_valid('DE88 2008 0000 09703 7570 0')) {
	# do something
  }

  $cn = $iban->complete('DE00 2008 0000 09703 7570 0');
  # $cn = 'DE88 2008 0000 09703 7570 0'

  $cd = $iban->checkdigit('DE88 2008 0000 09703 7570 0');
  # $cd = '88'

  $bn = $iban->basenumber('DE88 2008 0000 09703 7570 0');
  # $bn = 'DE00 2008 0000 09703 7570 0'
  
=head1 DESCRIPTION

=head2 ALGORITHM

=over 4

=item 0

The IBAN number must be prepared. The first two letters and the
checksum will be moved to the right end. The letters are substituted
according to the substitute table and the checksum is set to '00'.

=item 1

The whole number (without checksum) is taken modulo 97.

=item 2

The checksum is difference between 98 and the sum of step 2.

=item 3

If the checksum is smaller then 10, a leading zero will be
supplemented.

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

Returns the checkdigits of C<$number> if C<$number> has a valid check
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
