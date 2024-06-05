{ config, pkgs, ...}:
{
  home.packages = with pkgs; [
    libreoffice-qt
    # hunspell
    # hunspellDictsChromium.en-gb
    # hunspellDictsChromium.fr_FR
    ];
}
