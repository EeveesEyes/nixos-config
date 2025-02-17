{ pkgs, unstable, lib, ... }: {
  programs.vscode = {
    enable = true;
    # Use the proprietary VSCode build from Microsft
    # This way we get the "Settings Sync" feature
    package = unstable.legacyPackages.${pkgs.system}.vscode;
  };
}
