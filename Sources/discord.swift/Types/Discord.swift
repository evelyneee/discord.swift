
import Foundation

public enum Discord {
    public enum Endpoints {
        static private var base = "https://discord.com/api/"
        static private var version = "v10"
        static var root = URL(string: base + version)!
        static var me = root.appendingPathComponent("/@me")
        static var gateway = URL(string: "wss://gateway.discord.gg")!
        static var myGuilds = me.appendingPathComponent("guilds")
        static var myChannels = me.appendingPathComponent("channels")
        static var guilds = root.appendingPathComponent("guilds")
        static var channels = root.appendingPathComponent("channels")
        static var users = root.appendingPathComponent("users")
    }
}
