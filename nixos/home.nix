{ config, pkgs, ... }:

{
  home.username = "hudson";
  home.homeDirectory = "/home/hudson";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  	pkgs.starship
	pkgs.nodejs
	pkgs.swaybg
	pkgs.kitty
	pkgs.neovim
	pkgs.lazygit
	pkgs.wofi
	pkgs.wlogout
	pkgs.firefox
	pkgs.eza
	pkgs.rustup
	pkgs.bat
	pkgs.ripgrep
	pkgs.gcc
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
		  target = "./config/hypr";
	  };
	  waybar = {
		  recursive = true;
		  source = ../dotfiles/waybar;
		  target = "./config/waybar";
	  };

  };

  programs.zsh = {
	  enable = true;
	  enableAutosuggestions = true;
	  enableCompletion = true;
	  syntaxHighlighting = {
		  enable = true;
	  };

	  shellAliases = {
		ls = "eza -hlX --icons --group-directories-first --color=always";	
		vim = "nvim";
		grep = "rg";
		cat = "bat";
	  };

	  zplug = {
		  enable = true;
		  plugins = [
			{ name = "zsh-users/zsh-autosuggestions"; }
			{ name = "zsh-users/zsh-syntax-highlighting"; }
	  		{ name = "jeffreytse/zsh-vi-mode"; }
		  ];
	  };
  };

  programs.starship = {
	  enable = true;
	  settings =  pkgs.lib.importTOML ../dotfiles/starship.toml;
  };


  programs.home-manager.enable = true;
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
