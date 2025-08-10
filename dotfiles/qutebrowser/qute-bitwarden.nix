{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "qute-bitwarden";
  propagatedBuildInputs = [
    (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
      tldextract
      pyperclip
    ]))
  ];
  dontUnpack = true;
  installPhase = "install -Dm755 ${./qute-bitwarden.py} $out/bin/myscript";
}
