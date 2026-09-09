{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    fish
    firefox
    samba
    btop
    git
    gnupg
    pinentry-curses
    cloudflared
    ffmpeg
    python3
    claude-code
  ];
}
