
public extension Discord {
    
    /// Represent's a Discord Embed
    struct Embed: Decodable {
        let title: String?
        let type: EmbedType
        let description: String?
        let url: String?
        let color: Int
        let footer: EmbedFooter?
        let image: EmbedMedia?
        let thumbnail: EmbedMedia?
        let video: EmbedMedia?
        let provider: EmbedProvider?
        let author: EmbedAuthor?
        let fields: [EmbedField]?
    }
    
    enum EmbedType: String, Decodable {
        case rich, image, video, gifv, article, link
    }
    
    struct EmbedFooter: Decodable {
        let text: String
        let iconURL: String?
        let proxyIconURL: String?
        
        enum CodingKeys: String, CodingKey {
            case text
            case iconURL = "icon_url"
            case proxyIconURL = "proxy_icon_url"
        }
    }
    
    struct EmbedMedia: Decodable {
        /// The URL of the media
        let url: String
        
        /// The Proxy URL for the media
        let proxyURL: String?
        
        /// The Height of the media, if available
        let height: Int?
        
        /// The Width of the media, if available
        let width: Int?
        
        enum CodingKeys: String, CodingKey {
            case url, height, width
            case proxyURL = "proxy_url"
        }
    }
    
    struct EmbedProvider: Decodable {
        /// The name of the Provider
        let name: String?
        /// The URL of the Provider
        let url: String?
    }
    
    struct EmbedAuthor: Decodable {
        /// The name of the author
        let name: String
        
        /// The URL of the author, if available
        let url: String?
        
        /// The icon URL of the author, if available
        let iconURL: String?
        
        /// A Proxied URL of the author's URL
        let proxyIconURL: String?
        
        enum CodingKeys: String, CodingKey {
            case name, url
            case iconURL = "icon_url"
            case proxyIconURL = "proxy_icon_url"
        }
    }
    
    struct EmbedField: Decodable {
        /// The name of the Embed Field
        let name: String
        
        /// The value of this field
        let value: String
        
        let displaysInline: Bool?
        
        enum CodingKeys: String, CodingKey {
            case name, value
            case displaysInline = "inline"
        }
    }
}
