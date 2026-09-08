{ ... }:
{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "Jellyfin";
        "netbios name" = "Jellyfin";
        "security" = "user";
        "map to guest" = "never";
      };

      delta = {
        "path" = "/media/Delta";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0664";
        "directory mask" = "2775";
        "force group" = "media";
      };

      omega = {
        "path" = "/media/Omega";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0664";
        "directory mask" = "2775";
        "force group" = "media";
      };
    };
  };

  services.samba-wsdd.enable = true; # Windows network discovery

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
