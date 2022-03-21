
import Foundation

public enum Discord {
    public enum Endpoints {
        static private var base = "https://discord.com/api/"
        static private var version = "v10"
        static var root = URL(string: base + version)!
        static var gateway = URL(string: "wss://gateway.discord.gg")!
        static var guilds = root.appendingPathComponent("/@me/guilds")
        static var channels = root.appendingPathComponent("/@me/channels")
    }
}
