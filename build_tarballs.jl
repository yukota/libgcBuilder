# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "libgc"
version = v"8.0.2"

# Collection of sources required to build libgc
sources = [
    "http://www.hboehm.info/gc/gc_source/gc-8.0.2.tar.gz" =>
    "4e8ca4b5b72a3a27971daefaa9b621f0a716695b23baa40b7eac78de2eeb51cb",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd gc-8.0.2/
./configure --prefix=$prefix --host=$target
make
make install
exit

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libgc", :libgc),
    LibraryProduct(prefix, "libcord", :libcord)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

