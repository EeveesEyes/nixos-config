{ nixosConfig
, ...
}:
let
  fontSize = hiDPI: if hiDPI then "FiraCode:size=14" else "FiraCode:size=8";
in
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = fontSize nixosConfig.my.highDPI;
        pad = "3x3";
      };
      scrollback = { lines = 100000; };
      colors = {
        alpha = "0.98";
        foreground = "B3B1AD";
        background = "0A0E14";
        regular0 = "01060E";
        regular1 = "EA6C73";
        regular2 = "91B362";
        regular3 = "F9AF4F";
        regular4 = "53BDFA";
        regular5 = "FAE994";
        regular6 = "90E1C6";
        regular7 = "C7C7C7";
        bright0 = "686868";
        bright1 = "F07178";
        bright2 = "C2D94C";
        bright3 = "FFB454";
        bright4 = "59C2FF";
        bright5 = "FFEE99";
        bright6 = "95E6CB";
        bright7 = "FFFFFF";
      };
    };
  };

}
