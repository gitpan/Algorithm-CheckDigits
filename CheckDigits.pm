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

our $VERSION = '0.31';

my %methods = (
	'mbase-001'		=> 'Algorithm::CheckDigits::MBase_001',
	'upc'			=> 'Algorithm::CheckDigits::MBase_001',
	'mbase-002'		=> 'Algorithm::CheckDigits::MBase_002',
	'blutbeutel'		=> 'Algorithm::CheckDigits::MBase_002',
	'bzue_de'		=> 'Algorithm::CheckDigits::MBase_002',
	'ustid_de'		=> 'Algorithm::CheckDigits::MBase_002',
	'vatrn_de'		=> 'Algorithm::CheckDigits::MBase_002',
	'mbase-003'		=> 'Algorithm::CheckDigits::MBase_003',
	'sici'			=> 'Algorithm::CheckDigits::MBase_003',
	'm07-001'		=> 'Algorithm::CheckDigits::M07_001',
	'm09-001'		=> 'Algorithm::CheckDigits::M09_001',
	'euronote'		=> 'Algorithm::CheckDigits::M09_001',
	'm10-001'		=> 'Algorithm::CheckDigits::M10_001',
	'amex'			=> 'Algorithm::CheckDigits::M10_001',
	'bahncard'		=> 'Algorithm::CheckDigits::M10_001',
	'diners'		=> 'Algorithm::CheckDigits::M10_001',
	'discover'		=> 'Algorithm::CheckDigits::M10_001',
	'enroute'		=> 'Algorithm::CheckDigits::M10_001',
	'eurocard'		=> 'Algorithm::CheckDigits::M10_001',
	'happydigits'		=> 'Algorithm::CheckDigits::M10_001',
	'jcb'			=> 'Algorithm::CheckDigits::M10_001',
	'klubkarstadt'		=> 'Algorithm::CheckDigits::M10_001',
	'mastercard'		=> 'Algorithm::CheckDigits::M10_001',
	'miles&more'		=> 'Algorithm::CheckDigits::M10_001',
	'visa'			=> 'Algorithm::CheckDigits::M10_001',
	'm10-002'		=> 'Algorithm::CheckDigits::M10_002',
	'siren'			=> 'Algorithm::CheckDigits::M10_002',
	'siret'			=> 'Algorithm::CheckDigits::M10_002',
	'm10-003'		=> 'Algorithm::CheckDigits::M10_003',
	'ismn'			=> 'Algorithm::CheckDigits::M10_003',
	'm10-004'		=> 'Algorithm::CheckDigits::M10_004',
	'ean'			=> 'Algorithm::CheckDigits::M10_004',
	'iln'			=> 'Algorithm::CheckDigits::M10_004',
	'nve'			=> 'Algorithm::CheckDigits::M10_004',
	'2aus5'			=> 'Algorithm::CheckDigits::M10_004',
	'm10-005'		=> 'Algorithm::CheckDigits::M10_005',
	'identcode_dp'		=> 'Algorithm::CheckDigits::M10_005',
	'leitcode_dp'		=> 'Algorithm::CheckDigits::M10_005',
	'm10-006'		=> 'Algorithm::CheckDigits::M10_006',
	'rentenversicherung'	=> 'Algorithm::CheckDigits::M10_006',
	'm10-008'		=> 'Algorithm::CheckDigits::M10_008',
	'sedol'			=> 'Algorithm::CheckDigits::M10_008',
	'm10-009'		=> 'Algorithm::CheckDigits::M10_009',
	'betriebsnummer'	=> 'Algorithm::CheckDigits::M10_009',
	'm10-010'		=> 'Algorithm::CheckDigits::M10_010',
	'postcheckkonti'	=> 'Algorithm::CheckDigits::M10_010',
	'm10-011'		=> 'Algorithm::CheckDigits::M10_011',
	'ups'			=> 'Algorithm::CheckDigits::M10_011',
	'm11-001'		=> 'Algorithm::CheckDigits::M11_001',
	'isbn'			=> 'Algorithm::CheckDigits::M11_001',
	'issn'			=> 'Algorithm::CheckDigits::M11_001',
	'ustid_pt'		=> 'Algorithm::CheckDigits::M11_001',
	'hkid'			=> 'Algorithm::CheckDigits::M11_001',
	'wagonnr_br'		=> 'Algorithm::CheckDigits::M11_001',
	'nhs_gb'		=> 'Algorithm::CheckDigits::M11_001',
	'vat_sl'		=> 'Algorithm::CheckDigits::M11_001',
	'm11-002'		=> 'Algorithm::CheckDigits::M11_002',
	'pzn'			=> 'Algorithm::CheckDigits::M11_002',
	'm11-003'		=> 'Algorithm::CheckDigits::M11_003',
	'pkz'			=> 'Algorithm::CheckDigits::M11_003',
	'm11-004'		=> 'Algorithm::CheckDigits::M11_004',
	'cpf'			=> 'Algorithm::CheckDigits::M11_004',
	'titulo_eleitor'	=> 'Algorithm::CheckDigits::M11_004',
	'm11-006'		=> 'Algorithm::CheckDigits::M11_006',
	'ccc_es'		=> 'Algorithm::CheckDigits::M11_006',
	'm11-007'		=> 'Algorithm::CheckDigits::M11_007',
	'ustid_fi'		=> 'Algorithm::CheckDigits::M11_007',
	'vatrn_fi'		=> 'Algorithm::CheckDigits::M11_007',
	'm11-008'		=> 'Algorithm::CheckDigits::M11_008',
	'ustid_dk'		=> 'Algorithm::CheckDigits::M11_008',
	'vatrn_dk'		=> 'Algorithm::CheckDigits::M11_008',
	'm11-009'		=> 'Algorithm::CheckDigits::M11_009',
	'nric_sg'		=> 'Algorithm::CheckDigits::M11_009',
	'm11-010'		=> 'Algorithm::CheckDigits::M11_010',
	'ahv_ch'		=> 'Algorithm::CheckDigits::M11_010',
	'm11-011'		=> 'Algorithm::CheckDigits::M11_011',
	'ustid_nl'		=> 'Algorithm::CheckDigits::M11_011',
	'vatrn_nl'		=> 'Algorithm::CheckDigits::M11_011',
	'm11-012'		=> 'Algorithm::CheckDigits::M11_012',
	'bwpk_de'		=> 'Algorithm::CheckDigits::M11_012',
	'm11-013'		=> 'Algorithm::CheckDigits::M11_013',
	'ustid_gr'		=> 'Algorithm::CheckDigits::M11_013',
	'vatrn_gr'		=> 'Algorithm::CheckDigits::M11_013',
	'm11-015'		=> 'Algorithm::CheckDigits::M11_015',
	'esr5_ch'		=> 'Algorithm::CheckDigits::M11_015',
	'm11-016'		=> 'Algorithm::CheckDigits::M11_016',
	'ustid_pl'		=> 'Algorithm::CheckDigits::M11_016',
	'vatrn_pl'		=> 'Algorithm::CheckDigits::M11_016',
	'm16-001'		=> 'Algorithm::CheckDigits::M16_001',
	'isan'			=> 'Algorithm::CheckDigits::M16_001',
	'm23-001'		=> 'Algorithm::CheckDigits::M23_001',
	'dni_es'		=> 'Algorithm::CheckDigits::M23_001',
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

=head1 ABSTRACT

This module provides a number of methods to test and generate check
digits. For more information have a look at the web site
F<www.pruefziffernberechnung.de> (german).

=head2 CHECK SUM METHODS

Use the following to find out which methods your version of
Algorithm::CheckDigits provides and where to look for further
information.

 perl -MAlgorithm::CheckDigits -e Algorithm::CheckDigits::print_methods

At the moment these methods to compute check digits are provided:

=over 4

=item euronote

See L<Algorithm::CheckDigits::M09_001>.

=item amex, bahncard, diners, discover, enroute, happydigits, jcb,
      klubkarstadt, mastercard, miles&more, visa

See L<Algorithm::CheckDigits::M10_001>.

=item siren, siret

See L<Algorithm::CheckDigits::M10_002>.

=item ups

See L<Algorithm::CheckDigits::M10_011>.

=item betriebsnummer

See L<Algorithm::CheckDigits::M10_009>.

=item ismn

See L<Algorithm::CheckDigits::M10_003>.

=item ean, iln, nve, 2aus5

See L<Algorithm::CheckDigits::M10_004>.

=item identcode_dp

See L<Algorithm::CheckDigits::M10_005>.

=item rentenversicherung

See L<Algorithm::CheckDigits::M10_006>.

=item upc

See L<Algorithm::CheckDigits::MBase_001>.

=item sedol

See L<Algorithm::CheckDigits::M10_008>.

=item postscheckkonti

See L<Algorithm::CheckDigits::M10_010>.

=item isbn, issn, ustid_pt, hkid, wagonnr_br, nhs_gb, vat_sl

See L<Algorithm::CheckDigits::M11_001>.

=item pzn

See L<Algorithm::CheckDigits::M11_002>.

=item pkz

See L<Algorithm::CheckDigits::M11_003>.

=item cpf, titulo_eleitor

See L<Algorithm::CheckDigits::M11_004>.

=item blutbeutel, bzue_de, ustid_de

See L<Algorithm::CheckDigits::MBase_002>.

=item ccc_es

See L<Algorithm::CheckDigits::M11_006>.

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

=head1 SEE ALSO

L<perl>,
F<www.pruefziffernberechnung.de>.

=head1 AUTHOR

Mathias Weidner, E<lt>mathias@weidner.in-bad-schmiedeberg.deE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Mathias Weidner

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
