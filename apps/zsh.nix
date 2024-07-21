{
  programs.zsh = {
    enable = true;
    initExtra = ''
      bindkey  "^[[H"   beginning-of-line
      bindkey  "^[[F"   end-of-line
      bindkey  "^[[3~"  delete-char
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^[[3;5~" kill-word
      bindkey "^H" backward-kill-word
      eval "$(oh-my-posh init zsh --config ~/.dotfiles/themes/oh-my-posh/zen.toml)"
    '';
    history = {
      size = 5000;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
    shellAliases = {
      ls = "ls --color";
      c = "clear";

      hmsw = "home-manager switch --flake ~/.dotfiles";
      nrsw = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    };
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
  };

  programs.oh-my-posh = {
    enable = true;
  };
}
