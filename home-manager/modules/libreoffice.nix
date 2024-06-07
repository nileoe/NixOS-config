{ config, pkgs, ...}:
{
  home.packages = with pkgs; [
    libreoffice
    # hunspell
    # hunspellDictsChromium.en-gb
    # hunspellDictsChromium.fr_FR
    ];
}
