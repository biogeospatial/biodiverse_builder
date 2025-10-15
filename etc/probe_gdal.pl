use 5.036;
use warnings;

use Alien::gdal;

eval 'use Geo::GDAL::FFI';
warn $@ if $@;


my @libs = grep {/libgdal.+.dylib$/} Alien::gdal->dynamic_libs;
my $libgdal = shift @libs;

my @res = `otool -L $libgdal`
say "otool -L $libgdal";
say join "\n", @res;
