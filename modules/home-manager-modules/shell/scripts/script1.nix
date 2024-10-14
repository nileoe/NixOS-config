{ pkgs }:
pkgs.writeShellScriptBin "script1" ''
	echo "Moi je pense que les chips vertes c'est les meilleures" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
''
