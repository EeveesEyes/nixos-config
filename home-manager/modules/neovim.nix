{ pkgs, ... }: {
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline neoformat vim-monokai ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
    '';
  };
}
