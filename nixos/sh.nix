{ config, pkgs, ...}:
let 
shellAliases = {
	ll = "ls -l";
	v = "nvim";
	cl = "clear";
	o = "exit";
	":q" = "exit";
	cat = "bat -p --theme 'Visual Studio Dark+'";
	".1" = "cd ..";
	".2" = "cd ../../";
	".3" = "cd ../../..";
	tl = "tree -L";
	gf = "fg";
	g = "grep --colour=auto";
	gi = "grep -i --colour=auto";
	tm = "tmux";
	tma = "tmux attach || (echo 'Creating new session.') && sleep 0.5 && tm";
	cp = "cp -i";
	mv = "mv -i";
	rm = "rm -i";
	hswitch= "cd ~/nix-config && home-manager switch --flake .#nileoe@lix";
	nswitch = "cd ~/nix-config && sudo nixos-rebuild switch --flake .#lix";
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
