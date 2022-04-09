
import Foundation

public extension Bot {
    func fetchPrivateChannels() async throws -> [Discord.Channel] {
        return try await self.client.Request(with: Discord.APIEndpoints.myChannels, decodeTo: [Discord.Channel].self)
    }
    
    func fetchChannel(id: String) async throws -> Discord.Channel {
        let channelURL = Discord.APIEndpoints.channels
            .appendingPathComponent(id)
        return try await self.client.Request(with: channelURL, decodeTo: Discord.Channel.self)
    }
    
    /// Sends a request to discord to delete a Channel.
    func deleteChannel(id: String) async throws {
        let channelDeleteURL = Discord.APIEndpoints.channels
            .appendingPathComponent(id)
        let request = URLRequest(withURL: channelDeleteURL, httpMethod: "DELETE")
        _ = try await self.client.Request(using: request)
    }
    
    
    /// Returns an Array of `Discord.Message` instances for
    /// a specified Channel ID
    func fetchMessages(channelID: String) async throws -> [Discord.Message] {
        let url = Discord.APIEndpoints.channels
            .appendingPathComponent(channelID)
            .appendingPathComponent("messages")
        return try await self.client.Request(with: url, decodeTo: [Discord.Message].self)
    }
    
    /// Returns a `Discord.Message` instance for a specified Message ID & Channel ID
    func fetchMessage(channelID: String, messageID: String) async throws -> Discord.Message {
        let url = Discord.APIEndpoints.channels
            .appendingPathComponent(channelID)
            .appendingPathComponent("messages")
            .appendingPathComponent(messageID)
        return try await self.client.Request(with: url, decodeTo: Discord.Message.self)
    }
    
    func deleteMessage(channelID: String, messageID: String) async throws {
        let url = Discord.APIEndpoints.channels
            .appendingPathComponent(channelID)
            .appendingPathComponent("messages")
            .appendingPathComponent(messageID)
        _ = try await self.client.Request(using: URLRequest(withURL: url, httpMethod: "DELETE"))
    }
}
