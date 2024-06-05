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

    hardware.pulseaudio.enable = true;

# annoying stupid pop
    boot.extraModprobeConfig = "options snd_hda_intel power_save=0";
# sudo tee /etc/modprobe.d/snd-hda-intel.conf <<< "options snd_hda_intel power_save=0"
}
