
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  

  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
   pname = "distro-grub-themes";
   version = "3.1";
   src = pkgs.fetchFromGitHub {
    owner = "AdisonCavani";
    repo = "distro-grub-themes";
    rev = "v3.1";
    hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
   };
   installPhase = "cp -r customize/nixos $out";
  };


  networking.hostName = "nixos"; # Define your hostname.


  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };


  # X11 windowing system.
   services.xserver = {
   enable = true;

   desktopManager.plasma5.enable = true;
   #displayManager.lightdm.enable = true;

   #Awesome default config file:/run/current-system/sw/etc/xdg/awesome/rc.lua.
   #Copy to ~/.config/awesome/ and make changes.
   windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];

    };
    displayManager = {
        sddm.enable = true;
	# Iniciar com o AwesomeDM 
        #defaultSession = "none+awesome";
    };

    # X11 keymap
    layout = "br";
    xkbVariant = "";

    # Set GPU drivers
    videoDrivers = [ "nvidia" ];
  };

  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # add /.local to $PATH
  environment.variables={
   PATH = [
     "\${HOME}/.local/bin"
   ];
   NIXPKGS_ALLOW_UNFREE = "1";
  }


  #Variáveis de ambiente para o hyperland (WIP)
  #environment.sessionVariables = {
  #HYPRLAND_LOG_WLR = "1";
  #GTK_IM_MODULE = "fcitx";
  #QT_IM_MODULE = "fcitx";
  #SDL_IM_MODULE = "fcitx";
  #GLFW_IM_MODULE = "fcitx";
  #XMODIFIERS = "@im=fcitx";
  #LIBVA_DRIVER_NAME = "nvidia";
  #XDG_SESSION_TYPE = "wayland";
  #GBM_BACKEND="nvidia-drm";
  #__GLX_VENDOR_LIBARY_NAME = "nvidia";
  #WLR_NO_HARDWARE_CURSORS = "1";
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.enzo = {
    isNormalUser = true;
    description = "Enzo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      opera
      neofetch
      lolcat
   ];
  };

  #flatpak
  services.flatpak.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "enzo";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    #gnome3.gnome-tweaks
    discord
    exa
    htop
    ranger
    git
    gnumake
    unzip

  ];
  
  #Garbage colector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.autoUpgrade = {
   enable = true;
   channel = "https://nixos.org/channels/nixos-22.11";
  };
 
  system.stateVersion = "22.11";
  
  #Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
