{...}:
{
	programs.zsh = {
	  enable = true;
	  enableAutosuggestions = true;
	  enableCompletion = true;
	  syntaxHighlighting = {
		  enable = true;
	  };

	  shellAliases = {
		ls = "eza -hlX --icons --group-directories-first --color=always";	
		vim = "nvim";
		grep = "rg";
		cat = "bat";
	  };

	  zplug = {
		  enable = true;
		  plugins = [
			{ name = "zsh-users/zsh-autosuggestions"; }
			{ name = "zsh-users/zsh-syntax-highlighting"; }
			{ name = "jeffreytse/zsh-vi-mode"; }
		  ];
	  };
	};
}
