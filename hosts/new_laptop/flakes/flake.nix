{
  description = "A very basic flake";

  inputs = {

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

    nvf.url = "github:notashelf/nvf";

  };

  outputs = { self, nixpkgs, home-manager, nvf, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
#    homeConfigurations."tesla" = home-manager.lib.homeManagerConfiguration {
#      inherit pkgs;
#      modules = [
#        ./home.nix
#      ];
#    };

 #    packages.system.default =
 #      (nvf.lib.neovimConfiguration {
 #        inherit pkgs;
	# modules = [
	#   ./modules/nvf-configuration.nix
	# ];
 #      })
 #      .neovim;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs system; };
      modules = [
        ./configuration.nix
        ./modules/nvidia.nix
        ./modules/fonts.nix
        ./modules/audio.nix
        nvf.nixosModules.default
        #inputs.home-manager.nixosModules.default
      ];
    };
  };
}
