{pkgs, config, lib, ...}:
{
  options = {
    bundles.desktopBase.audio.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.bundles.desktopBase.audio.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    environment.systemPackages = with pkgs; [
      alsa-utils
      pipewire
      #lxqt.pavucontrol-qt
      pavucontrol
      pamixer
      playerctl
      pulseaudio
    ];
  };
}
