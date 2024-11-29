{pkgs, ...} :

{
  environment.systemPackages = with pkgs; [ pavucontrol plasma-pa ];
}
