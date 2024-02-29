{
  description = "My system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, ... }@inputs: 
	let 
	system = "x86_64-linux";
	pkgs = import nixpkgs {
		inherit system;
		config = {
			allowUnfree = true;
		};
	};
	in {
		nixosConfigurations = {
			system =  nixpkgs.lib.nixosSystem {
				inherit system; 
				modules = [
					./system/configuration.nix
				];

				specialArgs = { 
					inherit inputs;
					inherit pkgs; 
				};

			};
		};
	};
}
