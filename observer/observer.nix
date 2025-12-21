{pkgs} :
let
  rpath = pkgs.lib.makeLibraryPath( with pkgs; [
              zlib
              zstd
              stdenv.cc.cc
              curl
              openssl
              attr
              libssh
              bzip2
              libxml2
              acl
              libsodium
              util-linux
              xz
              systemd
              libGL
              glibc
              glib

              # Verified to be needed
              nss
              nspr
              dbus
              at-spi2-atk
              cups
              libdrm
              gdk-pixbuf
              gtk3
              pango
              cairo
              xorg.libX11
              xorg.libXcomposite
              xorg.libXdamage
              xorg.libXext
              xorg.libXfixes
              xorg.libXrandr
              libgbm
              expat
              xorg.libxcb
              libxkbcommon
              alsa-lib


  ]);
in
pkgs.stdenv.mkDerivation {
  pname = "observer";
  version = "1.0.0";

  nativeBuildInputs = [
    pkgs.glib
    pkgs.libGL
  ];

  buildInputs = [ pkgs.dpkg pkgs.makeWrapper ];
  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out
    dpkg -x $src/Observer-1.0.220.deb $out
    cp -av $out/usr/* $out
    cp -av $out/opt/Observer $out/bin
    rm -rf $out/usr $out/opt


    for file in $(find $out -type f \( -perm /0111 -o -name \*.so\* -or -name \*.node\* \) ); do
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$file" || true
      patchelf --set-rpath ${rpath}:$out/bin/ $file || true
    done

  '';
  postFixup = ''
    wrapProgram $out/bin/observer \
      --prefix LD_LIBRARY_PATH : ${rpath}

    substituteInPlace $out/share/applications/observer.desktop \
      --replace-fail /opt/Observer/ $out/bin/
  '';

  src = ./.;
}
