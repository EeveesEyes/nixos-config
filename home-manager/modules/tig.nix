{
  home.file."tig_config" = {
    enable=true;
    target="/home/hagoromo/.config/tig/config";
    text=''
      # Use Git's default (reverse chronological) order, never automatically
      # use topo-order for the commit graph
      set commit-order = default

      # Limit number of commits loaded by default to 1000
      set main-options = -n 1000

      # Don't show staged and unstaged changes in the main view
      set show-changes = no

      # Optionally, use the old and faster but less acurate graph renderer
      #set main-view-commit-title-graph = v1
    '';
  };
}
