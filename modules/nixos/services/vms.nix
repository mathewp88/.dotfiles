{
  flake.nixosModules.vms =
    {
      pkgs,
      config,
      ...
    }:
    {
      # Set up virtualisation
      virtualisation.libvirtd = {
        enable = true;

        # Enable TPM emulation (for Windows 11)
        qemu = {
          swtpm.enable = true;
        };
      };

      # Enable USB redirection
      virtualisation.spiceUSBRedirection.enable = true;

      # Allow VM management
      users.groups.libvirtd.members = [ config.preferences.user.name ];
      users.groups.kvm.members = [ config.preferences.user.name ];
      environment.systemPackages = with pkgs; [
        gnome-boxes # VM management
        dnsmasq # VM networking
        phodav # (optional) Share files with guest VMs
      ];

    };
}
