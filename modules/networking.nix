{ ... }:
{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  networking.interfaces.wlo1.ipv4.addresses = [{
    address = "192.168.1.56";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "1.1.1.1" ];

  # Firewall ports opened manually (Samba/Jellyfin open their own via openFirewall)
  networking.firewall.allowedTCPPorts = [ 5357 ];
  networking.firewall.allowedUDPPorts = [ 3702 ];

  time.timeZone = "America/Hermosillo";
}
