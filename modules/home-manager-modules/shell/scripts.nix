{ pkgs }:
[
  (import ./scripts/changeWallpaper.nix {inherit pkgs; })
  (import ./scripts/startWpRotation.nix {inherit pkgs; })
  (import ./scripts/toggleWallpaper.nix {inherit pkgs; })
  (import ./scripts/toggleWaybar.nix {inherit pkgs; })
]
# [
#   (import ./script1.nix { inherit pkgs; })
#   (import ./script2.nix { inherit pkgs; })
