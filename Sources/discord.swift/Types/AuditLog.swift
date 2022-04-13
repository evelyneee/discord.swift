public extension Discord {
    
    /// Represents a Discord Audit Log object
    struct AuditLog: Decodable {
        /// The Audit Log Entries found in the Audit Log object
        let entries: [AuditLogEntry]
        
        /// The threads found in the Audit Log
        let threads: [Channel]
        
        /// The users found in the Audit Log
        let users: [User]
        
        enum CodingKeys: String, CodingKey {
            case entries = "audit_log_entries"
            case threads, users
        }
    }
    
    /// Represents a Discord Audit Log Entry object
    struct AuditLogEntry: Codable {
        /// ID of affected entity (webhook, user, role, etc)
        let targetID: String?
        
        /// ID of the user who made the changes
        let userID: String?
        
        /// ID of the Entry
        let entryID: String?
        
        /// the type of event that occured
        let actionType: AuditLogEvents
        
        /// The reason for the change
        let reason: String?
        
        enum CodingKeys: String, CodingKey {
            case targetID = "target_id"
            case userID = "user_id"
            case entryID = "entry_id"
            case actionType = "action_type"
            case reason
        }
    }
    
    /// Represents Log Events in a Discord Audit Log Entry
    enum AuditLogEvents: Int, Codable {
        case guildUpdate = 1
        
        case channelCreate = 10
        case channelUpdate = 11
        case channelDelete = 12
        
        case channelOverwriteCreate = 13
        case channelOverwriteUpdate = 14
        case channelOvewriteDelete = 15
        
        case memberKick = 20
        case memberPrune = 21
        case memberBanAdd = 22
        case memberBanRemove = 23
        case memberUpdate = 24
        case memberRoleUpdate = 25
        case memberMove = 26
        case memberDisconnect = 27
        
        case botAdd = 28
        
        case roleCreate = 30
        case roleUpdate = 31
        case roleDelete = 32
        
        case inviteCreate = 40
        case inviteUpdate = 41
        case inviteDelete = 42
        
        case webhookCreate = 50
        case webhookUpdate = 51
        case webhookDelete = 52
        
        case emojiCreate = 60
        case emojiUpdate = 61
        case emojiDelete = 62
        
        case messageDelete = 72
        case messageBulkDelete = 73
        case messagePin = 74
        case messageUnpin = 75
        
        case integrationCreate = 80
        case integrationUpdate = 81
        case integrationDelete = 82
        
        case stageInstanceCreate = 83
        case stageInstanceUpdate = 84
        case stageInstanceDelete = 85
        
        case stickerCreate = 90
        case stickerUpdate = 91
        case stickerDelete = 92
        
        case guildScheduledEventCreate = 100
        case guildScheduledEventUpdate = 101
        case guildScheduledEventDelete = 102
        
        case threadCreate = 110
        case threadUpdate = 111
        case threadDelete = 112
    }
}
