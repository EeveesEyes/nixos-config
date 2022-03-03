{
  programs.git = {
    enable = true;
    ignores = [
      ".vscode"
      "*.sql"
      "*.sql.gz"
      "*.sql.zst"
    ];
    userName = "fleaz";
    userEmail = "mail@felixbreidenstein.de";
    signing = {
      key = "9166FF9DFC1F4637";
      signByDefault = true;
    };
    extraConfig = {
      "init" = {
        defaultBranch = "main";
      };
    };


    aliases = {
      cpr = "!f() { git fetch origin refs/pull/$1/head && git checkout FETCH_HEAD; }; f";
    };

    includes = [{
      condition = "gitdir:~/codemonauts/";
      contents = {
        user = {
          email = "felix@codemonauts.com";
          name = "Felix Breidenstein";
        };
        commit = {
          gpgSign = false;
        };
      };
    }
      {
        condition = "gitdir:~/kundendaten/";
        contents = {
          user = {
            email = "felix@codemonauts.com";
            name = "Felix Breidenstein";
          };
          commit = {
            gpgSign = false;
          };
        };
      }];
  };
}
