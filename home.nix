{ pkgs, ... }:

{
  home-manager.users.migsej = {pkgs, ... }: {
    imports = [ ./kakoune.nix ];
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      discord
      obsidian
      libreoffice
    ];
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

