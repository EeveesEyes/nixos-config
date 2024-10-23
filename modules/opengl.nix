{ pkgs, ... }: {
  hardware.opengl = { # moved to hardware.graphics in unstable
    enable = true;
    driSupport = true;
  };
  hardware.opengl.extraPackages = with pkgs; [
      # compute
      intel-compute-runtime
      intel-ocl

      # encode/decode
      # intel-vaapi-driver # collision
      intel-media-driver
    ];
}
