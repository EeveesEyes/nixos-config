{lib, config, ...}:
{
  services.tlp = lib.mkIf config.my.includeTLP {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "AC";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_HWP_ON_AC = "performance";
      CPU_HWP_ON_BAT = "balance_power";

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;

      RESTORE_DEVICE_STATE_ON_STARTUP = 1;

      # BAT 0 - Internal battery
      START_CHARGE_THRESH_BAT0 = 60;
      STOP_CHARGE_THRESH_BAT0 = 95;

      # BAT 1 - External Battery
      START_CHARGE_THRESH_BAT1 = 60;
      STOP_CHARGE_THRESH_BAT1 = 95;
    };

  };
}
