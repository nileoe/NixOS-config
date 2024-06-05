{ config, pkgs, ...}:
{
environment.systemPackages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDictsChromium.en-gb
    hunspellDictsChromium.fr_FR
    ];
}
