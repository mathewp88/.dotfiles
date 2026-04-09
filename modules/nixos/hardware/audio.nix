{
  flake.nixosModules.audio =
    { config
    , lib
    , pkgs
    , ...
    }:
    {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;

        alsa = {
          enable = true;
          support32Bit = true;
        };

        audio.enable = true;
        jack.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
        wireplumber.configPackages = lib.mkIf config.hardware.bluetooth.enable [
          (pkgs.writeTextDir "share/bluetooth.lua.d/51-bluez-config.lua" ''
            bluez_monitor.properties = {
              ["bluez5.enable-sbc-xq"] = true,
              ["bluez5.enable-msbc"] = true,
              ["bluez5.enable-hw-volume"] = true,
              ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
            }
          '')
        ];
      };

      environment.systemPackages = with pkgs; [ pavucontrol ];
    };
}
