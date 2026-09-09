{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  # oci-containers (used by modules/minepanel.nix) defaults to podman;
  # force it to use the docker daemon set up above instead.
  virtualisation.oci-containers.backend = "docker";

  users.users.eduardo.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
