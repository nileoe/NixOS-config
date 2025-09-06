{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libreoffice
    hunspellDicts.fr-any
  ];
}
