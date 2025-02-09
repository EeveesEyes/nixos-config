{pkgs, ...}:{
  programs.git = {
    enable = true;
    package = pkgs.gitSVN;
    ignores = [
      ".vscode"
      "*.sql"
      "*.sql.gz"
      "*.sql.zst"
      ".direnv/"
      ".venv/"
    ];
    userName = "EeveesEyes";
    userEmail = "a@kailus.dev";
    signing = {
      key = "2B0353D272C78090C71AD3C0CB2C9F3DD408992A";
      signByDefault = true;
    };
    extraConfig = {
      "core" = {
        pager = "less -F -X";
      };
      "init" = {
        defaultBranch = "main";
      };
      "pull" = {
        rebase = "true";
      };
      "push" = {
        autoSetupRemote = "true";
      };
      "rebase" = {
        autoStash = "true";
      };
    };


    aliases = {
      # checkout-pull-request from GitHub
      cpr = "!f() { git fetch origin refs/pull/$1/head && git checkout FETCH_HEAD; }; f";
    };
  };
}
