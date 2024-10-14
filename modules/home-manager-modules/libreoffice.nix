{ config, pkgs, ...}:
{
  home.packages = with pkgs; [
    libreoffice
    # hunspell
    # hunspelldictschromium.en-gb
    # hunspelldictschromium.fr_fr
    ];
}
