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
      key = "6D5A0D835EC8769A";
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
    };


    aliases = {
      # checkout-pull-request from GitHub
      cpr = "!f() { git fetch origin refs/pull/$1/head && git checkout FETCH_HEAD; }; f";
    };
  };
}
