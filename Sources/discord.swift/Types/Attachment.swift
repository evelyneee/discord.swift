import Foundation

public extension Discord {
    /// Represents a Discord Attachment
    struct Attachment: Codable {
        /// Attachment of the ID
        let id: String
        
        /// Filename of the attachment
        let filename: String
        
        /// Desrciption of the file
        let description: String?
        
        /// The attachment's content type
        let contentType: String?
        
        /// Size of the attachment
        let size: Int
        
        /// Source URL of the file
        let url: String
        
        /// Proxied URL of the file
        let proxyURL: String
        
        /// The Height of the Attachment (if it's an image)
        let height: Int?
        
        /// The Width of the Attachment (if it's an image)
        let width: Int?
        
        /// Whether this attachment is ephemeral
        let isEphemeral: Bool?
        
        enum CodingKeys: String, CodingKey {
            case id, filename, description, size, url, height, width
            case contentType = "content_type"
            case proxyURL = "proxy_url"
            case isEphemeral = "ephemeral"
        }
    }
}
