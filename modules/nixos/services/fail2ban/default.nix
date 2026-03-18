{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.fail2ban;
in
{
  options.${namespace}.services.fail2ban = with types; {
    enable = mkBoolOpt false "Enable fail2ban";
  };

  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
      maxretry = 5;
      bantime = "24h";
      bantime-increment = {
        enable = true;
        multipliers = "1 2 4 8 16 32 64";
        maxtime = "168h";
        overalljails = true;
      };
      jails = {
        sshd.settings = {
          enabled = true;
          maxretry = 3;
          bantime = "23h";
        };
        nginx-req-limit.settings = {
          enabled = true;
          filter = "nginx-req-limit";
          action = ''iptables-multiport[name=ReqLimit, port="http,https"]'';
          logpath = "/var/log/nginx/error.log";
          backend = "auto";
          maxretry = 10;
          bantime = "24h";
        };
        nginx-botsearch.settings = {
          enabled = true;
          filter = "nginx-botsearch";
          action = ''iptables-multiport[name=BotSearch, port="http,https"]'';
          logpath = "/var/log/nginx/access.log";
          backend = "auto";
          maxretry = 5;
          bantime = "48h";
        };
        nginx-url-probe.settings = {
          enabled = true;
          filter = "nginx-url-probe";
          logpath = "/var/log/nginx/access.log";
          action = ''iptables-multiport[name=UrlProbe, port="http,https"][blocktype=DROP]'';
          backend = "auto";
          maxretry = 3;
          findtime = 600;
          bantime = "168h"; # 1 week for bots probing wp-admin etc
        };
      };
    };

    # Custom filter for URL probing
    environment.etc."fail2ban/filter.d/nginx-url-probe.local".text = lib.mkAfter ''
      [Definition]
      failregex = ^<HOST>.*(GET /(wp-|admin|boaform|phpmyadmin|\.env|\.git)|\.(dll|so|cfm|asp)|(\?|&)(=PHPB8B5F2A0-3C92-11d3-A3A9-4C7B08C10000|=PHPE9568F36-D428-11d2-A769-00AA001ACF42|=PHPE9568F35-D428-11d2-A769-00AA001ACF42|=PHPE9568F34-D428-11d2-A769-00AA001ACF42)|\\x[0-9a-zA-Z]{2})
    '';

    services.nginx.commonHttpConfig = ''
      log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent"';
      access_log /var/log/nginx/access.log main;
      error_log /var/log/nginx/error.log warn;
    '';
  };
}
