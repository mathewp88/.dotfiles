{config, ... }:
{
  hardware.nvidia = {
    powerManagement = {
      enable = true;
      finegrained = true;
    };

    dynamicBoost.enable = true;
    modsetting.enable = true;
      
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:0:6:0";
      nvidiaBusId = "PCI:0:1:0";
    };
    
    nvidiaSettings = false;
    nvidiaPersisted = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;
  };
}
