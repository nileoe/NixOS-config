{ config, lib, pkgs, ... }:
{
      environment.sessionVariables = {
	    WLR_NO_HARDWARE_CURSORS = "1"; # avoid invisible cursor
	    NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
      };
}
