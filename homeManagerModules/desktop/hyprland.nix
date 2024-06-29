{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  options = {
    hyprland.enable = lib.mkEnableOption "hyprland (home manager)";
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        # https://wiki.hyprland.org/Configuring/Configuring-Hyprland/
        ### MONITORS
        monitor = ",preferred,auto,auto";
        ### PROGRAMS
        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$menu" = "tofi-drun --drun-launch=true";
        ### AUTOSTART
        "exec-once" = "ags & gnome-keyring-daemon -d --start --components=pkcs11,secrets,ssh";
        ### ENVIRONMENT VARIABLES
        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];
        general = {
          gaps_in = "5";
          gaps_out = "20";
          border_size = "2";
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          resize_on_border = "true";
          allow_tearing = "false";
          layout = "dwindle";
        };
        decoration = {
          rounding = "10";
          active_opacity = "1.0";
          inactive_opacity = "1.0";
          drop_shadow = "true";
          shadow_range = "4";
          shadow_render_power = "3";
          "col.shadow" = "rgba(1a1a1aee)";
          blur = {
            enabled = "true";
            size = "3";
            passes = "1";
            vibrancy = "0.1696";
          };
        };
        animations = {
          enabled = "true";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = "true";
          preserve_split = "true";
        };

        master = {
          new_status = "true";
        };
        misc = {
          force_default_wallpaper = "0";
          disable_hyprland_logo = "true";
        };
        ### INPUT
        input = {
          kb_layout = "us";
          follow_mouse = "1";
          sensitivity = "0";
        };
        gestures = {
          workspace_swipe = "false";
        };
        ### KEYBINDS
        "$mainMod" = "SUPER";
        bind = [
          "$mainMod, Q, exec, $terminal" # SUPER + Q opens the Terminal
          "$mainMod, C, killactive," # SUPER + C minimises the current window
          "$mainMod, M, exit," # SUPER + M exits Hyprland
          "$mainMod, E, exec, $fileManager" # SUPER + E opens the file manager
          "$mainMod, V, togglefloating," # SUPER + V toggles the floating
          "$mainMod, L, exec, loginctl lock-session" # SUPER + L locks the screen
          "ALT, code:65, exec, $menu" # ALT + Space opens the menu
          ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
          "$mainMod, P, pseudo, " # Dwindle
          "$mainMod, J, togglesplit, " # Dwindle

          # SUPER + Arrow Keys to move focus
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Change Workspaces
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
        ];
        # SUPER + Left or Right mouse button to move or resize a window respectively
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };

    programs.ags = {
      enable = true;
      configDir = ./ags;
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };

    programs.tofi = {
      enable = true;
      settings = {
        width = "100%";
        height = "100%";
        border-width = "0";
        outline-width = "0";
        padding-left = "40%";
        padding-top = "40%";
        result-spacing = "25";
        num-results = "4";
        font = "JetBrainsMono Nerd Font";
        background-color = "#1D2A30";
        text-cursor = "true";
      };
    };

    services.mako = {
      enable = true;

      borderRadius = 5;
      progressColor = "over #43ABF0FF";
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = false;
        splash = false;
        preload = [
          "${./wallpapers/nixos-blue.jpg}"
        ];
        wallpaper = [
          ",${./wallpapers/nixos-blue.jpg}"
        ];
      };
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        background = {
          monitor = "";
          path = "${./wallpapers/nixos-blue.jpg}";

          blur_passes = "2";
          blur_size = "8";
          noise = "0.0117";
          contrast = "0.8916";
          vibrancy = "0.1696";
          vibrancy_darkness = "0.0";
        };
        "input-field" = {
          monitor = "";
          size = "300, 60";
          outline_thickness = "2";
          dots_size = "0.33";
          dots_spacing = "0.15";
          dots_center = false;
          dots_rounding = "-1";
          outer_color = "rgb(15, 15, 15)";
          inner_color = "rgb(200, 200, 200)";
          font_color = "rgb(10, 10, 10)";
          fade_on_empty = false;
          fade_timeout = "1000";
          placeholder_text = "<i>Input Password...</i>";
          hide_input = false;
          rounding = "-1";
          check_color = "rgb(204, 136, 35)";
          fail_color = "rgb(204, 34, 34)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_transition = "200";
          capslock_color = "-1";
          numlock_color = "-1";
          bothlock_color = "-1";
          invert_numlock = false;
          swap_font_color = false;

          position = "0, 0";
          halign = "center";
          valign = "center";
        };
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          ignore_dbus_inhibit = false;
          ignore_systemd_inhibit = false;
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on && hyprctl dispatch exec -- ags -q && sleep 1 && hyprctl dispatch exec -- ags";
        };
        listener = [
          {
            timeout = "60";
            "on-timeout" = "brightnessctl -s set 20";
            "on-resume" = "brightnessctl -r";
          }
          {
            timeout = "120";
            "on-timeout" = "loginctl lock-session";
          }
          {
            timeout = "150";
            "on-timeout" = "hyprctl dispatch dpms off";
            "on-resume" = "hyprctl dispatch dpms on && hyprctl dispatch exec -- ags -q && sleep 1 && hyprctl dispatch exec -- ags";
          }
          {
            timeout = "300";
            "on-timeout" = "systemctl suspend";
          }
        ];
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3";
      };

      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };

    qt = {
      enable = true;
      platformTheme = "adwaita";
      style = {
        name = "adwaita";
      };
    };

    wayland.windowManager.hyprland.systemd.variables = ["--all"];

    home.packages = with pkgs; [xfce.thunar gnome.seahorse libsecret grim slurp wl-clipboard libnotify brightnessctl kdePackages.ark];
  };
}
