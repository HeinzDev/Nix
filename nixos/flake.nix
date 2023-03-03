{
  description = "A basic home manager setup";
  
 inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  home-manager = {
   url = github:nix-community/home-manager;
   inputs.nixpkgs.follows = "nixpkgs";
  };
};

  outputs = { self, nixpkgs, home-manager, ...}: 
   let
     hostname = "nixos";
     username = "enzo";
     system = "x86_64-linux";
     pkgs = import nixpkgs {
	inherit system;
	config.allowUnfree = true;	
     };
     lib = nixpkgs.lib;
in {
 nixosConfigurations = {
  enzo = lib.nixosSystem {
   inherit system;
   modules = [ 
    ./configuration.nix
    home-manager.nixosModules.home-manager {
     home-manager.useGlobalPkgs = true;
     home-manager.useUserPackages = true;
     home-manager.users.enzo = {
	imports = [ ./home.nix ];
     };
    }
   ];
  };
 };
 hmConfig = {
  inherit system;
  enzo = home-manager.lib.homeManagerConfiguration {
   pkgs = nixpkgs.legacyPackages.${system};
  modules = [
    ./home.nix
    {
      home = {
        username = "enzo";
        homeDirectory = "/home/enzo";
        stateVersion = "22.11";
      };
    }
  ];

   };
  };
 };
 
}
