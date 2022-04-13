import Foundation

public extension Bot {
    
    func fetchAuditLog(
        guildID: String,
        filterByUserID userID: String? = nil,
        filterByLogEvent actionType: Discord.AuditLogEvents? = nil,
        beforeEntryID: String? = nil,
        limit: Int = 50
    ) async throws -> Discord.AuditLog {
        var params: [String: String] = [
            "limit": "\(limit)"
        ]
        
        if let actionType = actionType {
            params["action_type"] = "\(actionType.rawValue)"
        }
        
        if let beforeEntryID = beforeEntryID {
            params["before"] = beforeEntryID
        }
        
        if let userID = userID {
            params["user_id"] = userID
        }
        
        let url = Discord.APIEndpoints.guilds
            .appendingPathComponent(guildID)
            .appendingPathComponent("audit-logs")
        let finalURL = try self.client.EncodeURL(url, with: params)
        return try await self.client.request(with: finalURL, decodeTo: Discord.AuditLog.self)
    }
}
