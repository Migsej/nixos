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
      tex = (pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-basic
        #dvisvgm dvipng # for preview and export as html
        wrapfig amsmath ulem hyperref capt-of;
        #(setq org-latex-compiler "lualatex")
        #(setq org-preview-latex-default-process 'dvisvgm)
      });
    	school = with pkgs; [
        kicad
        obsidian
        libreoffice
        zathura
        tex
      ];
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

