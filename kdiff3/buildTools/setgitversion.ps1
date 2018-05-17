if ((gcm git) 2> $nul) {
    $srcroot = $(git rev-parse --show-toplevel)
    $versionfile = "${srcroot}\kdiff3\src-QT4\version.h"
    $gitversion = '#define VERSION "{0}"' -f (git describe --tags)

    (gc $versionfile) -replace "#define VERSION .*", $gitversion | out-file -Encoding ascii $versionfile
}