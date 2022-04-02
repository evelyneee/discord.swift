
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
        static var invites = root.appendingPathComponent("invites")
        
        /// Returns the Guild Ban Endpoint for a specified user and Guild
        static func banEndpoint(guildID: String, userID: String? = nil) -> URL {
            let url = self.guilds
                .appendingPathComponent(guildID)
                .appendingPathComponent("bans")
            if let userID = userID {
                return url.appendingPathComponent(userID)
            }
            
            return url
        }
        
        /// Returns the Sticker Endpoint for a specified Guild and StickerID
        static func guildStickerEndpoint(guildID: String, stickerID: String) -> URL {
            return guilds
                .appendingPathComponent(guildID)
                .appendingPathComponent("stickers")
                .appendingPathComponent(stickerID)
        }
        
        /// Returns the Role Endpoint for a specified Guild
        /// and for a Role, if specified
        static func roleEndpoint(guildID: String, roleID: String? = nil) -> URL {
            let url = guilds
                .appendingPathComponent(guildID)
                .appendingPathComponent("roles")
            if let roleID = roleID {
                return url.appendingPathComponent(roleID)
            }
            
            return url
        }
        
        /// Returns the members endpoint for a specified User and Guld
        static func guildMembersEndpoint(guildID: String, userID: String) -> URL {
            self.guilds
                .appendingPathComponent(guildID)
                .appendingPathComponent("members")
                .appendingPathComponent(userID)
        }
    }
}
