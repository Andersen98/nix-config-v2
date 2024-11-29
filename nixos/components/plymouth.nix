{ pkgs, ...}: 

{

  boot.plymouth.enable = true;
  boot.plymouth.themePackages = [ pkgs.plymouth-theme-jar-jar ];
  boot.plymouth.theme = "jar-jar";
  environment.systemPackages = with pkgs; [ plymouth-theme-jar-jar ];
}
