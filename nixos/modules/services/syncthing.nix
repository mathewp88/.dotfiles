{ ... }:
{
  services.syncthing = {
    enable = true;
    dataDir = "/home/mathai";
    openDefaultPorts = true;
    configDir = "/home/mathai/.config/syncthing";
    user = "mathai";
    group = "users";
    guiAddress = "0.0.0.0:8384";
};
}
