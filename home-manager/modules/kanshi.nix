{
  services.kanshi = {
    enable = true;
    profiles = {
      "laptop" = {
        outputs = [
	  {
	    criteria = "eDP-1";
	    scale = 1.8;
	  }
	];
      };
      "homeoffice" = {
        outputs = [
	  {
	    criteria = "eDP-1";
	    scale = 1.8;
	    position = "0,0";
	  }
	  {
	    criteria = "DP-3";
	    scale = 1.3;
	    position = "2133,0";
	  }
	  {
	    criteria = "DP-1";
	    scale = 1.3;
	    position = "5087,0";
	  }
	];
      };
    };
  };

}
