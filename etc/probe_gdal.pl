use 5.036;
use warnings;

use Alien::gdal;

eval 'use Geo::GDAL::FFI';
if (my $e = $@) {
    warn "Error encountered when loading Geo::GDAL::FFI\n$e";
}
else {
    say "No error when loading Geo::GDAL::FFI";
}


my @libs = grep {/libgdal.+.dylib$/} Alien::gdal->dynamic_libs;
my $libgdal = shift @libs;

my @res = `otool -L $libgdal`;
say "otool -L $libgdal";
say join "\n", @res;
