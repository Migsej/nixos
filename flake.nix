{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    unstable.url = "nixpkgs/nixpkgs-unstable";

    pwndbg.url = "github:pwndbg/pwndbg";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, unstable, pwndbg }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          (final: prev: {
            pwndbg = pwndbg.packages.${system}.pwndbg;
          })
        ];
      };
      system = "x86_64-linux";
      specialArgs = attrs // { inherit unstable pwndbg; } ;
      modules = [ ./configuration.nix
                  home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit unstable; };
                    home-manager.users.migsej = import ./home.nix;
                  }
                  # This fixes nixpkgs (for e.g. "nix shell") to match the system nixpkgs
                  ({ config, pkgs, options, ... }: { nix.registry.nixpkgs.flake = nixpkgs; })
                ];
    };
  };
}
    
