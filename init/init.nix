{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "init";
  src = ./.;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/init.sh $out/bin/
  '';
}
