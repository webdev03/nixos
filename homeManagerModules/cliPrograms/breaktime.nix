{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cliPrograms.breaktime.enable = lib.mkEnableOption "breaktime";
  };

  config = lib.mkIf config.cliPrograms.breaktime.enable {
    systemd.user.services.breaktime = {
      Install = {WantedBy = ["graphical-session.target"];};

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "breaktime";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${
          lib.getExe
          (pkgs.writers.writePython3Bin "breaktime" {
              flakeIgnore = ["E265" "E255" "E111" "E302" "E305" "E501"];
            } ''
              from time import sleep
              import subprocess
              import threading

              global breaks
              breaks = 0

              def send_notification(message):
                subprocess.Popen(['${pkgs.libnotify}/bin/notify-send', message])
                return

              def short_break(waiting_seconds=1800, break_seconds=20):
                global breaks
                while True:
                  sleep(waiting_seconds)
                  if breaks == 0:
                    send_notification("Take a break!")
                    breaks += 1
                    sleep(break_seconds)
                    breaks += -1
                    send_notification("You can come back now!")

              def long_break(waiting_seconds=7198, break_seconds=1800):
                global breaks
                while True:
                  sleep(waiting_seconds)
                  send_notification("Time to take a long break!")
                  breaks += 1
                  sleep(break_seconds)
                  breaks += -1
                  send_notification("You can come back now!")
                  sleep(2)

              def main():
                t1 = threading.Thread(target=short_break)
                t2 = threading.Thread(target=long_break)
                t1.start()
                t2.start()
                t1.join()
                t2.join()

              if __name__ == "__main__":
                main()
            '')
        }";
        Restart = "always";
        RestartSec = "10";
      };
    };
  };
}
