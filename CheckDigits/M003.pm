package Algorithm::CheckDigits::M003;

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

my %prefix = (
	'amex'		=> [ '34', '37' ],
	'bahncard'	=> [ '70' ],
	'diners'	=> [ '30[0-5]', '36', '38' ],
	'discover'	=> [ '6011' ],
	'enroute'	=> [ '2014', '2149' ],
	'jcb'		=> [ '1800', '2131', '3088' ],
	'mastercard'	=> [ '5[1-5]' ],
	'miles&more'	=> [ '99', '22' ],
	'visa'		=> [ '4' ],
);

# Aliases
$prefix{'eurocard'} = $prefix{'mastercard'};

# omit prefixes doesn't work with the test numbers
my %omitprefix = (
	'jcb'		=> 0,
	'enroute'	=> 0,
	'discover'	=> 0,
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
	if ($number =~ /^([0-9 ]*)([0-9])$/) {
		return $2 == $self->_compute_checkdigit($1);
	}
	return ''
} # is_valid()

sub complete {
	my ($self,$number) = @_;
	if ($number =~ /^[0-9 ]*$/) {
		return  $number . $self->_compute_checkdigit($number);
	}
	return '';
} # complete()

sub basenumber {
	my ($self,$number) = @_;
	if ($number =~ /^([0-9 ]*)([0-9])$/) {
		return $1 if ($2 == $self->_compute_checkdigit($1));
	}
	return '';
} # basenumber()

sub checkdigit {
	my ($self,$number) = @_;
	if ($number =~ /^([0-9 ]*)([0-9])$/) {
		return $2 if ($2 == $self->_compute_checkdigit($1));
	}
	return '';
} # checkdigit()

sub _compute_checkdigit {
	my $self   = shift;
	my $number = shift;
	$number =~ s/\s//g;
	if ($omitprefix{$self->{type}}) {
		my $pf = $prefix{$self->{type}};
		for my $p (@{$pf}) {
			if ($number =~ /^$p([0-9]+)$/) {
				$number = $1;
				last;
			}
		}
	}
	if ($number =~ /^([0-9]*)$/) {
		my @digits = split(//,$number);
		my $even = 1;
		my $sum  = 0;
		for (my $i = $#digits;$i >= 0;$i--) {
			if ($even) {
				my $tmp = 2 * $digits[$i];
				$sum += $tmp / 10 + $tmp % 10;
			} else {
				$sum += $digits[$i];
			}
			$even = not $even;
		}
		return (10 - $sum % 10) % 10;
	}
	return -1;
} # _compute_checkdigit()

# Preloaded methods go here.

1;
__END__

=head1 NAME

CheckDigits::M003 - compute check digits method 003

=head1 SYNOPSIS

  use CheckDigits;

  $visa = CheckDigits('visa');

  if ($visa->is_valid('4111 1111 1111 1111')) {
	# do something
  }

  $cn = $visa->complete('4111 1111 1111 111');
  # $cn = '4111 1111 1111 1111'

  $cd = $visa->checkdigit('4111 1111 1111 1111');
  # $cd = '7'

  $bn = $visa->basenumber('4111 1111 1111 1111');
  # $bn = '4111 1111 1111 111'
  
=head1 DESCRIPTION

=head2 ALGORITHM

=over 4

=item 1

Beginning right all numbers are weighted alternatively 1 and 2 (that
is the check digit is weighted 1).

=item 2

The total of the digits of all products is computed.

=item 3

The sum of step 3 ist taken modulo 10.

=item 4

The check digit is the difference between 10 and the number from step
3.

=back

To validate the total of the digits of all numbers inclusive check
digit taken modulo 10 must be 0.

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
