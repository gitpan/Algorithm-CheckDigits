package Algorithm::CheckDigits;

use 5.006;
use strict;
use warnings;
use Carp;
use vars qw($AUTOLOAD);

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use CheckDigits ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	CheckDigits method_list print_methods
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw( CheckDigits );

our $VERSION = '0.27';

my %methods = (
	'm001'			=> 'Algorithm::CheckDigits::M001',
	'm002'			=> 'Algorithm::CheckDigits::M002',
	'euronote'		=> 'Algorithm::CheckDigits::M002',
	'm003'			=> 'Algorithm::CheckDigits::M003',
	'amex'			=> 'Algorithm::CheckDigits::M003',
	'bahncard'		=> 'Algorithm::CheckDigits::M003',
	'diners'		=> 'Algorithm::CheckDigits::M003',
	'discover'		=> 'Algorithm::CheckDigits::M003',
	'enroute'		=> 'Algorithm::CheckDigits::M003',
	'eurocard'		=> 'Algorithm::CheckDigits::M003',
	'happydigits'		=> 'Algorithm::CheckDigits::M003',
	'jcb'			=> 'Algorithm::CheckDigits::M003',
	'klubkarstadt'		=> 'Algorithm::CheckDigits::M003',
	'mastercard'		=> 'Algorithm::CheckDigits::M003',
	'miles&more'		=> 'Algorithm::CheckDigits::M003',
	'visa'			=> 'Algorithm::CheckDigits::M003',
	'm004'			=> 'Algorithm::CheckDigits::M004',
	'siren'			=> 'Algorithm::CheckDigits::M004',
	'siret'			=> 'Algorithm::CheckDigits::M004',
	'm005'			=> 'Algorithm::CheckDigits::M005',
	'ups'			=> 'Algorithm::CheckDigits::M005',
	'm006'			=> 'Algorithm::CheckDigits::M006',
	'betriebsnummer'	=> 'Algorithm::CheckDigits::M006',
	'm007'			=> 'Algorithm::CheckDigits::M007',
	'ismn'			=> 'Algorithm::CheckDigits::M007',
	'm008'			=> 'Algorithm::CheckDigits::M008',
	'ean'			=> 'Algorithm::CheckDigits::M008',
	'iln'			=> 'Algorithm::CheckDigits::M008',
	'nve'			=> 'Algorithm::CheckDigits::M008',
	'2aus5'			=> 'Algorithm::CheckDigits::M008',
	'm009'			=> 'Algorithm::CheckDigits::M009',
	'identcode_dp'		=> 'Algorithm::CheckDigits::M009',
	'm010'			=> 'Algorithm::CheckDigits::M010',
	'rentenversicherung'	=> 'Algorithm::CheckDigits::M010',
	'm011'			=> 'Algorithm::CheckDigits::M011',
	'upc'			=> 'Algorithm::CheckDigits::M011',
	'm012'			=> 'Algorithm::CheckDigits::M012',
	'sedol'			=> 'Algorithm::CheckDigits::M012',
	'm013'			=> 'Algorithm::CheckDigits::M013',
	'postcheckkonti'	=> 'Algorithm::CheckDigits::M013',
	'm014'			=> 'Algorithm::CheckDigits::M014',
	'isbn'			=> 'Algorithm::CheckDigits::M014',
	'issn'			=> 'Algorithm::CheckDigits::M014',
	'ustid_pt'		=> 'Algorithm::CheckDigits::M014',
	'hkid'			=> 'Algorithm::CheckDigits::M014',
	'wagonnr_br'		=> 'Algorithm::CheckDigits::M014',
	'nhs_gb'		=> 'Algorithm::CheckDigits::M014',
	'vat_sl'		=> 'Algorithm::CheckDigits::M014',
	'm015'			=> 'Algorithm::CheckDigits::M015',
	'pzn'			=> 'Algorithm::CheckDigits::M015',
	'm016'			=> 'Algorithm::CheckDigits::M016',
	'pkz'			=> 'Algorithm::CheckDigits::M016',
	'm017'			=> 'Algorithm::CheckDigits::M017',
	'cpf'			=> 'Algorithm::CheckDigits::M017',
	'titulo_eleitor'	=> 'Algorithm::CheckDigits::M017',
	'm018'			=> 'Algorithm::CheckDigits::M018',
	'blutbeutel'		=> 'Algorithm::CheckDigits::M018',
	'bzue_de'		=> 'Algorithm::CheckDigits::M018',
	'ustid_de'		=> 'Algorithm::CheckDigits::M018',
	'm019'			=> 'Algorithm::CheckDigits::M019',
	'ccc_es'		=> 'Algorithm::CheckDigits::M019',
	'mbase-003'		=> 'Algorithm::CheckDigits::MBase_003',
	'sici'			=> 'Algorithm::CheckDigits::MBase_003',
	'm11-007'		=> 'Algorithm::CheckDigits::M11_007',
	'ustid_fi'		=> 'Algorithm::CheckDigits::M11_007',
	'm11-008'		=> 'Algorithm::CheckDigits::M11_008',
	'ustid_dk'		=> 'Algorithm::CheckDigits::M11_008',
	'm11-009'		=> 'Algorithm::CheckDigits::M11_009',
	'nric_sg'		=> 'Algorithm::CheckDigits::M11_009',
	'm11-010'		=> 'Algorithm::CheckDigits::M11_010',
	'ahv_ch'		=> 'Algorithm::CheckDigits::M11_010',
	'm11-011'		=> 'Algorithm::CheckDigits::M11_011',
	'ustid_nl'		=> 'Algorithm::CheckDigits::M11_011',
	'm11-012'		=> 'Algorithm::CheckDigits::M11_012',
	'bwpk_de'		=> 'Algorithm::CheckDigits::M11_012',
	'm11-016'		=> 'Algorithm::CheckDigits::M11_016',
	'ustid_pl'		=> 'Algorithm::CheckDigits::M11_016',
);

