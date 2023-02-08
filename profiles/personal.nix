{ ... }: {
  user.name = "luke";
  hm = { ... }: {
    programs.git = {
      userEmail = "461449+LukeChannings@users.noreply.github.com";
      userName = "Luke Channings";
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPX9kngC2bk5jm4GnyEDymeP8X7mJpcufg4jnu6uC6Kh";
        signByDefault = true;
      };
    };
  };
}
