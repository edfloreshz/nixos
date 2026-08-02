{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    fish
    samba
    btop
    git
  ];
}
