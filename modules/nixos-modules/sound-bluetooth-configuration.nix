{
  config,
  lib,
  pkgs,
  ...
}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    bluez
    pavucontrol
    helvum
  ];

  services.pulseaudio.enable = false; # mutually exclusive with pipewire
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # annoying pop sound (disable if not needed)
  boot.extraModprobeConfig = "options snd_hda_intel power_save=0";
  # sudo tee /etc/modprobe.d/snd-hda-intel.conf <<< "options snd_hda_intel power_save=0"
}
