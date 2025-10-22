{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.url = "github:nix-systems/default-linux";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    {
      overlays.default = _: pkgs: {
        unisearch = pkgs.python3Packages.callPackage ./unisearch.nix { };
        unisearchFull = pkgs.python3Packages.callPackage ./unisearch.nix { withUnihan = true; };
      };
    }
    // (flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
          config.checkMeta = true;
        };
      in
      {
        packages = rec {
          default = unisearch;
          inherit (pkgs) unisearch unisearchFull;
        };
        devShells = {
          # TODO
        };

        formatter = pkgs.nixfmt-tree; # TODO: format python files
      }
    ));
}
