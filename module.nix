{ pkgs, config, lib, ... }:

{
	options = {
		services.launchpad = {
			enable = lib.mkOption {
				type = lib.types.bool;
				description = "Whether launchpad should be run or not";
				default = false;
				example = true;
			};

			port = lib.mkOption {
				type = lib.types.int;
				description = "On which port web interface should be visible";
				default = 3000;
			};
		};
	};

	config = 
	let
		cfg = config.services.launchpad;
	in
	lib.mkIf cfg.enable {
		virtualisation.docker.enable = true;

		systemd.services.launchpad = 
		lib.mkIf cfg.enable
		{
			enable = true;
			wantedBy = [ "multi-user.target" ];
			script = ''
				${pkgs.docker}/bin/docker run --rm -d -p ${toString cfg.port}:3000 --name launchpad fpekal/launchpad
			'';
			preStop = ''
				${pkgs.docker}/bin/docker stop launchpad
			'';
			stopIfChanged = true;
			serviceConfig = {
				RemainAfterExit="yes";
				Type="oneshot";
			};
		};
	};
}
