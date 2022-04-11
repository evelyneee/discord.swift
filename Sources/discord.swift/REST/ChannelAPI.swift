
import Foundation

public extension Bot {
    func fetchPrivateChannels() async throws -> [Discord.Channel] {
        return try await self.client.request(with: Discord.APIEndpoints.myChannels, decodeTo: [Discord.Channel].self)
    }
    
    func fetchChannel(id: String) async throws -> Discord.Channel {
        let channelURL = Discord.APIEndpoints.channels
            .appendingPathComponent(id)
        return try await self.client.request(with: channelURL, decodeTo: Discord.Channel.self)
    }
    
    /// Sends a request to discord to delete a Channel.
    func deleteChannel(id: String) async throws {
        let channelDeleteURL = Discord.APIEndpoints.channels
            .appendingPathComponent(id)
        let request = URLRequest(withURL: channelDeleteURL, httpMethod: "DELETE")
        _ = try await self.client.request(using: request)
    }
    
    
    /// Returns an Array of `Discord.Message` instances for
    /// a specified Channel ID
    func fetchMessages(channelID: String) async throws -> [Discord.Message] {
        let url = Discord.APIEndpoints.channels
            .appendingPathComponent(channelID)
            .appendingPathComponent("messages")
        return try await self.client.request(with: url, decodeTo: [Discord.Message].self)
    }
    
    /// Returns a `Discord.Message` instance for a specified Message ID & Channel ID
    func fetchMessage(channelID: String, messageID: String) async throws -> Discord.Message {
        let url = Discord.APIEndpoints.channels
            .appendingPathComponent(channelID)
            .appendingPathComponent("messages")
            .appendingPathComponent(messageID)
        return try await self.client.request(with: url, decodeTo: Discord.Message.self)
    }
    
    /// Returns an Array of `Discord.Message` instances
    /// of Pinned messages for a specified Channel
    func fetchPinnedMessages(channelID: String) async throws -> [Discord.Message] {
        let url = Discord.APIEndpoints.channelPinsEndpoint(channelID: channelID)
        return try await self.client.request(with: url, decodeTo: [Discord.Message].self)
    }
    
    //TODO: - merge pin and unpin functions to one function, and have the client specify to either pin / unpin in the parameters
    
    /// Sends a request to discord to pin a specified message
    func pin(messageID: String, channelID: String) async throws {
        let url = Discord.APIEndpoints.channelPinsEndpoint(channelID: channelID, messageID: messageID)
        let request = URLRequest(withURL: url, httpMethod: "PUT")
        _ = try await self.client.request(using: request)
    }
    
    func unpin(messageID: String, channelID: String) async throws {
        let url = Discord.APIEndpoints.channelPinsEndpoint(channelID: channelID, messageID: messageID)
        let request = URLRequest(withURL: url, httpMethod: "DELETE")
        _ = try await self.client.request(using: request)
    }
    
    //TODO: - use JSONEncoder for this function's URLRequest body
    func sendMessage(
        channelID: String,
        content: String,
        isTSSMessage: Bool = false,
        embeds: [Discord.Embed] = [],
        stickerIDS: [String] = [],
        attachments: [Discord.Attachment] = [],
        replyingTo msgRef: Discord.MessageReference? = nil
    ) async throws -> Discord.Message {
        let url = Discord.APIEndpoints.channels
            .appendingPathComponent(channelID)
            .appendingPathComponent("messages")
        let request = URLRequest(withURL: url, httpMethod: "POST")
        
        var params: [String: Any] = [
            "content": content,
            "tts": isTSSMessage,
            "embeds": embeds,
            "sticker_ids": stickerIDS,
            "attachments": attachments
        ]
        
        if let msgRef = msgRef {
            params["message_reference"] = msgRef
        }
        
        return try await self.client.request(using: request, bodyObject: params, decodeTo: Discord.Message.self)
    }
    
    func deleteMessage(channelID: String, messageID: String) async throws {
        let url = Discord.APIEndpoints.channels
            .appendingPathComponent(channelID)
            .appendingPathComponent("messages")
            .appendingPathComponent(messageID)
        _ = try await self.client.request(using: URLRequest(withURL: url, httpMethod: "DELETE"))
    }
    
    /// Sends a Request to Discord to bulk-delete the specified messages
    /// - Parameters:
    ///   - channelID: The Channel from which to delete the messages
    ///   - messageIDs: An array of Message IDs to delete
    func bulkDeleteMessages(channelID: String, messageIDs: [String]) async throws {
        let url = Discord.APIEndpoints.bunkDeleteEndpoint(channelID: channelID)
        let jsonParams: [String: Any] = [
            "messages": messageIDs
        ]
        _ = try await self.client.request(using: URLRequest(withURL: url, httpMethod: "POST"), bodyObject: jsonParams, headers: ["Content-type": "application/json"])
    }
}
