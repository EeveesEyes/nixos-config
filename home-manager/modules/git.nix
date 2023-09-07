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
    userName = "fleaz";
    userEmail = "mail@felixbreidenstein.de";
    signing = {
      key = "9166FF9DFC1F4637";
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

    includes = [{
      condition = "gitdir:~/denic/";
      contents = {
        user = {
          email = "breidenstein@denic.de";
          name = "Felix Breidenstein";
        };
        commit = {
          gpgSign = false;
        };
      };
    }
    ];
  };
}
