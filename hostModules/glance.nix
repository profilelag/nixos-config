{ pkgs, lib, config, ... }: {
  config = {
    services.glance = {
      enable = true;
      settings = {
        server = {
          port = 8080;
          host = "0.0.0.0";
        };
      };
    };
  };
}