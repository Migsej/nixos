{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "ns";
  src = ./.;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/ns.sh $out/bin
  '';
}
