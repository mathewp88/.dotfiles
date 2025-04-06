{config, ... }:
{
  services = {
    # Enable the ACPI daemon.
    acpid.enable = true;

    # Enable the auto-cpufreq daemon.
    power-profiles-daemon.enable = false;
    auto-cpufreq.enable = true;

    # Enable security levels for Thunderbolt 3 on GNU/Linux.
    hardware.bolt.enable = true;

    # Extra config options for systemd-logind.
    logind = {
      powerKey = "hibernate";
      lidSwitch = "hibernate";
      lidSwitchExternalPower = "suspend";
    };

    # Enable thermald, the temperature management daemon.
    #thermald.enable = true; # Disabled on amd

    # Enable Upower, a DBus service that provides power management support to applications.
    upower = {
      enable = true;
      percentageLow = 10;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "Hibernate";
    };
  };
}
