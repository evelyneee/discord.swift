import Foundation

public extension Bot {
    
    /// Creates a new thread from a specified Message, and returns the created Thread as a `Discord.Channel` instance
    /// - Parameters:
    ///   - messageID: The message to start the thread from (optional)
    ///   - channelID: The channel to start the thread in
    ///   - threadName: The name of the thread
    ///   - autoArchiveDuration: The time, in seconds, in which the thread will automatically archive
    ///   - slowdownRate: Amount of time, in seconds, in which users will have to wait to send another message
    /// - Returns: The newly created Thread in the form of a `Discord.Channel` instance
    func createThread(
        fromMessage messageID: String?,
        channelID: String,
        threadName: String,
        type: Discord.ChannelType = .guild_public_thread,
        autoArchiveDuration: Int? = nil,
        slowdownRate: Int? = nil
    ) async throws -> Discord.Channel {
        let url = Discord.APIEndpoints.threadsEndpoint(channelID: channelID, messageID: messageID)
        var params: [String: Any] = [
            "name": threadName,
            "type": type.rawValue
        ]
        
        if let autoArchiveDuration = autoArchiveDuration {
            params["auto_archive_duration"] = autoArchiveDuration
        }
        
        if let slowdownRate = slowdownRate {
            params["rate_limit_by_user"] = slowdownRate
        }
        
        return try await self.client.request(using: URLRequest(withURL: url, httpMethod: "POST"), bodyObject: params, headers: ["Content-type": "application/json"], decodeTo: Discord.Channel.self)
    }
    
    func fetchMembers(fromThread threadID: String) async throws -> [Discord.ThreadMember] {
        let url = Discord.APIEndpoints.threadMembersEndpoint(threadID: threadID, userID: nil)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try await self.client.request(with: url, decodeTo: [Discord.ThreadMember].self, decoder: decoder)
    }
    
    /// Sends a request to discord to add a member to a specific Thread
    func addMemberToThread(threadID: String, userID: String) async throws {
        let url = Discord.APIEndpoints.threadMembersEndpoint(threadID: threadID, userID: userID)
        let request = URLRequest(withURL: url, httpMethod: "PUT")
        _ = try await self.client.request(using: request)
    }
    
    func removeUserFromThread(threadID: String, userID: String) async throws {
        let url = Discord.APIEndpoints.threadMembersEndpoint(threadID: threadID, userID: userID)
        let request = URLRequest(withURL: url, httpMethod: "DELETE")
        _ = try await self.client.request(using: request)
    }
}
