{ ... }:
{
  networking.hostName = "jelly";
  networking.networkmanager.enable = true;

  networking.interfaces.enp4s0.ipv4.addresses = [{
    address = "192.168.1.108";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "1.1.1.1" ];

  # Firewall ports opened manually (Samba/Jellyfin open their own via openFirewall)
  # 3389 = RDP (KDE Remote Desktop), LAN access only - remote access from outside goes over Tailscale below
  networking.firewall.allowedTCPPorts = [ 5357 3389 ];
  networking.firewall.allowedUDPPorts = [ 3702 ];

  # Tailscale: WireGuard VPN for reaching this machine (e.g. RDP) from outside the LAN
  # without exposing any ports to the public internet.
  # Uses the self-hosted Headscale server at headscale.edfloreshz.dev instead of
  # Tailscale's default coordination server - after rebuilding, run once:
  #   sudo tailscale up --login-server https://headscale.edfloreshz.dev
  # (tailscaled persists the login server after that, so this is a one-time step
  # unless /var/lib/tailscale state is wiped.)
  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  time.timeZone = "America/Hermosillo";
}
