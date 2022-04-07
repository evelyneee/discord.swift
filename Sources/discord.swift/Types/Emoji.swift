
public extension Discord {
    struct Emote: Decodable {
        /// The ID of the Emote
        let id: String?
        
        /// The name of the Emote,
        /// will be nil only in the context of Reactions
        let name: String?
        
        /// Roles allowed to use this Emote.
        let allowedRoles: [Role]?
        
        /// The user who created this Emote.
        let creator: User?
        
        /// Whether this Emote must be wrapped in colons
        let colonsRequired: Bool?
        
        /// Whether this Emote is managed
        let isManaged: Bool?
        
        /// Whether this Emote is animated
        let isAnimated: Bool?
        
        /// Whether this Emote is available
        let isAvailable: Bool?
        
        enum CodingKeys: String, CodingKey {
            case id, name
            case allowedRoles = "roles"
            case creator = "user"
            case colonsRequired = "require_colons"
            case isManaged = "managed"
            case isAnimated = "animated"
            case isAvailable = "available"
        }
    }
}
