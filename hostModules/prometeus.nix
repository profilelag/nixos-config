{ pkgs, lib, config, ... }: {
  config = {
    services.prometheus = {
      enable = true;
      scrapeConfigs = [
        {
          job_name = "apcupsd";
          static_configs = [
            {
              targets = [ "localhost:9162" ];
            }
          ];
        }
        {
          job_name = "node";
          static_configs = [
            {
              targets = [ "localhost:9161" ];
            }
          ];
        }
      ];
    };
    services.prometheus.exporters.apcupsd = {
      enable = true;
      port = 9162;
      apcupsdAddress = "0.0.0.0:3551";
    };
    services.prometheus.exporters.node = {
      enable = true;
      extraFlags = [ "--collector.textfile.directory=/var/lib/node_exporter/textfile_collector" ];
      port = 9161;
    };
    services.apcupsd = {
      enable = true;
      configText = ''
        UPSTYPE usb
        UPSCABLE usb
        NISIP 0.0.0.0
        NISPORT 3551
      '';
    };
  };
}