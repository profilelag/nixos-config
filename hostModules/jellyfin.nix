{ pkgs, lib, config, ... }: {
  config = {
    environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      dataDir = "/data/nas/jellyfin";
    };
  };
}