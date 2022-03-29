
import Foundation

public extension Discord {
    struct Intents: OptionSet, RawRepresentable {
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public let rawValue: Int
        
        public static var guilds = Intents(rawValue: 1 << 0)
        
        public static var guildMembers = Intents(rawValue: 1 << 1)

        public static var guildBans = Intents(rawValue: 1 << 2)

        public static var guildEmojisAndStickers = Intents(rawValue: 1 << 3)
        
        public static var guildIntegrations = Intents(rawValue: 1 << 4)
        
        public static var guildWebhooks = Intents(rawValue: 1 << 5)
        
        public static var guildInvites = Intents(rawValue: 1 << 6)
        
        public static var guildVoiceStates = Intents(rawValue: 1 << 7)

        public static var guildPresences = Intents(rawValue: 1 << 8)

        public static var guildMessages = Intents(rawValue: 1 << 9)

        public static var guildMessageReactions = Intents(rawValue: 1 << 10)

        public static var guildMessageTyping = Intents(rawValue: 1 << 11)

        public static var directMessages = Intents(rawValue: 1 << 12)

        public static var directMessageReactions = Intents(rawValue: 1 << 13)

        public static var directMessageTyping = Intents(rawValue: 1 << 14)

        public static var guildScheduledEvents = Intents(rawValue: 1 << 16)
    }
}
