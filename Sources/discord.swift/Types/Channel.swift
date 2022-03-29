
import Foundation

extension Discord {
    public struct Channel: Decodable, Identifiable {
        public enum CodingKeys: String, CodingKey {
            case id, type, position, name, topic, recipients, icon
            case guildID = "guild_id"
            case guildIconURL = "guild_icon"
            case PermissionOverwrites = "permission_overwrites"
            case isNSFW = "nsfw"
            case lastMessageID = "last_message_id"
            case recipientsID = "recipient_ids"
            case ownerID = "owner_id"
            case parentID = "parent_id"
            case guildName = "guild_name"
            case isShown = "shown"
        }
        
        public let id: String
        let type: ChannelType
        var guildID: String?
        var guildIconURL: String?
        let position: Int?
        var PermissionOverwrites: [PermissionOverwrites]?
        var name: String?
        var topic: String?
        var isNSFW: Bool?
        var lastMessageID: String?
        var recipients: [User]?
        var recipientsID: [String]?
        var icon: String?
        var ownerID: String?
        let parentID: String?
        var permissions: Int64?
        var guildName: String?
        var threads: [Channel]?
        var isShown: Bool?
        
        
        struct PermissionOverwrites: Decodable {
            var allow: String?
            var deny: String?
            var id: String?
            var type: Int?
        }
    }

    enum ChannelType: Int, Codable {
        case normal = 0
        case dm = 1
        case voice = 2
        case group_dm = 3
        case section = 4
        case guild_news = 5
        case guild_store = 6
        case unknown1 = 7
        case unknown2 = 8
        case unknown3 = 9
        case guild_news_thread = 10
        case guild_public_thread = 11
        case guild_private_thread = 12
        case stage = 13
        case unknown4 = 14
        case unknown5 = 15
    }
}
