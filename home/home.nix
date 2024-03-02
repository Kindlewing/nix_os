{ config, pkgs, inputs, username, ... }:

{
  imports = [
  	inputs.nix-colors.homeManagerModules.default
	./zsh.nix
	./kitty.nix

  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-medium;
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  	pkgs.starship
	pkgs.nodejs
	pkgs.swaybg
	pkgs.neovim
	pkgs.lazygit
	pkgs.wofi
	pkgs.wlogout
	pkgs.firefox
	pkgs.eza
	pkgs.spotify
	pkgs.rustup
	pkgs.go
	pkgs.bat
	pkgs.ripgrep
	pkgs.zoxide
  ];

	home.sessionVariables = {
		EDITOR = "/run/current-system/sw/bin/nvim";
		SUDO_EDITOR = "/run/current-system/sw/bin/nvim";
		VISUAL = "/run/current-system/sw/bin/nvim";
		PAGER = "/run/current-system/sw/bin/less";
		BROWSER = "/run/current-system/sw/bin/firefox";
	};

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
	  hyprland = {
		  recursive = true;
		  source = ../dotfiles/hypr;
		  target = "./.config/hypr";
	  };
	  waybar = {
		  recursive = true;
		  source = ../dotfiles/waybar;
		  target = "./.config/waybar";
	  };

	  neovim = {
		  recursive = true;
		  source = ../dotfiles/nvim;
		  target = "./config/nvim";
	  };
  };

  programs.starship = {
	  enable = true;
	  settings =  pkgs.lib.importTOML ../dotfiles/starship.toml;
  };


  programs.home-manager.enable = true;
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
