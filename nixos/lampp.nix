{ pkgs, userSettings, ... }:

{

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  systemd.tmpfiles.rules = [
    # Type Path Mode User Group Age Arguments
    "d /var/www/ 0755 - - - -"
    "d /var/www/htdocs/ 0755 ${userSettings.username} users - -"
  ];

  services.httpd = {
    enable = true;
    enablePHP = true;
    enablePerl = true;
    virtualHosts = {
      localhost = {
        documentRoot = "/var/www/htdocs";
      };
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    ensureUsers = [
      {
        name = "wwwrun"; # Uses socket authentication for Apache user
        # MANUAL: sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'wwwrun'@'localhost' WITH GRANT OPTION;"
      }
    ];
  };

}

