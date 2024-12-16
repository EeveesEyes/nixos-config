{ pkgs, ... }:
{

  programs.vscode = {
    enable = true;

    # Use the proprietary VSCode build from Microsft
    # This way we get the "Settings Sync" feature
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      mhutchie.git-graph
      mkhl.direnv
      yzhang.markdown-all-in-one
      k--kato.intellij-idea-keybindings
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-containers
    ];

    userSettings = {
      "files.autoSave" = "afterDelay";
      "workbench.colorTheme" = "Hypnos";
      "git.autofetch" = true;
      "[nix]"."editor.tabSize" = 2;
    };
  };
}
