{
  description = "Nixos Flake Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      url = "github:Meow-2/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations."HpZBook" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({
          nixpkgs.overlays = [
            (final: prev: {
              myNUR = inputs.myNUR.packages."${prev.system}";
            })
          ];
        })
        ./configuration.nix
      ];
    };
  };
}
