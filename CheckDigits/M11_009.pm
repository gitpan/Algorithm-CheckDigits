package Algorithm::CheckDigits::M11_009;

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

my @weight = ( 2, 7, 6, 5, 4, 3, 2 );

my @keys   = ('', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'Z', 'J' );

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
	if ($number =~ /^([fgst])(\d{7})([a-jz])$/i) {
		return (uc($3) eq $self->_compute_checkdigits($2));
	}
	return ''
} # is_valid()

sub complete {
	my ($self,$number) = @_;
	if($number =~ /^([fgst])(\d{7})$/i) {
		return $1 . $2 . $self->_compute_checkdigits($2);
	}
	return '';
} # complete()

sub basenumber {
	my ($self,$number) = @_;
	return "$1$2" if(   $number =~ /^([fgst])(\d{7})([a-jz])$/i
	              and uc($3) eq $self->_compute_checkdigits($2));
	return '';
} # basenumber()

sub checkdigit {
	my ($self,$number) = @_;
	if ($number =~ /^([fgst])(\d{7})([a-jz])$/i) {
		return $self->_compute_checkdigits($2);
	}
	return undef;
} # checkdigit()

sub _compute_checkdigits {
	my $self    = shift;

	my @digits = split(//,shift);
	my $sum = 0;
	for (my $i = 0; $i <= $#digits; $i++) {
		$sum += $weight[$i] * $digits[$i];
	}
	$sum %= 11;
	return $keys[11 - $sum];
} # _compute_checkdigit()

# Preloaded methods go here.

1;
__END__

=head1 NAME

CheckDigits::M11_009 - compute check digits method 11-009

=head1 SYNOPSIS

  use CheckDigits;

  $nric = CheckDigits('nric_sg');

  if ($nric->is_valid('S1234567D')) {
	# do something
  }

  $cn = $nric->complete('S1234567');
  # $cn = 'S1234567D'

  $cd = $nric->checkdigit('S1234567D');
  # $cd = 'D'

  $bn = $nric->basenumber('S1234567D');
  # $bn = 'S1234567';
  
=head1 DESCRIPTION

=head2 ALGORITHM

=over 4

=item 1

Beginning left every digit is weighted with 2, 7, 6, 5, 4, 3, 2

=item 2

The weighted digits are added.

=item 3

The sum from step 2 is taken modulo 11.

=item 4

The checkdigit is 11 minus the sum from step 3 converted to a
character according to the following table:

  @cd = ('','A','B','C','D','E','F','G','H','I','Z','J', );

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

Returns '' if C<$number> is valid.

Return undef otherwise.

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
