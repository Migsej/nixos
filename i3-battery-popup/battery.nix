{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "i3-battery-popup";
  src = ./.;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/i3-battery-popup $out/bin/
    cp $src/i3-battery-popup.wav $out/bin/
  '';
}
