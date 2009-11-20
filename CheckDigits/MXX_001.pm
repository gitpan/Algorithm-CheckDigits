package Algorithm::CheckDigits::MXX_001;

use 5.006;
use strict;
use warnings;
use integer;

our $VERSION = '0.53';

our @ISA = qw(Algorithm::CheckDigits);

my @weight = ( 7,3,1,7,3,1,7,3,1,7,3,1,7,3,1,7,3,1,7,3,1,7,3,1, );

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
	if ($number =~ /^\d{9}(\d).<+\d{6}(\d)<+\d{6}(\d)<+(\d)$/) {
		my @cd = $self->_compute_checkdigit($number);
		return 1 if (   $cd[0] == $1 and $cd[1] == $2
		            and $cd[2] == $3 and $cd[3] == $4
			    );
	}
	return ''
} # is_valid()

sub complete {
	my ($self,$number) = @_;
	if ($number =~ /^(\d{9}).(.<+\d{6}).(<+\d{6}).(<+).$/) {
		my @cd = $self->_compute_checkdigit($number);
		return $1 . $cd[0] . $2 . $cd[1] . $3 . $cd[2] . $4 .  $cd[3];
	}
	return '';
} # complete()

sub basenumber {
	my ($self,$number) = @_;
	if ($number =~ /^(\d{9})(\d)(.<+\d{6})(\d)(<+\d{6})(\d)(<+)(\d)$/) {
		my @cd = $self->_compute_checkdigit($number);
		return $1 . '_' . $3 . '_' . $5 . '_' . $7 . '_'
			if (   $cd[0] == $2 and $cd[1] == $4
		           and $cd[2] == $6 and $cd[3] == $8
			   );
	}
	return '';
} # basenumber()

sub checkdigit {
	my ($self,$number) = @_;
	if ($number =~ /^\d{9}(\d).<+\d{6}(\d)<+\d{6}(\d)<+(\d)$/) {
		my @cd = $self->_compute_checkdigit($number);
		return join('<',@cd)
			if (   $cd[0] == $1 and $cd[1] == $2
		           and $cd[2] == $3 and $cd[3] == $4
			   );
	}
	return '';
} # checkdigit()

sub _compute_checkdigit {
	my $self   = shift;
	my $number = shift;
	my $compute = sub {
		my $digits = shift;
		my ($sum,$i) = (0,0);
		while ($digits =~ /(\d)/g) {
			$sum += $1 * $weight[$i++];
		}
		return $sum % 10;
	};

	if ($number =~ /^(\d{9})..<+(\d{6}).<+(\d{6}).<+.$/) {
		my @cd;
		$cd[0] = $compute->($1);
		$cd[1] = $compute->($2);
		$cd[2] = $compute->($3);
		$cd[3] = $compute->($1 . $cd[0] . $2 . $cd[1] . $3 . $cd[2]);
		return @cd;
	}
	return ();
} # _compute_checkdigit()

# Preloaded methods go here.

1;
__END__

=head1 NAME

CheckDigits::MXX_001 - compute check digits for PA (DE)

=head1 SYNOPSIS

  use Algorithm::CheckDigits;

  $pa = CheckDigits('pa_de');

  if ($pa->is_valid('2406055684D<<6810203<0705109<6')) {
	# do something
  }

  $cn = $pa->complete('240605568_D<<681020_<070510_<_');
  # $cn = '2406055684D<<6810203<0705109<6'

  $cd = $pa->checkdigit('2406055684D<<6810203<0705109<6');
  # $cd = '6'

  $bn = $pa->basenumber('2406055684D<<6810203<0705109<6');
  # $bn = '240605568_D<<681020_<070510_<_'
  
=head1 DESCRIPTION

=head2 ALGORITHM

=over 4

=item 1

Beginning left all digits are weighted with 7,3,1,7,3,1,...

=item 2

The sum of those products is computed.

=item 3

The checksum is the last digit of the sum from step 2 (modulo 10).

=item 4

Step 1 to 3 is performed for every part of the number and for all 3
parts including the particular checkdigit to compute the total
checksum.

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

=head1 THANKS

Aaron W. West pointed me to a fault in the computing of the check
digit.

=head1 SEE ALSO

L<perl>,
L<CheckDigits>,
F<www.pruefziffernberechnung.de>,
F<www.export911.com/e911/coding/upcChar.htm>,
F<www.adams1.com/pub/russadam/upccode.html>,
F<http://www.upcdatabase.com>.

=cut
