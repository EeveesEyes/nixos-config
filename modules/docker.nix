{
  virtualisation.docker = {
    enable = true;
    storageDriver = "overlay2";
    liveRestore = true;
    autoPrune.enable = true;
  };
}
