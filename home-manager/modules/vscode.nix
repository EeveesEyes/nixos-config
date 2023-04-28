{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { };
in
{

  programs.vscode = {
    enable = true;
    package = unstable.vscodium;
    extensions = with pkgs.vscode-extensions; [
      # Dark Theme
      dracula-theme.theme-dracula

      # Terraform and HCL support
      hashicorp.terraform

      # Python
      ms-python.python

      # Vim 
      vscodevim.vim

      # Markdown highlighting/formatting/preview
      yzhang.markdown-all-in-one
    ];
  };
}
