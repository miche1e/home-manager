{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "michele";
  home.homeDirectory = "/home/michele";

  nixpkgs = {
    config.allowUnfree = true;
  };

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
  home.packages = with pkgs; [
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

    xclip
    gnupg
    tree
    ripgrep
    scrcpy
    android-studio
    vscode
    sqlitebrowser
    postman
    conda
    libreoffice-qt6-fresh
    tor-browser
    chromium
    teams-for-linux
    spotify
    docker
    telegram-desktop
    nixfmt-rfc-style
    nil
    bash-language-server
    btop
    sshfs
    fuse3
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
    ".config/nixpkgs/config.nix".text = ''
      { ... }:

      {
        allowUnfree = true;
      }
    '';
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
  #  /etc/profiles/per-user/mike/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.ignoreAllDups = true;
      plugins = [
        {
          name = "do-you-even-nix";
          file = "do-you-even-nix.zsh-theme";
          src = pkgs.fetchFromGitHub {
            owner = "miche1e";
            repo = "do-you-even-nix";
            rev = "v1.0.1";
            sha256 = "n9QYjpXlGdLx6agwp14rwcc6Jr5+0E/2h/oMuFsveHA=";
          };
        }
      ];

      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake";
        update = "nix flake update";
        open = "xdg-open";
      };

      oh-my-zsh = {
        enable = true;
        # theme = "agnoster";
        plugins = [
          "colored-man-pages"
          "sudo"
        ];
      };
    };

    git = {
      enable = true;
      userName = "mikeNatali";
      userEmail = "michele.na7ali@gmail.com";
      extraConfig = {
        credential.helper = "store";
        push.autoSetupRemote = true;
        core.editor = "nvim";
      };
    };

    neovim =
      let
        pluginConfigurationsPath = ./nvim;
        loadFromName = file: builtins.readFile "${pluginConfigurationsPath}/${file}";
      in
      {
        enable = true;
        viAlias = true;
        vimAlias = true;
        extraLuaConfig = loadFromName "extraConfig.lua";
        plugins = with pkgs.vimPlugins; [
          vim-fugitive
          vim-highlightedyank

          # those are lsp stuff
          nvim-lspconfig
          nvim-cmp
          cmp-nvim-lsp
          {
            plugin = lsp-zero-nvim;
            type = "lua";
            config = loadFromName "lsp-zero.lua";
          }
          {
            plugin = telescope-nvim;
            type = "lua";
            config = loadFromName "telescope.lua";
          }
          {
            plugin = onedark-nvim;
            type = "lua";
            config = loadFromName "onedark.lua";
          }
          {
            plugin = nvim-treesitter.withAllGrammars;
            type = "lua";
            config = loadFromName "treesitter.lua";
          }
          {
            plugin = undotree;
            type = "lua";
            config = loadFromName "undotree.lua";
          }
          {
            plugin = nvim-neoclip-lua;
            type = "lua";
            config = loadFromName "neoclip.lua";
          }
        ];
      };
  };
}
