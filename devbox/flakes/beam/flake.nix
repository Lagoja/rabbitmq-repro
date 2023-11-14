{
  inputs = {
    nixpkgs.url = "nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlay = (final: prev: {
          elixir = prev.beam.packages.erlangR26.elixir_1_15;
          rabbitmq = prev.rabbitmq-server.override {
            erlang = prev.beam.packages.erlangR26.erlang;
            elixir = prev.beam.packages.erlangR26.elixir_1_15;
          };
        });

        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        packages = {
          elixir = pkgs.elixir;
          rabbitmq = pkgs.rabbitmq;
        };
      }
    );
}