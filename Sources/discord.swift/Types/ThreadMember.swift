import Foundation
public extension Discord {
    /// Describes a user present in a Thread
    struct ThreadMember: Codable {
        let threadID: String?
        let userID: String?
        let userJoinDate: Date
        
        enum CodingKeys: String, CodingKey {
            case threadID = "id"
            case userID = "user_id"
            case userJoinDate = "join_timestamp"
        }
    }
}
