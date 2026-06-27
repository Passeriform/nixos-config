{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-where-is-my-sddm-theme = {
      url = "github:catppuccin/where-is-my-sddm-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ambxst = {
      url = "github:Axenide/Ambxst";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ambxst-hm = {
      url = "github:Passeriform/Ambxst-hm-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.ambxst.follows = "ambxst";
    };

    axosc = {
      url = "github:Passeriform/axosc";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    zen-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixos-hardware,
    home-manager,
    ambxst,
    axosc,
    yazi-plugins,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        username = "utkarsh";
      };
      modules = [
        nixos-hardware.nixosModules.asus-rog-strix-g713ie
        ./configuration
        ambxst.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays =
            [
              axosc.overlays.default
              yazi-plugins.overlays.default
            ]
            ++ (import ./overlays);

          home-manager = {
            useGlobalPkgs = true;
            extraSpecialArgs = {
              inherit inputs;
              username = "utkarsh";
            };
            users.utkarsh = import ./home-manager;
          };
        }
      ];
    };

    devShells.${system}.default = let
      profile = "nix";
      pkgs = import nixpkgs {inherit system;};
    in
      pkgs.mkShell {
        packages = with pkgs; [
          alejandra
          statix
          deadnix
          nil
          nixd
        ];

        shellHook = ''
          export VSCODE_PROFILE="${profile}";
        '';
      };
  };
}
