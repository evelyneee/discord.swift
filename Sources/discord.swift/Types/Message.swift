public extension Discord {
    /// Represents a Message sent in a Discord Channel
    struct Message: Decodable {
        /// The Message ID
        let id: String?
        
        /// The ID of the Channel where the message was sent in
        let channelID: String
        
        /// The ID of the Guild where the message was sent in
        let guildID: String?
        
        /// The author of the message
        let author: User?
        
        /// The Contents of the message, in String
        let content: String?
        
        /// The time this message was sent, in String
        let timestamp: String
        
        /// The time this message was edited (if it was, at all)
        let editedTimestamp: String?
        
        /// Whether this message was a TTS Message
        let isTTSMessage: Bool
        
        /// Whether this message mentions everyone
        let messageMentionsEveryone: Bool
        
        /// The Roles mentioned in the message
        let mentionedRoles: [Role]
        
        /// The users mentioned in the message
        let mentionedUsers: [User]
        
        /// The Channels mentioned in the message
        let mentionedChannels: [ChannelMention]?
        
        /// The attachments in the message
        let attachments: [Attachment]
        
        /// The Message type
        let type: MessageType
        
        /// Whether this message is pinned
        let isPinned: Bool
        
        /// The Embeds in the message
        let embeds: [Embed]
        
        /// The Activity in the Message, if one is present
        let activity: MessageActivity?
        
        //TODO: - the rest of the variables, see https://discord.com/developers/docs/resources/channel#message-object
        enum CodingKeys: String, CodingKey {
            case id, author, content, timestamp, attachments, type, embeds, activity
            case channelID = "channel_id"
            case guildID = "guild_id"
            case editedTimestamp = "edited_timestamp"
            case isTTSMessage = "tts"
            case messageMentionsEveryone = "mention_everyone"
            case mentionedRoles = "mention_roles"
            case mentionedUsers = "mentions"
            case mentionedChannels = "mention_channels"
            case isPinned = "pinned"
        }
    }
    
    /// Represents the available message types
    /// on Discord
    enum MessageType: Int, Codable {
        case defaultMessage = 0
        case recipientAdd = 1
        case recipientRemove = 2
        case call = 3
        case channelNameChange = 4
        case channelIconChange = 5
        case channelPinnedMessage = 6
        case guildMemberJoin = 7
        case userPremiumGuildSubscription = 8
        case userPremiumGuildSubscriptionTier1 = 9
        case userPremiumGuildSubscriptionTier2 = 10
        case userPremiumGuildSubscriptionTier3 = 11
        case channelFollowAdd = 12
        case guildDiscoveryDisqualified = 14
        case guildDiscoveryRequalified = 15
        case guildDiscoveryGracePeriodInitialWarning = 16
        case guildDiscoveryGracePeriodFinalWarning = 17
        case threadCreate = 18
        case reply = 19
        case chatInputCommand = 20
        case threadStarterMessage = 21
        case guildInviteReminder = 22
        case contextMenuCommand = 23
    }
    
    /// The types of Message Activities on Discord
    enum MessageActivityTypes: Int, Codable {
        case join = 1
        case spectate = 2
        case listen = 3
        case joinRequest = 5
    }
    
    /// Represents a Discord Message Activity
    struct MessageActivity: Codable {
        let type: MessageActivityTypes
        let partyID: String?
        
        enum CodingKeys: String, CodingKey {
            case type
            case partyID = "party_id"
        }
    }
}
