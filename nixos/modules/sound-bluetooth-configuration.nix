# mostly copy-paste from https://nixos.wiki/wiki/PipeWire (as of june 2024)
{ config, lib, pkgs, ... }:
{
    sound.enable = true;
# rtkit is optional but recommended
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
# If you want to use JACK applications, uncomment this
        jack.enable = true;
    };

    environment.systemPackages = with pkgs; [
        # more tools available (listed on the page with url on line 1)
        bluez
        pavucontrol
        helvum
    ];

    hardware.pulseaudio.enable = false; # mutually exclusive with pipewire
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        General.Experimental = true; # supposedely to show airpods battery?
    };
    services.blueman.enable = true;

# annoying stupid pop
    boot.extraModprobeConfig = "options snd_hda_intel power_save=0";
# sudo tee /etc/modprobe.d/snd-hda-intel.conf <<< "options snd_hda_intel power_save=0"
}
