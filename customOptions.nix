{lib,...}:{

  options.my = {
    highDPI = lib.mkOption {
      description = "If the device has a high DPI screen";
      default = true;
      type = lib.types.bool;
    };

    includeTLP = lib.mkOption {
      description = "If the device should get TLP";
      default = true;
      type = lib.types.bool;
    };

    isLaptop = lib.mkOption {
      description = "If the device is a laptop";
      default = false;
      type = lib.types.bool;
    };
  };
}
