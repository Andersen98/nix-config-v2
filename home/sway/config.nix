{lib, config}:
''
set $baseZeroZero #${lib.toLower config.colorScheme.palette.base00}
set $baseZeroOne #${lib.toLower config.colorScheme.palette.base01}
set $baseZeroTwo #${lib.toLower config.colorScheme.palette.base02}
set $baseZeroThree  #${lib.toLower config.colorScheme.palette.base03}
set $baseZeroFour #${lib.toLower config.colorScheme.palette.base04}
set $baseZeroFive  #${lib.toLower config.colorScheme.palette.base05}
set $baseZeroSix #${lib.toLower config.colorScheme.palette.base06}
set $baseZeroSeven #${lib.toLower config.colorScheme.palette.base07}
set $baseZeroEight #${lib.toLower config.colorScheme.palette.base08}
set $baseZeroNine #${lib.toLower config.colorScheme.palette.base09}
set $baseZeroA #${lib.toLower config.colorScheme.palette.base0A}
set $baseZeroB #${lib.toLower config.colorScheme.palette.base0B}
set $baseZeroC #${lib.toLower config.colorScheme.palette.base0C}
set $baseZeroD #${lib.toLower config.colorScheme.palette.base0D}
set $baseZeroE #${lib.toLower config.colorScheme.palette.base0E}
set $baseZeroF #${lib.toLower config.colorScheme.palette.base0F}

'' + (builtins.readFile ./config)
