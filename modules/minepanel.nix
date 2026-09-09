# Minepanel: web panel for managing Minecraft servers via Docker.
# https://github.com/Ketbome/minepanel
#
# JWT_SECRET comes from sops-nix. One-time setup: generate a secret with
#   openssl rand -base64 32
# and add it to secrets/secrets.yaml under `minepanel_jwt_secret`
# (see modules/sops.nix for the sops command).
#
# Exposed only on localhost; reachable via the Cloudflare Tunnel
# (minepanel.edfloreshz.dev / minepanel-api.edfloreshz.dev, see
# modules/cloudflared.nix) and over Tailscale by using the tailnet
# hostname/IP with the same ports, since tailscale0 is a trusted
# firewall interface (see modules/networking.nix).
{ config, ... }:
let
  dataDir = "/var/lib/minepanel";
  frontendUrl = "https://minepanel.edfloreshz.dev";
  backendUrl = "https://minepanel-api.edfloreshz.dev";
in
{
  sops.secrets.minepanel_jwt_secret = { };

  sops.templates."minepanel.env".content = ''
    JWT_SECRET=${config.sops.placeholder.minepanel_jwt_secret}
  '';

  systemd.tmpfiles.rules = [
    "d ${dataDir}/servers 0755 root root -"
    "d ${dataDir}/data 0755 root root -"
  ];

  virtualisation.oci-containers.containers.minepanel-backend = {
    image = "ketbom/minepanel-backend:latest";
    ports = [ "127.0.0.1:8091:8091" ];
    volumes = [
      "${dataDir}/servers:/app/servers"
      "${dataDir}/data:/app/data"
      "/var/run/docker.sock:/var/run/docker.sock"
    ];
    environment = {
      NODE_ENV = "production";
      FRONTEND_URL = frontendUrl;
      BASE_DIR = dataDir;
    };
    environmentFiles = [ config.sops.templates."minepanel.env".path ];
    extraOptions = [ "--network=minepanel-network" ];
  };

  virtualisation.oci-containers.containers.minepanel-frontend = {
    image = "ketbom/minepanel-frontend:latest";
    ports = [ "127.0.0.1:3000:3000" ];
    environment = {
      NEXT_PUBLIC_BACKEND_URL = backendUrl;
      NEXT_PUBLIC_DEFAULT_LANGUAGE = "en";
    };
    extraOptions = [ "--network=minepanel-network" ];
  };

  systemd.services.docker-minepanel-network = {
    description = "Create the minepanel-network docker network";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    before = [
      "docker-minepanel-backend.service"
      "docker-minepanel-frontend.service"
    ];
    path = [ config.virtualisation.docker.package ];
    serviceConfig.Type = "oneshot";
    serviceConfig.RemainAfterExit = true;
    script = ''
      docker network inspect minepanel-network >/dev/null 2>&1 || \
        docker network create minepanel-network
    '';
  };
}
