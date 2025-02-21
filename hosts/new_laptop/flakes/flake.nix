{
  description = "Peaktop config";

  inputs =
  {

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nvf = {
      url = "github:notashelf/nvf";
    };
  };

  outputs = { self, nixpkgs, home-manager, nvf, ... } @ inputs:

  let

    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    customNeovim = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [./modules/nvf-configuration.nix];
    };
  in
  {
    packages.${system}.my-neovim = customNeovim.neovim;

   homeConfigurations."tesla" = home-manager.lib.homeManagerConfiguration {
     inherit pkgs;
     modules = [
       ./home.nix
     ];
   };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs system; };
      modules = [
        ./configuration.nix
        ./modules/nvidia.nix
        ./modules/fonts.nix
        ./modules/audio.nix
        ./modules/tlp.nix
        # ./modules/wireguard.nix
        inputs.home-manager.nixosModules.default
        {environment.systemPackages = [customNeovim.neovim];}
      ];
    };
  };
}
