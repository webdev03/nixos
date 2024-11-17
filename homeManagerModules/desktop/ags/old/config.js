import { App } from "astal/gtk3";
import { Bar } from "./bar.js";

App.start({
  style: "./style.css",
  windows: [Bar(0)],
});
