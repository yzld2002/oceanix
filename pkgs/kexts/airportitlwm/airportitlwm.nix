{ lib, stdenv, fetchzip, ver ? "latest", osVer }:
let versionList = (import ./version.nix { inherit lib; });
in stdenv.mkDerivation rec {
  pname = "intel-bluetooth-firmware";
  version = versionList."${ver}".canonicalVersion;

  src = fetchzip {
    url =
      "https://github.com/OpenIntelWireless/itlwm/releases/download/${version}/AirportItlwm_${version}_stable_${osVer}.kext.zip";
    sha256 = versionList."${ver}"."${osVer}";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/Kexts
    cp -r . $out/Kexts
  '';
}
