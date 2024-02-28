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
	};
	in {
		nixosConfigurations = {
			workstation =  nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs pkgs system; };

				modules = [
					./nixos/configuration.nix
				];
			};
		};
	};
}
