{ config, ... }:
{
  sops.secrets.qbittorrent_webui_password_pbkdf2 = { };

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
          Password_PBKDF2 = builtins.readFile config.sops.secrets.qbittorrent_webui_password_pbkdf2.path;
        };
      };
    };
  };
}
