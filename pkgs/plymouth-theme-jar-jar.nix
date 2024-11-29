
{
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "plymouth-theme-jar-jar";
  version = "v1.0";

  src = fetchFromGitHub { 
    owner = "Andersen98";
    repo = "plymouth-theme-jar-jar";
    rev = "v1.0";
    hash = "sha256-eP0SGzpMrX5YR69uEMz8iSSYKrlUoU9EfF3pabaOjpE=";
  };

  installPhase = ''
    mkdir -p $out/share/plymouth/themes
    mv jar-jar $out/share/plymouth/themes/jar-jar
    sed -i "s@\/usr\/@$out\/@" $out/share/plymouth/themes/jar-jar/jar-jar.plymouth
  '';
}
