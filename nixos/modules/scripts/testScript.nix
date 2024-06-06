{pkgs}:
pkgs.writeShellScriptBin "test_script" ''
echo "Coucou maman" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
''
