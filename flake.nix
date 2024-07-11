{
	outputs =
	{ ... }:
	{
		nixosModules = {
			default = import ./module.nix;
		};
	};
}
