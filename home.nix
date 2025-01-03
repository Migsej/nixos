{ pkgs, ... }:


{
  home-manager.extraSpecialArgs = { inherit pkgs;};
  home-manager.users.migsej = {pkgs, ... }: {
  home.pointerCursor = {
        package = pkgs.gnome.adwaita-icon-theme;
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
    	pythonEnv = pkgs.python3.withPackages (p: with p; [
      	pycryptodome
      	pwntools
      	ipython
      	tqdm
      	angr
      	matplotlib
      	pgpy
    	]);
    	school = with pkgs; [
        kicad
        obsidian
        libreoffice
        zathura
        tetex
      ];
      unstable = import <nixos-unstable-small> { config = { allowUnfree = true; }; };
    	in with pkgs; [
        (callPackage ./ctf-env.nix {})
        (callPackage ./ns/ns.nix {})
        (callPackage ./st/st.nix {})
        (callPackage ./init/init.nix {})
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
        unstable.ghidra
        binwalk
        gcc
        wordlists
        prismlauncher
        pwndbg
        bc
        odin
        xorg.xbacklight
      ] ++ school;
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        export PS1="\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w$NIX_SHELL_DESCRIPTIONS]\$\[\033[0m\] "
      '';
    };
    programs.home-manager.enable = true;

    programs.git = {
      enable = true;
      userName = "migsej";
      userEmail = "vincentkbonne@gmail.com";
    };
    home.stateVersion = "24.05";
  };
}

