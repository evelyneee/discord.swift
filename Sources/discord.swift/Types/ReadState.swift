struct ReadState: Decodable {
    var version: Int?
    var partial: Bool?
    var entries: [ReadStateEntry]
}

struct ReadStateEntry: Decodable, Identifiable {
    var mentionCount: Int
    var lastPinTimestamp: String
    var lastMessageID: String?
    var id: String // Channel ID
    
    enum CodingKeys: String, CodingKey {
        case mentionCount = "mention_count"
        case lastPinTimestamp = "last_pin_timestamp"
        case lastMessageID = "last_message_id"
        case id
    }
}
