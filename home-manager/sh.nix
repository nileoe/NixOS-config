{ config, pkgs, ...}:
let 
shellAliases = {
##### Basic commands / simple navigation
	cat = "bat -p --theme 'Visual Studio Dark+'";
	".1" = "cd ..";
	".2" = "cd ../../";
	".3" = "cd ../../..";
	cl = "clear";
	ll = "ls -l";
	o = "exit";
	":q" = "exit";
	tl = "tree -L";
	gf = "fg";
	g = "grep --colour=auto";
	gi = "grep -i --colour=auto";
	cp = "cp -i";
	mv = "mv -i";
	rm = "rm -i";
	v = "nvim";
	gho = "Hyprland";

##### zoxide
		cd = "z";

		tm = "tmux";
	tma = "tmux attach || (echo 'No current session: creating new') && sleep 0.5 && tm";

##### NixOS
	hswitch= "cd ~/nix-config && home-manager switch --flake .#nileoe@lix";
	nswitch = "cd ~/nix-config && sudo nixos-rebuild switch --flake .#lix";

##### Miscellaneous
	airpods = "dispods; bluetoothctl connect 3C:4D:BE:89:38:4D";
		airpodso = "airpods && o";
		dispods = "bluetoothctl disconnect 3C:4D:BE:89:38:4D";

##### Git perso
		dpull="cd ~/docs && git pull --rebase && cd ~";
		dpush="cd /home/nil_/docs && git add * ; git commit -m 'lix commit ($(date))' && git push"; # fix this for fun someday, use hostname

##### Coding shortcuts
		py = "python3";
	p="clear && python3 *.py";

		j="clear && javac *.java && clear && java Main && echo ''";

		rr="clear && cargo run";
		rb="clear && cargo build";
		rt="clear && cargo test";

		no="cl && node *.js";
};
in
{
	programs.zsh =  {
		enable = true;
		inherit shellAliases;
	};
	programs.bash =  {
# enable = true;
		inherit shellAliases;
	};
}
