{ nixosConfig, ... }:
let
  machines = {
    smithers = {
      "laptop-only" = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.3;
          }
        ];
      };
      "homeoffice" = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-9";
            scale = 1.3;
            position = "0,0";
          }
          {
            criteria = "DP-10";
            scale = 1.3;
            position = "2952,0";
          }
        ];
      };
    };
  };
in
{
  services.kanshi = {
    enable = true;
    profiles = machines."${nixosConfig.networking.hostName}";
  };

}
