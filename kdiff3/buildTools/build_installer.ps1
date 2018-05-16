$srcroot = $(git rev-parse --show-toplevel)
$release_dir = "${srcroot}/kdiff3/Release"
$tools_dir = "${srcroot}/kdiff3/buildTools"
$wix_bin = "C:/Program Files (x86)/WiX Toolset v3.11/bin"

$version = $(git describe --tags --abbrev=0)
pushd "${release_dir}"
cp "${tools_dir}\kdiff3.wxs" "${release_dir}"

try
{
    & "${wix_bin}\candle.exe" .\kdiff3.wxs -dVersion="${version}"
    & "${wix_bin}\light.exe" .\kdiff3.wixobj
}
finally
{
    popd
}
