{pkgs, ... }: {
  home.pointerCursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
      x11.enable = true;
  };
  imports = [ ./kakoune.nix ];
  nixpkgs.config.allowUnfree = true;
  home.sessionVariables = {
    NIX_SHELL_PRESERVE_PROMPT=1;
  };
  home.packages = let
    mydebugger = pkgs.pwndbg;
  	pythonEnv = pkgs.python3.withPackages (p: with p; [
    	pycryptodome
    	(pwntools.override { debugger = mydebugger; })
    	ipython
    	tqdm
    	# angr
    	matplotlib
    	pgpy
    	gmpy2
  	]);
  	school = with pkgs; [
      kicad
      obsidian
      libreoffice
      zathura
      texliveFull

    ];
  	in with pkgs; [
      (callPackage ./ctf-env.nix {})
      (callPackage ./ns/ns.nix {})
      (callPackage ./st/st.nix {})
      (callPackage ./init/init.nix {})
      (callPackage ./binja.nix {})

      # (builtins.getFlake "github:uiua-lang/uiua/73bfe4e1e25e7eb344333cd8846c09c87b8bfa3a").packages.x86_64-linux.default
      discord
      openvpn
      exiftool
      p7zip
      file
      nmap
      unixtools.xxd
      wget
      gimp
      netcat-gnu
      gnumake
      unzip
      pythonEnv
      sxiv
      ghidra # NOTE unstable maybe
      binwalk
      gcc
      wordlists
      prismlauncher
      mydebugger
      bc
      odin
      xorg.xbacklight
    ] ++ school;
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PS1="\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w$NIX_SHELL_DESCRIPTIONS]\$\[\033[0m\] "
      TERM_PROGRAM="st";
    '';
  };
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "migsej";
    userEmail = "vincentkbonne@gmail.com";
  };
  home.stateVersion = "24.11";
}

