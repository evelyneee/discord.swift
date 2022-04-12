
import Foundation

public enum Discord {
    /// The formats allowed to be used when requesting an item from Discord's CDN
    public enum CDNFormats {
        case jpeg, jpg
        case png
        case webp
        case gif
        case lottie
        
        public var fileExtenstion: String {
            switch self {
            case .jpeg:
                return "jpeg"
            case .jpg:
                return "jpg"
            case .png:
                return "png"
            case .webp:
                return "webp"
            case .gif:
                return "gif"
            case .lottie:
                return "json"
            }
        }
    }
    
    public enum APIEndpoints {
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
        
        /// Returns the Emotes Endpoint for a specified Guild
        /// and for a Emote ID, if specified
        static func guildEmotesEndpoint(guildID: String, emoteID: String? = nil) -> URL {
            let url = self.guilds
                .appendingPathComponent(guildID)
                .appendingPathComponent("emojis")
            if let emoteID = emoteID {
                return url.appendingPathComponent(emoteID)
            }
            
            return url
        }
        
        /// Returns the Sticker Endpoint for a specified Guild
        /// and for a Sticker ID, if specified
        static func guildStickerEndpoint(guildID: String, stickerID: String? = nil) -> URL {
            let url = guilds
                .appendingPathComponent(guildID)
                .appendingPathComponent("stickers")
            
            if let stickerID = stickerID {
                return url.appendingPathComponent(stickerID)
            }
            
            return url
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
        
        /// Returns the members endpoint for a Guld and a member, if specified
        static func guildMembersEndpoint(guildID: String, userID: String?) -> URL {
            let url = self.guilds
                .appendingPathComponent(guildID)
                .appendingPathComponent("members")
            if let userID = userID {
                return url.appendingPathComponent(userID)
            }
            return url
        }
        
        /// Returns the Pinned Messages Endpoint for a specified Channel
        /// and a Message, if specified
        static func channelPinsEndpoint(channelID: String, messageID: String? = nil) -> URL {
            let url = self.channels
                .appendingPathComponent(channelID)
                .appendingPathComponent("pins")
            
            if let messageID = messageID {
                return url.appendingPathComponent(messageID)
            }
            
            return url
        }
        
        /// Returns the Bulk-Delete Endpoint for a specified channel
        static func bunkDeleteEndpoint(channelID: String) -> URL {
            return channels
                .appendingPathComponent(channelID)
                .appendingPathComponent("messages")
                .appendingPathComponent("bulk-delete")
        }
        
        /// Returns the Threads Endpoint for a Channel, and a message if specified
        static func threadsEndpoint(channelID: String, messageID: String?) -> URL {
            let url = channels.appendingPathComponent(channelID)
            if let messageID = messageID {
                return url
                    .appendingPathComponent("messages")
                    .appendingPathComponent(messageID)
                    .appendingPathComponent("threads")
            }
            
            return url.appendingPathComponent("threads")
        }
        
        /// Returns the Endpoint for Thread Members for a specified threadID, and a user if specified
        static func threadMembersEndpoint(threadID: String, userID: String?) -> URL {
            let url = channels
                .appendingPathComponent(threadID)
                .appendingPathComponent("thread-members")
            if let userID = userID {
                return url.appendingPathComponent(userID)
            }
            
            return url
        }
    }
}

public extension Discord {
    /// Represents the Endpoints for Discord's CDN
    enum CDNEndpoints {
        static var base = URL(string: "https://cdn.discordapp.com/")!
        static var icons = base.appendingPathComponent("icons")
        static var banners = base.appendingPathComponent("banners")
        static var avatars = base.appendingPathComponent("avatars")
    }
}