sub CheckDigits {
	my $method = shift || '';

	if (my $pkg = $methods{lc($method)}) {
		my $file = $pkg;
		$file =~ s{::}{/}g;
		require "$file.pm";
		return new $pkg($method);
	} else {
		return bless {};
	}
} # CheckDigits()

sub method_list {
	my @methods = ();
	foreach my $method (sort keys %methods) {
		push @methods,$method;
	}
	return wantarray ? @methods : \@methods;
} # method_list()

sub print_methods {
	foreach my $method (sort keys %methods) {
		print "$method => $methods{$method}\n";
	}
} # print_methods()

sub AUTOLOAD {
	my $self = shift;
	my $attr = $AUTOLOAD;
	unless ($attr =~ /^Algorithm::CheckDigits::[A-Za-z_0-9]*$/) {
		croak "$attr is not defined";
	}
	return '';
} # AUTOLOAD()

sub DESTROY {
}

# Preloaded methods go here.

1;
__END__

=head1 NAME

CheckDigits - Perl extension to generate and test check digits

=head1 SYNOPSIS

  use Algorithm::CheckDigits;

  $isbn = CheckDigits('ISBN');

  if ($isbn->is_valid('3-930673-48-7')) {
	# do something
  }

  $cn = $isbn->complete('3-930673-48');     # $cn = '3-930673-48-7'

  $cd = $isbn->checkdigit('3-930673-48-7'); # $cd = '7'

  $bn = $isbn->basenumber('3-930673-48-7'); # $bn = '3-930673-48'
  
  Algorithm::CheckDigits->method_list();

=head1 DESCRIPTION

This module provides a number of methods to test and generate check
digits. For more information have a look at the web site
F<www.pruefziffernberechnung.de>.

=head2 CHECK SUM METHODS

Use the following to find out which methods your version of
Algorithm::CheckDigits provides and where to look for further
information.

 perl -MAlgorithm::CheckDigits -e Algorithm::CheckDigits::print_methods

At the moment these methods to compute check digits are provided:

=over 4

=item euronote

See L<Algorithm::CheckDigits::M002>.

=item amex, bahncard, diners, discover, enroute, happydigits, jcb,
      klubkarstadt, mastercard, miles&more, visa

See L<Algorithm::CheckDigits::M003>.

=item siren, siret

See L<Algorithm::CheckDigits::M004>.

=item ups

See L<Algorithm::CheckDigits::M005>.

=item betriebsnummer

See L<Algorithm::CheckDigits::M006>.

=item ismn

See L<Algorithm::CheckDigits::M007>.

=item ean, iln, nve, 2aus5

See L<Algorithm::CheckDigits::M008>.

=item identcode_dp

See L<Algorithm::CheckDigits::M009>.

=item rentenversicherung

See L<Algorithm::CheckDigits::M010>.

=item upc

See L<Algorithm::CheckDigits::M011>.

=item sedol

See L<Algorithm::CheckDigits::M012>.

=item postscheckkonti

See L<Algorithm::CheckDigits::M013>.

=item isbn, issn, ustid_pt, hkid, wagonnr_br, nhs_gb, vat_sl

See L<Algorithm::CheckDigits::M014>.

=item pzn

See L<Algorithm::CheckDigits::M015>.

=item pkz

See L<Algorithm::CheckDigits::M016>.

=item cpf, titulo_eleitor

See L<Algorithm::CheckDigits::M017>.

=item blutbeutel, bzue_de, ustid_de

See L<Algorithm::CheckDigits::M018>.

=item ccc_es

See L<Algorithm::CheckDigits::M019>.

=item sici

See L<Algorithm::CheckDigits::MBase_003>.

=item ustid_fi

See L<Algorithm::CheckDigits::M11_007>.

=item ustid_dk

See L<Algorithm::CheckDigits::M11_008>.

=item nric_sg

See L<Algorithm::CheckDigits::M11_009>.

=item ahv_ch

See L<Algorithm::CheckDigits::M11_010>.

=item ustid_nl

See L<Algorithm::CheckDigits::M11_011>.

=item bwpk_de

See L<Algorithm::CheckDigits::M11_012>.

=item ustid_pl

See L<Algorithm::CheckDigits::M11_016>.

=back

=head2 EXPORT

None by default.

=head1 AUTHOR

Mathias Weidner, E<lt>mathias@weidner.in-bad-schmiedeberg.deE<gt>

=head1 SEE ALSO

L<perl>,
F<www.pruefziffernberechnung.de>.

=cut
