{...}: {
  system.defaults = {

    # login window settings
    # https://github.com/LnL7/nix-darwin/blob/3db1d870b04b13411f56ab1a50cd32b001f56433/modules/system/defaults/loginwindow.nix
    loginwindow = {
      # disable guest account
      GuestEnabled = false;
      # show name instead of username
      SHOWFULLNAME = true;
    };

    # file viewer settings
    # https://github.com/LnL7/nix-darwin/blob/3db1d870b04b13411f56ab1a50cd32b001f56433/modules/system/defaults/finder.nix
    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";
      FXDefaultSearchScope = "SCcf";
      _FXShowPosixPathInTitle = true;
    };

    # trackpad settings
    trackpad = {
      # silent clicking = 0, default = 1
      ActuationStrength = 0;
      # enable tap to click
      Clicking = true;
      # firmness level, 0 = lightest, 2 = heaviest
      FirstClickThreshold = 1;
      # firmness level for force touch
      SecondClickThreshold = 1;
      # don't allow positional right click
      TrackpadRightClick = true;
      # three finger drag for space switching
      TrackpadThreeFingerDrag = true;
    };

    # dock settings
    dock = {
      # auto show and hide dock
      autohide = true;
      # remove delay for showing dock
      autohide-delay = 0.0;
      # how fast is the dock showing animation
      autohide-time-modifier = 1.0;
      tilesize = 50;
      static-only = false;
      showhidden = false;
      show-recents = false;
      show-process-indicators = true;
      orientation = "bottom";
      mru-spaces = false;
    };

    # https://github.com/LnL7/nix-darwin/blob/3db1d870b04b13411f56ab1a50cd32b001f56433/modules/system/defaults/NSGlobalDomain.nix
    NSGlobalDomain = {
      "com.apple.sound.beep.feedback" = 0;
      "com.apple.sound.beep.volume" = 0.0;
      # allow key repeat
      ApplePressAndHoldEnabled = false;
      # delay before repeating keystrokes
      InitialKeyRepeat = 10;
      # delay between repeated keystrokes upon holding a key
      KeyRepeat = 1;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "Automatic";
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleKeyboardUIMode = 3;

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;

      NSTableViewDefaultSizeMode = 1;
      NSWindowResizeTime = 0.1;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
  };
}
