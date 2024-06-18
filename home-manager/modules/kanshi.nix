{ nixosConfig, ... }:
let
  machines = {
    smithers = [{
      profile.name = "laptop-only";
      profile.outputs = [
        {
          criteria = "eDP-1";
          scale = 1.3;
        }
      ];
    }
      {
        profile.name = "homeoffice";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-10";
            scale = 1.3;
            position = "0,0";
          }
          {
            criteria = "DP-9";
            scale = 1.3;
            position = "2952,0";
          }
        ];
      }];
  };
in
{
  services.kanshi = {
    enable = true;
    settings = machines."${nixosConfig.networking.hostName}";
  };

}
