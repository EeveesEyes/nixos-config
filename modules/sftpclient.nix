{
  services.sftpClient = {
    enable = true;
    defaults = {
      identityFile = "/home/hagoromo/.ssh/id_ed25519";
      port = 22;
      autoMount = true;
    };
    mounts = [
      {
        what = "hagoromo@homelab.local:/data/Storage";
        where = "/mnt/Storage";
      }
    ];
    # binds = [
    #   {
    #     what = "/mnt/Storage/home/Pictures";
    #     where = "/home/user/Pictures";
    #   }
    # ];
  };
}
