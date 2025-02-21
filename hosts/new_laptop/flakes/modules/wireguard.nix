{pkgs, config, lib,...}:

{
  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };
  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.101.10.2/32" ];
      listenPort = 51820;
      privateKeyFile = "/etc/keys/wireguard-private";
      peers = [{
        publicKey = "AtnV4kOijk1Hppvqb0ouFGMHn7vMGoKgRkPQeejNNFk=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "71.176.103.123:51820";
        persistentKeepalive = 25;
      }];
    };
  };
}
