{ lib, stdenv, fetchzip, release ? true, ver ? "latest" }:
let versionList = (import ./version.nix { inherit lib; });
in stdenv.mkDerivation rec {
  pname = "virtualsmc-${if release then "release" else "debug"}";
  version = versionList."${ver}".canonicalVersion;

  src = fetchzip {
    url =
      "https://github.com/acidanthera/VirtualSMC/releases/download/${version}/VirtualSMC-${version}-${
        if release then "RELEASE" else "DEBUG"
      }.zip";
    sha256 = versionList."${ver}"."${if release then "release" else "debug"}";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/Kexts
    cp -r ./Kexts $out
  '';
}
