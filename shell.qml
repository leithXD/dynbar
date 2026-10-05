import Quickshell
import Quickshell.Wayland
import qs.Core
import qs.Services
import "modules/Bar"
import "modules/Pill"
import "modules/Wallpaper"

ShellRoot {
    Wallpaper {}
    Bar {}
    Pill {}
    IpcHandlers {}
}
