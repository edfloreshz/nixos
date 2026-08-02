# Headless BitTorrent client with a web UI, reachable at
# torrent.edfloreshz.dev via the Cloudflare tunnel (see ./cloudflared.nix) -
# no port is opened to the internet directly. RPC auth is required since
# the UI is internet-reachable through the tunnel; the password lives in
# secrets/secrets.yaml as `transmission_rpc_password` (see modules/sops.nix
# for the sops command). Username is fixed to "eduardo" below.
{ config, ... }:
{
  sops.secrets.transmission_rpc_password = { };

  services.transmission = {
    enable = true;
    openRpcPort = false;
    credentialsFile = config.sops.secrets.transmission_rpc_password.path;
    settings = {
      rpc-bind-address = "127.0.0.1";
      rpc-authentication-required = true;
      rpc-username = "eduardo";
      download-dir = "/var/lib/transmission/downloads";
      incomplete-dir-enabled = true;
    };
  };
}
