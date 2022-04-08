import Foundation
public extension Discord {
    /// Represents a Discord Invite
    struct Invite: Decodable {
        
        /// The Unique Invite Code
        let inviteCode: String
        
        /// The User who created this invite
        let inviter: User?
        
        /// The Guild to which this invite belongs to
        let guild: Guild?
        
        /// The Channel to which this invite belongs to
        let channel: Channel?
        
        /// The Expiration Date of the invite, as String
        let expirationDate: Date
        
        /// Approximate number of total members
        let approxPresenceCount: Int?
        
        /// Approximate number of online members
        let approxOnlineCount: Int?
        
        //MARK: - Invite metadata
        
        /// The amount of times this invite has been used
        let usesCount: Int?
        
        /// The max number of times this Invite can be used
        let maxUsesAllowed: Int?
        
        /// Whether this invite only includes Temporary Membership
        let grantsTemporaryMembership: Bool?
        
        /// The Creation Date of this invite
        let createdAt: Date?
        
        enum CodingKeys: String, CodingKey {
            case inviter, guild, channel
            case expirationDate = "expires_at"
            case inviteCode = "code"
            case approxPresenceCount = "approximate_presence_count"
            case approxOnlineCount = "approximate_member_count"
            case usesCount = "uses"
            case maxUsesAllowed = "max_uses"
            case grantsTemporaryMembership = "temporary"
            case createdAt = "created_at"
        }
    }
}
