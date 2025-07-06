{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./hostModules/glance.nix
      ./hostModules/jellyfin.nix
      ./hostModules/prometheus.nix
      ./hostModules/samba.nix
      ./hostModules/tailscale.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "onyx";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  users.users = {
    "nkeller" = {
      isNormalUser = true;
      description = "Nicholas Keller";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBqp5EIJhPZDZjQv9z4dgVIGfMypHAlo/m36hzxvM15L laptop"
        ];
    };
    "root" = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdomjhsEzjVXAPWXSFAelJMotfkT+nlwIMbYhG2ziVA nkeller@nixos"
      ];
    };
  };
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  ];
  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/1cb134f2-b190-45d2-aa4d-f270785e2b02";
    fsType = "ext4";
    options = [ "noauto" "nofail" ];
  };
  services.openssh.enable = true;

  system.stateVersion = "25.05";
}