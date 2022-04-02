public extension Discord {
    /// Represents a Discord Role returned by Discord
     struct Role: Codable, Equatable {
        public static func == (lhs: Role, rhs: Role) -> Bool {
            return lhs.id == rhs.id
        }
        
        let id: String
        let name: String
        
        /// An integer representation of the Hex Color Code
        let HexColorCode: Int
        
        /// Represents if the Role is pinned in the User Listing
        let isPinnedInListing: Bool
        
        /// The Hash of the Role Icon
        let iconHash: String?
        
        /// The Role's Unicode Emoji
        let UnicodeEmoji: String?
        
        /// Whether this role is managed with integration
        let isManaged: Bool
        
        /// Whether this role is mentionable
        let isMentionable: Bool
        
        /// The Position of this role
        let position: Int
        
        /// Permissions bit set
        let permissions: String
        
        enum CodingKeys: String, CodingKey {
            case id, name, position, permissions
            case HexColorCode = "color"
            case isPinnedInListing = "hoist"
            case iconHash = "icon"
            case UnicodeEmoji = "unicode_emoji"
            case isManaged = "managed"
            case isMentionable = "mentionable"
        }
    }
}
