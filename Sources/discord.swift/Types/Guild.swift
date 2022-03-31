import Foundation

public extension Discord {
    struct Guild: Decodable, Equatable, Hashable, Identifiable {
        static public func == (lhs: Guild, rhs: Guild) -> Bool {
            lhs.id == rhs.id
        }

        enum CodingKeys: String, CodingKey {
            case id, name, owner, roles, channels, threads, banner, index, mergedMember, guildPermissions, description
            case iconURL = "icon"
            case iconHash = "icon_hash"
            case ownerID = "owner_id"
            case mfaLevel = "mfa_level"
            case isLarge = "large"
            case isUnavailable = "unavailable"
            case memberCount = "member_count"
            case maxPresences = "max_presences"
            case maxMembers = "max_members"
            case vanityURLCode = "vanity_url_code"
            case premiumTier = "premium_tier"
            case premSubCount = "premium_subscription_count"
            case approxMemberCount = "approximate_member_count"
            case approxPresenceCount = "approximate_presence_count"
            case NSFWLevel = "nsfw_level"
        }
        
        public let id: String
        let name: String
        var iconURL: String?
        var iconHash: String?
        var owner: Bool?
        var ownerID: String
        var roles: [Role]?
        var mfaLevel: Int
        var isLarge: Bool?
        var isUnavailable: Bool?
        var memberCount: Int?
        var channels: [Channel]?
        var threads: [Channel]?
        let maxPresences: Int?
        let maxMembers: Int?
        var vanityURLCode: String?
        var description: String?
        var banner: String?
        var premiumTier: Int?
        var premSubCount: Int?
        var approxMemberCount: Int?
        var approxPresenceCount: Int?
        var NSFWLevel: Int
        
        var index: Int?
        var mergedMember: MergedMember?
        var guildPermissions: String?
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        struct MergedMember: Decodable {
            var hoisted_role: String?
            var nick: String?
        }
    }
}
