{
  description = "System config";

  inputs = {
    # package repos
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # system management
    darwin = {
      url = "github:kclejeune/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # shell stuff
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , darwin
    , home-manager
    , flake-utils
    , ...
    } @ inputs:
    let
      inherit (flake-utils.lib) eachSystemMap;

      isDarwin = system: (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);

      homePrefix = system:
        if isDarwin system
        then "/Users"
        else "/home";

      defaultSystems = [
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      # generate a base darwin configuration with the
      # specified hostname, overlays, and any extraModules applied
      mkDarwinConfig =
        { system ? "aarch64-darwin"
        , nixpkgs ? inputs.nixpkgs
        , baseModules ? [
            home-manager.darwinModules.home-manager
            ./modules/darwin
          ]
        , extraModules ? [ ]
        ,
        }:
        inputs.darwin.lib.darwinSystem {
          inherit system;
          modules = baseModules ++ extraModules;
          specialArgs = { inherit self inputs nixpkgs; };
        };

    in
    {
      darwinConfigurations = {
        "luke@aarch64-darwin" = mkDarwinConfig {
          system = "aarch64-darwin";
          extraModules = [ ./profiles/personal.nix ];
        };
      };

      packages = eachSystemMap defaultSystems (system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = builtins.attrValues self.overlays;
          };
        in
        rec {
          pyEnv =
            pkgs.python3.withPackages
              (ps: with ps; [ black typer colorama shellingham ]);
          sysdo = pkgs.writeScriptBin "sysdo" ''
            #! ${pyEnv}/bin/python3
            ${builtins.readFile ./bin/sysdo.py}
          '';
        });

      apps = eachSystemMap defaultSystems (system: rec {
        sysdo = {
          type = "app";
          program = "${self.packages.${system}.sysdo}/bin/sysdo";
        };
        default = sysdo;
      });

      overlays = {
        channels = final: prev: {
          # expose other channels via overlays
          unstable = import inputs.unstable {system = prev.system;};
        };
        extraPackages = final: prev: {
          sysdo = self.packages.${prev.system}.sysdo;
        };
      };
    };
}
