{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "st";
  src = ./.;
  outputs = [ "out" "terminfo" ];
  preInstall = ''
    export TERMINFO=$terminfo/share/terminfo
    mkdir -p $TERMINFO $out/nix-support
    echo "$terminfo" >> $out/nix-support/propagated-user-env-packages
  '';
  nativeBuildInputs = [
    pkgs.pkg-config
    pkgs.ncurses
  ];
  buildInputs = [
    pkgs.xorg.libX11
    pkgs.xorg.libXft
  ];
  installFlags = [ "PREFIX=$(out)" ];
}
