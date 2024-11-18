{ config, pkgs, ... }:

{
  imports = [
    ./user/nvim/nvim.nix
    ./user/alacritty/alacritty.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "radustoleru";
  home.homeDirectory = "/Users/radustoleru";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/radustoleru/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.file.".zshrc".text = ''
    export NVM_DIR="$HOME/.nvm"
      [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
      [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

    alias tmux_init='tmux new -s $PWD:t:r'
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Tells what programs should be managed by home manager
  programs.zsh.enable = true;
  programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
            right_format = "$nodejs";
            add_newline = false;
            nodejs = {
                detect_folders = [];
                format = "\\[[$symbol($version)]($style)\\]";
            };
            shell = {
                disabled = true;
            };
            memory_usage = {
                disabled = true;
            };
            line_break = {
                disabled = true;
            };
            package = {
                disabled = true;
            };
      };
  };
  # TODO: move it to tmux.nix
  programs.tmux = {
      enable = true;
      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmuxPlugins.catppuccin
      ];
      extraConfig = ''
        set-option -ga terminal-overrides ",alacritty:Tc"
        set -g default-terminal "alacritty"
        
        unbind C-b
        unbind C-Space
        
        set -g prefix C-Space
        bind C-Space send-prefix
        
        setw -g mode-keys vi
        
        # toggle between the current and previous window 
        bind Space last-window
        
        # toggle between the current and the previous session
        bind-key C-Space switch-client -l
        
        set-option -sg escape-time 10
        set-option -g focus-events on
        
        set-option -g status-position top
        
        set -g base-index 1
        setw -g pane-base-index 1
        
        # Navigation
        bind -r h select-pane -L  # move left
        bind -r j select-pane -D  # move down
        bind -r k select-pane -U  # move up
        bind -r l select-pane -R  # move right
        bind > swap-pane -D       # swap current pane with the next one
        bind < swap-pane -U       # swap current pane with the previous one
        
        # pane resizing
        bind -r H resize-pane -L 2
        bind -r J resize-pane -D 2
        bind -r K resize-pane -U 2
        bind -r L resize-pane -R 2
        
        # panes: window splitting 
        unbind %
        unbind t
        bind t split-window -h
        unbind '"'
        bind - split-window -v
        
        set -g @catppuccin_flavour 'mocha'
        
        set -g @catppuccin_window_left_separator ""
        set -g @catppuccin_window_right_separator " "
        set -g @catppuccin_window_middle_separator " █"
        set -g @catppuccin_window_number_position "right"
        
        set -g @catppuccin_window_default_fill "number"
        set -g @catppuccin_window_default_text "#W"
        
        set -g @catppuccin_window_current_fill "number"
        set -g @catppuccin_window_current_text "#W"
        
        set -g @catppuccin_status_modules_right "application session user"
        
        set -g @catppuccin_status_left_separator  " "
        set -g @catppuccin_status_right_separator ""
        set -g @catppuccin_status_right_separator_inverse "no"
        set -g @catppuccin_status_fill "icon"
        set -g @catppuccin_status_connect_separator "no"
      '';
  };
}
