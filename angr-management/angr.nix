{pkgs}:
let
  rpath = pkgs.lib.makeLibraryPath( with pkgs; [
    libGL
    libz
    libxcb
  ]);
in
pkgs.stdenv.mkDerivation {
  name = "angr-management";
  src = (fetchTarball  {
    url = "https://github.com/angr/angr-management/releases/download/v9.2.185/angr-management-v9.2.185-ubuntu-24.04-x86_64.tar.gz";
    sha256 = "sha256:00x2d7bazilpq4mghci1s51ihlr7ljqdgw3khpinz6vbfaq6hqzz";
  });

  buildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out
    mkdir -p $out/bin
    mv angr-management $out/bin
    mv _internal/ $out/bin
    wrapProgram $out/bin/angr-management --prefix LD_LIBRARY_PATH : ${rpath}
  '';
}
