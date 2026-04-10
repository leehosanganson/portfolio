{
  description = "dev";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # js
            nodejs_22
            corepack

            # dev tool
            git
            act
            docker-compose
            pre-commit
            gopls
            golangci-lint
            vtsls
            eslint_d
          ];
          shellHook = ''
            echo "Project env loaded on ${system}"
            echo "Run 'npm install' to install Astro dependencies"
          '';
        };
      }
    );
}
