{ pkgs, ... }:
{
  imports = [ ./d.nix ];



  programs.plasma = {
    enable = true;
    overrideConfig = true;
    #
    # Some high-level settings:
    #
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };
      iconTheme = "breeze";
      wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/SafeLandings/contents/images/5120x2880.jpg";
    };

    fonts = {
      general = {
        family = "JetBrains Mono";
        pointSize = 12;
      };
    };

    panels = [
      # Windows-like panel at the bottom
      {
        location = "top";
        widgets = [
          {
            kickoff = {
              sortAlphabetically = true;
              icon = "nix-snowflake-white";
            };
          }
          # Adding configuration to the widgets can also for example be used to
          # pin apps to the task-manager, which this example illustrates by
          # pinning dolphin and konsole to the task-manager by default with widget-specific options.
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:kitty.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            systemTray.items = {
              # We explicitly show bluetooth and battery
              shown = [
                "org.kde.plasma.battery"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
            };
          }
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    powerdevil = {
      AC = {
        powerButtonAction = "lockScreen";
        autoSuspend = {
          action = "shutDown";
          idleTimeout = 1000;
        };
        turnOffDisplay = {
          idleTimeout = 1000;
          idleTimeoutWhenLocked = "immediately";
        };
      };
      battery = {
        powerButtonAction = "sleep";
        whenSleepingEnter = "standbyThenHibernate";
      };
      lowBattery = {
        whenLaptopLidClosed = "hibernate";
      };
    };

    kwin = {
      scripts.polonium.enable = true;
    };

    kscreenlocker = {
      lockOnResume = true;
      timeout = 10;
    };

    # Some low-level settings:
    #
    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      kwinrc."org.kde.kdecoration2".ButtonsOnLeft = "SF";
      kwinrc.Desktops.Number = {
        value = 8;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
      };
      kscreenlockerrc = {
        Greeter.WallpaperPlugin = "org.kde.potd";
        # To use nested groups use / as a separator. In the below example,
        # Provider will be added to [Greeter][Wallpaper][org.kde.potd][General].
        "Greeter/Wallpaper/org.kde.potd/General".Provider = "bing";
      };
    };
  };
}
