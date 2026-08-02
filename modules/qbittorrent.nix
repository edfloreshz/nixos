# Headless BitTorrent client with web UI + built-in search engine,
# reachable both on the LAN (http://<host-ip>:8080) and over the internet
# at torrent.edfloreshz.dev via the Cloudflare tunnel (see
# ./cloudflared.nix). The firewall is opened for the WebUI port so LAN
# clients can reach it directly.
#
{ ... }:
{
  services.qbittorrent = {
    enable = true;
    webuiPort = 8080;
    openFirewall = true;
    user = "eduardo";
    group = "media";
    serverConfig = {
      Preferences = {
        Downloads.SavePath = "/mnt/omega/Uncategorized/";
        WebUI = {
          Address = "0.0.0.0";
          HostHeaderValidation = false;
          Username = "medusin";
          Password_PBKDF2 = ''@ByteArray(AmD9HTY7p9mjSkWjjRT9PQ==:cVlOD3wQZG2sRtU76j/k6D5AdewxhrWLvhh3lvHyM3VWg8UKHY7AxOjksnjfBTtkVaA65Beq8AITwFmhz7uUDw==)'';
        };
      };
    };
  };
}
