{pkgs, unstable, ... }: {
  home.pointerCursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
      x11.enable = true;
  };
  imports = [ ./kakoune.nix ];
  # nixpkgs.config.allowUnfree = true;
  home.sessionVariables = {
    GROFF_NO_SGR=1;
    NIX_SHELL_PRESERVE_PROMPT=1;
  };

  home.packages = let
    mydebugger = pkgs.pwndbg;
  	pythonEnv = pkgs.python3.withPackages (p: with p; [
    	pycryptodome
    	(pwntools.override { debugger = mydebugger; })
    	ipython
    	tqdm
    	angr
    	matplotlib
    	pgpy
    	gmpy2
  	]);
  	school = with pkgs; [
      obsidian
      libreoffice
      zathura
      inkscape
      texliveFull

    ];
  	in with pkgs; [
      (callPackage ./ctf-env.nix {})
      (callPackage ./ns/ns.nix {})
      (callPackage ./st/st.nix {})
      (callPackage ./init/init.nix {})
      (callPackage ./binja.nix {})
      (callPackage ./i3-battery-popup/battery.nix {})
      (callPackage ./observer/observer.nix {})
      (callPackage ./angr-management/angr.nix {})

      (builtins.getFlake "github:uiua-lang/uiua/5c4e9f051469d7707816871c342890459c70467d").packages.x86_64-linux.default
      openvpn
      exiftool
      p7zip
      file
      debootstrap
      nmap
      wireshark
      btop
      burpsuite
      wineWowPackages.stable
      winetricks
      unixtools.xxd
      zenity
      wget
      gimp
      netcat-gnu
      gnumake
      unzip
      pythonEnv
      mpv
      sxiv
#       (ghidra.withExtensions (p: with p; [
#         wasm
#       ]))
      binwalk
    	(sage.override {
      	extraPythonPackages = (ps: [ps.pycryptodome ps.tqdm ps.pwntools ] );
      	requireSageTests = false;
    	})
      # (sage.withPackages (p: [p.pycryptodome ]))
      gcc
      jadx
      qbittorrent
      wordlists
      qemu
      semgrep
      openjdk
      mydebugger
      bc
      odin
      zip
      xorg.xbacklight
      typst
      qutebrowser
      socat
      firefox
      jq
      prismlauncher
      (pkgs.writeShellScriptBin "nbc" ''sed -e '$a\' | bc '')
    ] ++ school;
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PS1="\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w$NIX_SHELL_DESCRIPTIONS]\$\[\033[0m\] "
      TERM_PROGRAM="st";
      alias printletterfreq='echo _eE3aA4rRiI1oO0tT7nNsS25lLcCuUdDpPmMhHgG6bBfFyYwWkKvVxXzZjJqQ89 && echo _e3a4ri1o0t7ns25lcudpmhg6bfywkvxzjq89 && echo _E3A4RI1O0T7NS25LCUDPMHG6BFYWKVXZJQ89 && echo etaoinshrdlcumwfgypbvkjxqz && echo ETAOINSHRDLCUMWFGYPBVKJXQZ'
    '';
  };
  programs.home-manager.enable = true;
  manual.manpages.enable = true;

  xdg.configFile."qutebrowser/config.py".source = ./dotfiles/qutebrowser/config.py;

  programs.git = {
    enable = true;
    settings.user = {
      name = "Vincent";
      email = "vincent.kb@pm.me";
    };
  };

  home.stateVersion = "24.11";
}

