{
  pkgs,
  ...
}:

let
  inner = pkgs.writeScript "ctf-env-inner" ''
    #!${pkgs.bash}/bin/bash

    export NIX_SHELL_DESCRIPTIONS="$NIX_SHELL_DESCRIPTIONS ctf-env"
    set -eu -o pipefail

    if [ $# -ne 0 ]; then
      exec "$@"
    else
      exec "$SHELL"
    fi
  '';
in

pkgs.buildFHSEnv {
  name = "ctf-env";
  runScript = inner;
  targetPkgs =
    pkgs: with pkgs; [
      bvi
      gdb
      ltrace
      nasm
      one_gadget
      pwninit
      ropgadget
      socat
      strace
      tmux
    ];
  multiPkgs =
    pkgs:
    (with pkgs; [
      libseccomp
      curl
      openssl
      fontconfig
      freetype
      glib
      xorg.libICE
      xorg.libSM
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
      xorg.libXext
      xorg.libXrender
      xorg.libXft
      openal
      fuse3
      vulkan-headers
      vulkan-loader
      vulkan-validation-layers
      SDL
      gtk3
      gtk3-x11
      libGL
      zlib
      zlib-ng
      dotnet-runtime
      libpng12
      SDL2
      geos
      fuse
    ]);
}
