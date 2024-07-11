{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
	};

	outputs =
	{ nixpkgs }:
	{
		nixosModules = {
			default = import ./module.nix;
		};
	};
}
