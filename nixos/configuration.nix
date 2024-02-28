# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
	  inputs.home-manager.nixosModules.home-manager
    ];

	home-manager = {
		extraSpecialArgs = { inherit inputs pkgs; };
		users = {
			hudson = import ./home.nix;
		};
	};

  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nix.settings.experimental-features = ["nix-command" "flakes" ];

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

programs.hyprland = {
    enable = true;
    xwayland.enable = true;
};

programs.zsh = {
    enable = true;
};

fonts.packages = with pkgs; [
	(nerdfonts.override { fonts = ["FiraCode"]; })
];

users.defaultUserShell = pkgs.zsh;
environment.systemPackages = with pkgs; [
	libnotify
	curl
	cmake
	extra-cmake-modules
	gnumake
	wayland
	xwayland
	libxkbcommon
	pkg-config
	git
	xorg.libX11
	wayland-protocols
	gcc
	glibc
	wl-clipboard
	mesa
	unzip
	pkg-config
	xdg-desktop-portal-gtk
	xdg-desktop-portal-hyprland
	curl
	less

	pkgs.mako
	pkgs.home-manager
	(pkgs.waybar.overrideAttrs (oldAttrs: {
	mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
	})
	)
  ];

xdg.portal = {
   enable = true;
   extraPortals = with pkgs; [ 
       pkgs.xdg-desktop-portal-gtk 
   ];
};

environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
};

hardware = {
    opengl.enable = true;
};



  services.printing.enable = true;
  hardware.bluetooth.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.hudson = {
    isNormalUser = true;
    description = "Hudson Finn";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
