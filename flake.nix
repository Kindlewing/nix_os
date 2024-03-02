{
  description = "My system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	nix-colors.url = "github:misterio77/nix-colors";

	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
	let 
	username = "hudson";
	system = "x86_64-linux";

	pkgs = import nixpkgs {
		inherit system;
		config = {
			allowUnfree = true;
		};
	};
	in {
		homeConfigurations = {
			username = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.${system};
				extraSpecialArgs = {
					inherit inputs;
					inherit username;
				};
				modules = [
					./home/home.nix
				];
			};
		};

		nixosConfigurations = {
			system =  nixpkgs.lib.nixosSystem {
				inherit system; 
				modules = [
					./system/configuration.nix
				];

				specialArgs = { 
					inherit inputs;
					inherit pkgs; 
					inherit username;
				};

			};
		};
	};
}
