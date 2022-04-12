import Foundation

public extension Discord {
    /// Represents a Discord Guild member
    struct GuildMember: Codable {
        
        /// A `Discord.User` instance of the Member
        let user: User?
        
        /// The user's nickname in the Guild, if used
        let nickname: String?
        
        /// The Hash of the User's Guild Avatar, if the user applies one
        let guildAvatarHash: String?
        
        /// An array of Role IDs of the roles possesed by the user
        let roles: [String]
        
        /// The date when the user joined the Guild
        let joinDate: Date?
        
        /// The date when the user started Boosting the server, if the user did so at all
        let userBoostedServerDate: Date?
        
        /// Whether the user is defeaned in Voice Channels
        let isDefeanedInVoiceChannels: Bool
        
        /// Whether the user is muted in Voice Channels
        let isMutedInVoiceChannels: Bool
        
        /// Whether the user didn't pass the Guild Membership Screening.
        let stillPending: Bool?
        
        /// Permissions owned by the user
        let permissions: String?
        
        /// The date when the user's timeout will end
        let timeoutExpirationDate: Date?
        
        enum CodingKeys: String, CodingKey {
            case user, roles, permissions
            case nickname = "nick"
            case guildAvatarHash = "avatar"
            case joinDate = "join_date"
            case userBoostedServerDate = "premium_since"
            case isDefeanedInVoiceChannels = "deaf"
            case isMutedInVoiceChannels = "mute"
            case stillPending = "pending"
            case timeoutExpirationDate = "communication_disabled_until"
        }
    }
}
