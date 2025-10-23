use 5.036;
use warnings;

use Alien::gdal;
use Alien::proj;
use Alien::geos::af;

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
say @res;

my @proj_libs = grep {/libproj.+.dylib$/} Alien::proj->dynamic_libs;
my $libproj = shift @proj_libs;
say "otool -L $libproj";
say `otool -L $libproj`;

my @geos_libs = grep {/libgeos_c.+.dylib$/} Alien::geos::af->dynamic_libs;
my $libgeos = shift @geos_libs;
say "otool -L $libgeos";
say `otool -L $libgeos`;



say 'rpath vals:';

say '++gdal';
dump_rpath($libgdal);
say '++proj';
dump_rpath($libproj);
say '++geos';
dump_rpath($libgeos);


sub dump_rpath{
    my ($source) = @_;

    my @results = qx /otool -l $source/;
    while (my $line = shift @results) {
        last if $line =~ /LC_RPATH/;
    }
    my @lc_rpath_chunk;
    while (my $line = shift @results) {
        last if $line =~ /LC_/;  #  any other command
        push @lc_rpath_chunk, $line;
    }
    print @lc_rpath_chunk;
}