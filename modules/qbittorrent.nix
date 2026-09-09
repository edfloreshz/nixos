{ config, lib, pkgs, ... }:
let
  passwordPlaceholder = "@qbittorrent_webui_password_pbkdf2@";
in
{
  sops.secrets.qbittorrent_webui_password_pbkdf2 = {
    owner = "eduardo";
  };

  services.qbittorrent = {
    enable = true;
    webuiPort = 8080;
    openFirewall = true;
    user = "eduardo";
    group = "media";
    serverConfig = {
      Preferences = {
        Downloads.SavePath = "/media/Omega/Uncategorized/";
        WebUI = {
          Address = "0.0.0.0";
          HostHeaderValidation = false;
          Username = "medusin";
          Password_PBKDF2 = passwordPlaceholder;
        };
      };
    };
  };

  systemd.services.qbittorrent = {
    after = [ "sops-nix.service" ];
    wants = [ "sops-nix.service" ];
    serviceConfig.ExecStartPre = lib.mkAfter [
      "${lib.getExe pkgs.replace-secret} '${passwordPlaceholder}' '${config.sops.secrets.qbittorrent_webui_password_pbkdf2.path}' '${config.services.qbittorrent.profileDir}/qBittorrent/config/qBittorrent.conf'"
    ];
  };
}
