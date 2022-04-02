import Foundation
public extension Discord {
    /// Represents a Discord Invite
    struct Invite: Decodable {
        
        /// The Unique Invite Code
        let inviteCode: String
        
        /// The User who created this invite
        let inviter: User?
        
        /// The Expiration Date of the invite, as String
        let expirationDate: String
        
        enum CodingKeys: String, CodingKey {
            case inviter
            case expirationDate = "expires_at"
            case inviteCode = "code"
        }
    }
}
