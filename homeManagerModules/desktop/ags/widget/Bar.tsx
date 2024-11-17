import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable } from "astal"

const getTime = () => new Date().toLocaleString("en-US", {
    hour: "numeric",
    minute: "numeric",
    hour12: true,
});
const time = Variable(getTime());
setInterval(() => time.set(getTime()), 1000);

function Network() {
    
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return <window
        className="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.LEFT
            | Astal.WindowAnchor.RIGHT}
        application={App}>
        <centerbox>
            <button
                onClicked="echo hello"
                halign={Gtk.Align.CENTER} >
                Welcome to AGS!
            </button>
            <box />
            <button
                onClick={() => print("hello")}
                halign={Gtk.Align.CENTER} >
                <label label={time()} />
            </button>
        </centerbox>
    </window>
}
