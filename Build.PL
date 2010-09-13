# vim: set ts=4 sw=4 tw=78 et si:
use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    add_to_cleanup      => [ 'Algorithm-CheckDigits-*' ],
    build_requires      => {
        'Probe::Perl'   => 0,
    },
    create_makefile_pl  => 'passthrough',
    dist_author         => 'Mathias Weidner <mamawe@cpan.org>',
    dist_version_from   => 'lib/Algorithm/CheckDigits.pm',
    license             => 'perl',
    module_name         => 'Algorithm::CheckDigits',
    requires            => { 
        'Test::More'    => 0,
    	'version'       => 0,
    },
);

$builder->create_build_script();
