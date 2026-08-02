# Cloudflare Tunnel. Credentials come from sops-nix (see ./sops.nix) rather
# than a plaintext file - run `cloudflared tunnel login` and
# `cloudflared tunnel create <name>` on the host, then put the resulting
# <tunnel-id>.json contents into secrets/secrets.yaml under
# `cloudflared_credentials` (see modules/sops.nix for the sops command).
{ config, ... }:
{
  sops.secrets.cloudflared_credentials = { };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "617359c5-c295-43d1-8c9f-fee8a8b12a5d" = {
        credentialsFile = config.sops.secrets.cloudflared_credentials.path;
        default = "http_status:404";
        ingress = {
          "stream.edfloreshz.dev" = "http://localhost:8096";
        };
      };
    };
  };
}
