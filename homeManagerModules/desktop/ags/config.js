const hyprland = await Service.import("hyprland");
const systemtray = await Service.import("systemtray");
const battery = await Service.import("battery");
const network = await Service.import("network");
const audio = await Service.import("audio");

const time = Variable("", {
  poll: [
    1000,
    () =>
      new Date().toLocaleString("en-US", {
        hour: "numeric",
        minute: "numeric",
        hour12: true,
      }),
  ],
});

const date = Variable("", {
  poll: [
    1000,
    () =>
      new Date().toLocaleDateString("en-GB", {
        day: "numeric",
        month: "long",
        year: "numeric",
      }),
  ],
});

const Workspaces = () => {
  const activeId = hyprland.active.workspace.bind("id");
  const workspaces = hyprland.bind("workspaces").as((workspace) =>
    workspace.map(({ id }) =>
      Widget.Button({
        on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`), // Switch to workspace
        child: Widget.Label(`${id}`),
        class_name: activeId.as((i) => (i === id ? "focused" : "")),
      }),
    ),
  );

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
};

const Volume = () => {
  const VolumeSlider = () => Widget.Slider({
    hexpand: true,
    drawValue: false,
    onChange: ({ value }) => audio["speaker"].volume = value,
    value: audio["speaker"].bind('volume'),
    class_name: "volume-slider"
  })
  const VolumeIndicator = () => Widget.Icon().hook(audio.speaker, self => {
    const vol = audio.speaker.volume * 100;
    const icon = [
      [101, 'overamplified'],
      [67, 'high'],
      [34, 'medium'],
      [1, 'low'],
      [0, 'muted'],
    ].find(([threshold]) => threshold <= vol)?.[1];
    self.icon = `audio-volume-${icon}-symbolic`;
    self.tooltip_text = `Volume ${Math.floor(vol)}%`;
    self.class_name = "volume"
  })
  return Widget.Box({
    children: [
      VolumeIndicator(),
      VolumeSlider()
    ],
    class_name: "stat-box",
  });
}

const Battery = () => {
  const timeRemaining = battery.bind("time-remaining").as((seconds) => {
    return `${Math.floor(seconds / 3600)}:${Math.floor((seconds % 3600) / 60)
      .toString()
      .padStart(2, "0")}`;
  });
  return Widget.Box({
    children: [
      Widget.Icon({
        icon: battery.bind("icon_name"),
        css: battery
          .bind("percent")
          .as((percent) => `color: ${percent > 15 ? "#EDF2FA" : "#E02828"};`),
      }),
      Widget.Label({
        label: battery.bind("percent").as((percent) => `${percent}%`),
        css: battery
          .bind("percent")
          .as(
            (percent) =>
              `margin-left: 3px; color: ${percent > 15 ? "#EDF2FA" : "#E02828"};`,
          ),
      }),
    ],
    visible: battery.bind("available"),
    class_name: "stat-box",
    "tooltip-text": timeRemaining,
  });
};

const Network = () => {
  return Widget.Box({
    class_name: "stat-box",
    children: network.bind("primary").as(primary => {
      if (primary === "wifi") {
        return [
          Widget.Icon({
            icon: network.wifi.bind("icon_name"),
            "tooltip-text": network.wifi.bind("ssid").as(ssid => ssid || "Unknown"),
          })
        ]
      } else {
        return [
          Widget.Icon({
            icon: network.wired.bind("icon_name")
          })
        ]
      };
    })
  })
}

const Tray = () => {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        child: Widget.Icon({ icon: item.bind("icon") }),
        on_primary_click: (_, e) => item.activate(e),
        on_secondary_click: (_, e) => item.openMenu(e),
        tooltip_markup: item.bind("tooltip_markup"),
      }),
    ),
  );

  return Widget.Box({
    children: items,
  });
};

const Clock = () => {
  return Widget.Label({
    label: time.bind(),
    class_name: "stat-box",
  });
};

const Day = () => {
  return Widget.Label({
    label: date.bind(),
    class_name: "stat-box",
  });
};

const Left = () =>
  Widget.Box({
    spacing: 8,
    children: [Workspaces()],
  });

const Center = () =>
  Widget.Box({
    spacing: 8,
    children: [Day()],
  });

const Right = () =>
  Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [Tray(), Volume(), Network(), Battery(), Clock()],
  });

const Bar = (monitor) =>
  Widget.Window({
    monitor,
    name: `bar-${monitor}`,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    layer: "top",
    class_name: "bar",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  });

App.config({
  style: "./style.css",
  windows: [Bar(0)],
});
