{
  inputs = {
    nixpkgs.url = "nixpkgs/b4cc9cd38f05f1a764e21bfb1b14e89be76068b0";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        packages = {
          libclang-lib = pkgs.libclang.lib;
          icu = pkgs.icu;
        };
      }
    );
}