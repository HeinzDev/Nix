{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
		hyprland.url = "github:hyprwm/Hyprland";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {
		self,
		nixpkgs,
		home-manager,
		hyprland,
		...
	}: let
		system = "x86_64-linux";

		imports = [ ./patches/default.nix ];

		pkgs = import nixpkgs {
			inherit system;
			config.allowUnfree = true;
		};
	lib = nixpkgs.lib;

	in {
		nixosConfigurations = {
			silverdev2482 = lib.nixosSystem {
				inherit system pkgs;
				modules = [
					./configuration.nix
					home-manager.nixosModules.home-manager
						{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.silverdev2482 = {
							imports = [./home.nix];
						};
					}
					hyprland.nixosModules.default
					{programs.hyprland.enable = true;}
				];
			};
		};
	};
}
