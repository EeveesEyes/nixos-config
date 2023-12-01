{lib,...}:{

options.my.highDPI = lib.mkOption {
    description = "If the device has a high DPI screen";
    default = true;
    type = lib.types.bool;
  };

options.my.includeTLP = lib.mkOption {
    description = "If the device should get TLP";
    default = true;
    type = lib.types.bool;
  };
}
