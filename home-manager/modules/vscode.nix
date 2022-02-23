{ pkgs, ... }: {

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium; # You can skip this if you want to use the unfree version
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
