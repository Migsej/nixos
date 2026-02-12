{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "xiki";

  src = pkgs.fetchFromGitHub {
      owner = "cadrgtsecond";
      repo = "xiki.kak";
      rev = "76176bb2a637a815751e6010757b7da9bfa81e86";
      sha256 = "sha256-Yw03XqTnagymXGQKmbM06mKL59VVsKkGP924M1xbGsY=";
  };

  nativeBuildInputs = [
  ];

  installPhase = ''
    sed -i 's/\/bin\/execlineb/\/usr\/bin\/env execlineb/g' xiki

    mkdir -p $out/bin/
    mkdir -p $out/share/kak/autoload/
    mkdir -p $out/.config/
    cp rc/xiki.kak $out/share/kak/autoload/
    cp doc/xiki.asciidoc $out/share/kak/autoload/

    cp xiki $out/bin
    cp default $out/.config/
    cp -r scripts $out/.config/

  '';
}

