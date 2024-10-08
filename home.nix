{ pkgs, ... }:


{
  home-manager.users.migsej = {pkgs, ... }: {
    imports = [ ./kakoune.nix ];
    nixpkgs.config.allowUnfree = true;
    home.sessionVariables = {
      NIX_SHELL_PRESERVE_PROMPT=1;
    };
    home.packages = let
    	pythonEnv = pkgs.python312.withPackages (p: with p; [
      	pycryptodome
      	ipython
    	]);
    	school = with pkgs; [
        kicad
        obsidian
        libreoffice
        zathura
        tetex
      ];
    	in with pkgs; [
        #callPackage ./ctf-env.nix {}
        (import ./ctf-env.nix { inherit pkgs; })
        (import ./ns.nix { inherit pkgs; })
        discord
        exiftool
        bintools
        exiftool
        p7zip
        file
        wget
        unzip
        pythonEnv
        feh
        ghidra
        binwalk
        clang
      ] ++ school;
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        export PS1="\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w $NIX_SHELL_DESCRIPTIONS]\$\[\033[0m\] "
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

