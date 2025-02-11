{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      # pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; };};
      system = "x86_64-linux";
      modules = [ ./configuration.nix
                  home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.migsej = import ./home.nix;
                  }

                  # This fixes nixpkgs (for e.g. "nix shell") to match the system nixpkgs
                  ({ config, pkgs, options, ... }: { nix.registry.nixpkgs.flake = nixpkgs; })
                ];
    };
  };
}
