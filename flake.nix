{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@attrs: {
    nixosConfigurations.enzo = nixpkgs.lib.nixosSystem { # your architecture
      specialArgs = attrs;
      modules = [ ./configuration.nix ];
    };
  };
}
