{ ... }: {
  user.name = "luke";
  hm = { imports = [ ./home-manager/personal.nix ]; };
}
