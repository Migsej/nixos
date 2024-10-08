{ pkgs, ... }:


{
  home-manager.users.migsej = {pkgs, ... }: {
    imports = [ ./kakoune.nix ];
    nixpkgs.config.allowUnfree = true;
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
    programs.bash.enable = true;
    programs.home-manager.enable = true;

    programs.git = {
      enable = true;
      userName = "migsej";
      userEmail = "vincentkbonne@gmail.com";
    };
    home.stateVersion = "24.05";
  };
}

