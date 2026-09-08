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
  networking.firewall.allowedTCPPorts = [ 5357 ];
  networking.firewall.allowedUDPPorts = [ 3702 ];

  time.timeZone = "America/Hermosillo";
}
