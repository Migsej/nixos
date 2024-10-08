{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "ns";
  src = ./ns.sh;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin
  '';
}
