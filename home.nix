{ config, pkgs, ... }:

{
  home.username = "napi";
  home.homeDirectory = "/home/napi";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    wget
    curl
    btop
    vscode
    brave
    kitty
    wireshark
    wl-clipboard
    mako
  ];

  programs.git = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.bash = {
    enable = true;

    shellAliases = {
      ll = "ls -lah";
      gs = "git status";
    };
  };

  programs.home-manager.enable = true;

  systemd.user.services.spice-vdagent = {
    Unit = {
      Description = "SPICE user agent";
      After = [
        "spice-vdagentd.service"
	"graphical-session.target"
      ];
      Requires = [
        "graphical-session.target"
      ];
    };

    Service = {
      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
    };

    Install = {
      WantedBy = [
        "graphical-session.target"
      ];
    };
  };
}
