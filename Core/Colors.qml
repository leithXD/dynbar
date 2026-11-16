import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    readonly property color surfaceColor: surface(md3.surface)
    property alias md3: jsonAdapter.md3
    property alias base16: jsonAdapter.base16
    property alias palette: jsonAdapter.palette

    function transparency(hexColor, alpha) {
        const c = Qt.color(hexColor);
        return Qt.rgba(c.r, c.g, c.b, alpha);
    }

    function surface(color) {
        return transparency(color, Config.appearance.transparency ? Config.appearance.surfaceOpacity : 1);
    }

    function layer(color, level) {
        if (!Config.appearance.transparency)
            return transparency(color, 1);

        if (level === 1)
            return transparency(color, Config.appearance.layerOpacity);
        else if (level === 2)
            return transparency(color, Config.appearance.layerOpacity * 2);
        else
            return transparency(color, 1);
    }

    FileView {
        path: Quickshell.env("HOME") + "/.local/state/dynbar/colors.json"
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            id: jsonAdapter

            readonly property Md3
            md3: Md3 {
            }

            readonly property Base16
            base16: Base16 {
            }

            readonly property Palette
            palette: Palette {
            }

        }

    }

    component Md3: JsonObject {
        property string background: "#141318"
        property string error: "#ffb4ab"
        property string error_container: "#93000a"
        property string inverse_on_surface: "#312f35"
        property string inverse_primary: "#63568f"
        property string inverse_surface: "#e6e1e9"
        property string on_background: "#e6e1e9"
        property string on_error: "#690005"
        property string on_error_container: "#ffdad6"
        property string on_primary: "#34275e"
        property string on_primary_container: "#e8deff"
        property string on_primary_fixed: "#1f1048"
        property string on_primary_fixed_variant: "#4b3e76"
        property string on_secondary: "#322e41"
        property string on_secondary_container: "#e7def8"
        property string on_secondary_fixed: "#1d192b"
        property string on_secondary_fixed_variant: "#494458"
        property string on_surface: "#e6e1e9"
        property string on_surface_variant: "#cac4cf"
        property string on_tertiary: "#492533"
        property string on_tertiary_container: "#ffd9e4"
        property string on_tertiary_fixed: "#31111e"
        property string on_tertiary_fixed_variant: "#633b4a"
        property string outline: "#938f99"
        property string outline_variant: "#48454e"
        property string primary: "#cdbdff"
        property string primary_container: "#4b3e76"
        property string primary_fixed: "#e8deff"
        property string primary_fixed_dim: "#cdbdff"
        property string scrim: "#000000"
        property string secondary: "#cbc3dc"
        property string secondary_container: "#494458"
        property string secondary_fixed: "#e7def8"
        property string secondary_fixed_dim: "#cbc3dc"
        property string shadow: "#000000"
        property string source_color: "#2a243e"
        property string surface: "#141318"
        property string surface_bright: "#3a383e"
        property string surface_container: "#201f24"
        property string surface_container_high: "#2b292f"
        property string surface_container_highest: "#36343a"
        property string surface_container_low: "#1c1b20"
        property string surface_container_lowest: "#0f0d13"
        property string surface_dim: "#141318"
        property string surface_tint: "#cdbdff"
        property string surface_variant: "#48454e"
        property string tertiary: "#eeb8ca"
        property string tertiary_container: "#633b4a"
        property string tertiary_fixed: "#ffd9e4"
        property string tertiary_fixed_dim: "#eeb8ca"
    }

    component Palette: JsonObject {
        property string error0: "#000000"
        property string error5: "#2d0001"
        property string error10: "#410002"
        property string error15: "#540003"
        property string error20: "#690005"
        property string error25: "#7e0007"
        property string error30: "#93000a"
        property string error35: "#a80710"
        property string error40: "#ba1a1a"
        property string error50: "#de3730"
        property string error60: "#ff5449"
        property string error70: "#ff897d"
        property string error80: "#ffb4ab"
        property string error90: "#ffdad6"
        property string error95: "#ffedea"
        property string error98: "#fff8f7"
        property string error99: "#fffbff"
        property string error100: "#ffffff"
        property string neutral0: "#000000"
        property string neutral5: "#111014"
        property string neutral10: "#1c1b1e"
        property string neutral15: "#272529"
        property string neutral20: "#313033"
        property string neutral25: "#3d3b3e"
        property string neutral30: "#48464a"
        property string neutral35: "#545156"
        property string neutral40: "#605d62"
        property string neutral50: "#79767a"
        property string neutral60: "#938f94"
        property string neutral70: "#aeaaaf"
        property string neutral80: "#c9c5ca"
        property string neutral90: "#e6e1e6"
        property string neutral95: "#f4eff4"
        property string neutral98: "#fdf8fd"
        property string neutral99: "#fffbff"
        property string neutral100: "#ffffff"
        property string neutral_variant0: "#000000"
        property string neutral_variant5: "#121017"
        property string neutral_variant10: "#1d1a22"
        property string neutral_variant15: "#27252d"
        property string neutral_variant20: "#322f38"
        property string neutral_variant25: "#3d3a43"
        property string neutral_variant30: "#48454e"
        property string neutral_variant35: "#54515a"
        property string neutral_variant40: "#605d66"
        property string neutral_variant50: "#79757f"
        property string neutral_variant60: "#938f99"
        property string neutral_variant70: "#aea9b4"
        property string neutral_variant80: "#cac4cf"
        property string neutral_variant90: "#e6e0ec"
        property string neutral_variant95: "#f5eefa"
        property string neutral_variant98: "#fdf7ff"
        property string neutral_variant99: "#fffbff"
        property string neutral_variant100: "#ffffff"
        property string primary0: "#000000"
        property string primary5: "#140043"
        property string primary10: "#20005f"
        property string primary15: "#2a1169"
        property string primary20: "#351f73"
        property string primary25: "#412c7f"
        property string primary30: "#4c388b"
        property string primary35: "#584498"
        property string primary40: "#6450a5"
        property string primary50: "#7d6ac0"
        property string primary60: "#9883dc"
        property string primary70: "#b39ef9"
        property string primary80: "#cdbdff"
        property string primary90: "#e8deff"
        property string primary95: "#f5eeff"
        property string primary98: "#fdf7ff"
        property string primary99: "#fffbff"
        property string primary100: "#ffffff"
        property string secondary0: "#000000"
        property string secondary5: "#120e20"
        property string secondary10: "#1d192b"
        property string secondary15: "#272336"
        property string secondary20: "#322e41"
        property string secondary25: "#3d394c"
        property string secondary30: "#494458"
        property string secondary35: "#554f64"
        property string secondary40: "#615b71"
        property string secondary50: "#7a748a"
        property string secondary60: "#948da5"
        property string secondary70: "#afa8c0"
        property string secondary80: "#cbc3dc"
        property string secondary90: "#e7def8"
        property string secondary95: "#f5eeff"
        property string secondary98: "#fdf7ff"
        property string secondary99: "#fffbff"
        property string secondary100: "#ffffff"
        property string tertiary0: "#000000"
        property string tertiary5: "#240613"
        property string tertiary10: "#31111e"
        property string tertiary15: "#3d1b28"
        property string tertiary20: "#492533"
        property string tertiary25: "#56303e"
        property string tertiary30: "#633b4a"
        property string tertiary35: "#704655"
        property string tertiary40: "#7d5261"
        property string tertiary50: "#986a7a"
        property string tertiary60: "#b48394"
        property string tertiary70: "#d19dae"
        property string tertiary80: "#eeb8ca"
        property string tertiary90: "#ffd9e4"
        property string tertiary95: "#ffecf0"
        property string tertiary98: "#fff8f8"
        property string tertiary99: "#fffbff"
        property string tertiary100: "#ffffff"
    }

    component Base16: JsonObject {
        property string base00: "#12101d"
        property string base01: "#282131"
        property string base02: "#3e3346"
        property string base03: "#53445a"
        property string base04: "#69566f"
        property string base05: "#7e6783"
        property string base06: "#947998"
        property string base07: "#a98aac"
        property string base08: "#120f1c"
        property string base09: "#201a31"
        property string base0a: "#341b28"
        property string base0b: "#32354c"
        property string base0c: "#4f3047"
        property string base0d: "#442536"
        property string base0e: "#282343"
        property string base0f: "#a98aac"
    }

}
