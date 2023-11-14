{
  inputs = {
    # Revision with Node.js 20.4.0
    nixpkgs.url = "nixpkgs/fc4810bfca66fc4f3a8f5d4cceb1621e79bc91bb";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlay = (final: prev: {
          yarn = prev.yarn.override { nodejs = final.pkgs.nodejs_20; };
        });

        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        packages = {
          yarn = pkgs.yarn;
          node = pkgs.nodejs_20;
          node-gyp = pkgs.nodePackages.node-gyp;
        };
      }
    );
}