{pkgs, ...}:
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

     plugins = [
	 	{
			name = "zsh-syntax-highlighting";
			src = pkgs.zsh-syntax-highlighting;
			file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
		}
		{
			name = "zsh-autosuggestions";
			src = pkgs.zsh-autosuggestions;
			file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
		}
		{
			name = "vi-mode";
			src = pkgs.zsh-vi-mode;
			file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
	 ];	
	};
}
