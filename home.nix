{ pkgs, ... }:


let school = with pkgs; [
    kicad
    obsidian
    libreoffice
  ];
in
{
  home-manager.users.migsej = {pkgs, ... }: {
    imports = [ ./kakoune.nix ];
    nixpkgs.config.allowUnfree = true;
    home.packages = let
    	pythonEnv = pkgs.python312.withPackages (p: with p; [
      	pycryptodome
      	ipython
    	]);
    	in with pkgs; [
        discord
        exiftool
        bintools
        exiftool
        p7zip
        file
        unzip
        pythonEnv
        feh
        ghidra
        binwalk
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

