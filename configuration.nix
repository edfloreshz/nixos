# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ./modules/boot.nix
    ./modules/storage.nix
    ./modules/networking.nix
    ./modules/power.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/samba.nix
    ./modules/jellyfin.nix
    ./modules/ssh.nix
    ./modules/sops.nix
    ./modules/cloudflared.nix
  ];

  # This value should stay at the version first installed on this machine.
  # See: https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "26.05";

  system.copySystemConfiguration = true;
}

