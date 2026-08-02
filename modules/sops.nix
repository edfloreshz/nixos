# sops-nix: encrypted secrets, decrypted at activation time using an age
# key that lives only on the host (not tracked in this repo). The
# sops-nix module itself is imported via the flake input in flake.nix.
#
# One-time host setup:
#   1. mkdir -p /var/lib/sops-nix
#      nix-shell -p age --run 'age-keygen -o /var/lib/sops-nix/key.txt'
#   2. Copy the "public key" printed above into .sops.yaml (repo root) as the
#      recipient for this host.
#   3. nix-shell -p sops --run 'sops secrets/secrets.yaml'
#      and add a `cloudflared_credentials` key with the contents of the
#      <tunnel-id>.json produced by `cloudflared tunnel create <name>`.
{ ... }:
{
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
}
