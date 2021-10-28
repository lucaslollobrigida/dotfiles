{
  description = "Nix based dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
    unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    hardware.url = "github:NixOS/nixos-hardware/master";

    home = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };

    picom-jonaburg = {
      url = "github:jonaburg/picom";
      flake = false;
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nubank.url = "github:nubank/nixpkgs/master";
  };

  outputs = { self, nixpkgs, home, ... }@inputs: {
    nixosConfigurations.precision = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [ ./hosts/precision ];
      specialArgs = { inherit inputs system; };
    };

    homeConfigurations.home-linux = home.lib.homeManagerConfiguration rec {
      configuration = ./home;
      system = "x86_64-linux";
      homeDirectory = "/home/lollo";
      username = "lollo";
      extraSpecialArgs = {
        inherit inputs system;
        super = {
          user = {
            name = "Lucas Lollobrigida";
            username = username;
            email = "lucas.lollobrigida@nubank.com.br";
            gpgkey = "A9D1FF3A";
            shell = nixpkgs.zsh;
            github.username = "lucaslollobrigida";
          };
        };
      };
    };
  };
}
