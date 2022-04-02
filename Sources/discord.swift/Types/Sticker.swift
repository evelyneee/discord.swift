public extension Discord {
    /// Represents a Discord Sticker
    struct Sticker: Decodable {
        /// The Sticker ID
        let id: String
        
        /// The name of the Sticker
        let name: String
        
        /// The description of the sticker
        let description: String?
        
        /// The Type of the Sticker
        let type: StickerType
        
        /// The tags associated with the Sticker
        let tags: String
        
        /// The Format Type of the Sticker
        let formatType: StickerFormatType
        
        /// Whether or not the Sticker is available to use
        let isAvailable: Bool?
        
        /// ID of the Guild owning the sticker
        let guildID: String?
        
        /// The User who uploaded the Sticker
        let user: User?
        
        // The standard Sticker's sort order within its pack
        let sortValue: Int?
        
        enum CodingKeys: String, CodingKey {
            case id, name, description, type, user, tags
            case formatType = "format_type"
            case isAvailable = "available"
            case guildID = "guild_id"
            case sortValue = "sort_value"
        }
    }
    
    enum StickerType: Int, Decodable {
        case Standard = 1
        case Guild = 2
    }
    
    enum StickerFormatType: Int, Decodable {
        case Png = 1
        case APng = 2
        case Lottie = 3
    }
}

