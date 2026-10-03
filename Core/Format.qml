pragma Singleton
import Quickshell
import QtQuick

Singleton {
    // ai boilerplatte slop idk
    function escapeRegex(s) {
        return s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")
    }

    function cleanTitle(raw, artist) {
        let s = raw ?? ""

        let prev
        do {
            prev = s
            s = s.replace(/\s*\([^()]*\)/g, "")
        } while (s !== prev)

        const junk = "official|video|music video|lyrics?|lyric video|audio|visuali[sz]er|hd|hq|4k|1080p|remaster(ed)?|explicit|mv|offizielles?"
        const brackets = new RegExp("\\s*[\\(\\[\\{][^\\)\\]\\}]*\\b(" + junk + ")\\b[^\\)\\]\\}]*[\\)\\]\\}]", "gi")
        s = s.replace(brackets, "")

        s = s.replace(/\s*\|.*$/, "")

        if (artist) {
            const a = artist.replace(/\s*-\s*Topic$/i, "").trim()
            if (a.length > 0)
                s = s.replace(new RegExp("^" + escapeRegex(a) + "\\s*[-–—:]\\s*", "i"), "")
        }

        return s.replace(/\s{2,}/g, " ").trim()
    }
}
