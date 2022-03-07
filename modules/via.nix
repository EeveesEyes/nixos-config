{pkgs,lib, ...}:{

  # Allow via to be used ( it has an unfree license )
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "via" ];

  # Load udev Rules for via
  services.udev.packages = [ pkgs.via ];

}
