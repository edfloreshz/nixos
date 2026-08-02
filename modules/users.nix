{ pkgs, ... }:
{
  users.groups.media = {};

  users.users.eduardo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "media" ];
    packages = with pkgs; [
      tree
    ];
  };

  users.users.jellyfin.extraGroups = [ "media" ];

  programs.fish.enable = true;
  programs.git = {
    enable = true;
    config = {
      user = {
        name  = "Eduardo Flores";
        email = "edfloreshz@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
}
