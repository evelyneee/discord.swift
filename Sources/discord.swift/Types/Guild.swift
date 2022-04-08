import Foundation

public extension Discord {
    /// Represents a Discord Guild, commonly known as a server
    struct Guild: Decodable, Equatable, Hashable, Identifiable {
        static public func == (lhs: Guild, rhs: Guild) -> Bool {
            lhs.id == rhs.id
        }

        enum CodingKeys: String, CodingKey {
            case id, name, owner, roles, channels, threads, index, mergedMember, guildPermissions, description
            case iconHash = "icon"
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
            case bannerHash = "banner"
        }
        
        public let id: String
        let name: String
        var iconHash: String?
        var owner: Bool?
        var ownerID: String?
        var roles: [Role]?
        var mfaLevel: Int?
        var isLarge: Bool?
        var isUnavailable: Bool?
        var memberCount: Int?
        var channels: [Channel]?
        var threads: [Channel]?
        let maxPresences: Int?
        let maxMembers: Int?
        var vanityURLCode: String?
        var description: String?
        var bannerHash: String?
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

public extension Discord.Guild {
    func iconPictureURL(imageFormat: Discord.CDNFormats = .png) -> URL? {
        guard let iconHash = self.iconHash else {
            return nil
        }
        
        return Discord.CDNEndpoints.icons
            .appendingPathComponent(self.id)
            .appendingPathComponent(iconHash)
            .appendingPathExtension(imageFormat.fileExtenstion)
    }
    
    func bannerImageURL(imageFormat: Discord.CDNFormats = .png) -> URL? {
        guard let bannerHash = self.bannerHash else {
            return nil
        }
        
        return Discord.CDNEndpoints.banners
            .appendingPathComponent(self.id)
            .appendingPathComponent(bannerHash)
            .appendingPathExtension(imageFormat.fileExtenstion)
    }
}
