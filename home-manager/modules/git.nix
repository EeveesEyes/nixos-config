{
  programs.git = {
    enable = true;
    ignores = [ ".vscode" ];
    userName = "fleaz";
    userEmail = "mail@felixbreidenstein.de";
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
      };
    }
      {
        condition = "gitdir:~/kundendaten/";
        contents = {
          user = {
            email = "felix@codemonauts.com";
            name = "Felix Breidenstein";
          };
        };
      }];
  };
}
