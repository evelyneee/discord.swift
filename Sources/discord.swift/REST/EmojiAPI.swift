import Foundation

extension Bot {
    
    /// Returns an Array of `Discord.Emote` instances
    /// for a specified Guild
    func fetchEmotes(guildID: String) async throws -> [Discord.Emote] {
        let url = Discord.APIEndpoints.guildEmotesEndpoint(guildID: guildID)
        return try await self.client.request(with: url, decodeTo: [Discord.Emote].self)
    }
    
    /// Returns a `Discord.Emote` instance of a specified Guild and EmoteID
    func fetchEmote(guildID: String, emoteID: String) async throws -> Discord.Emote {
        let url = Discord.APIEndpoints.guildEmotesEndpoint(guildID: guildID, emoteID: emoteID)
        return try await self.client.request(with: url, decodeTo: Discord.Emote.self)
    }
    
    /// Sends a request to discord to remove a specific Emote
    func removeEmote(guildID: String, emoteID: String) async throws {
        let url = Discord.APIEndpoints.guildEmotesEndpoint(guildID: guildID, emoteID: emoteID)
        let request = URLRequest(withURL: url, httpMethod: "DELETE")
        _ = try await self.client.request(using: request)
    }
    
    
    /// Sends a reques to discord to modify an emote
    /// - Parameters:
    ///   - emoteID: The ID of the Emote to edit
    ///   - guildID: The ID which the Emote resides in
    ///   - newEmoteName: The new name of the Emote
    ///   - rolesAllowed: An array of Role IDs allowed to use the emote
    /// - Returns: A `Discord.Emote` instance of the newly-modified emote
    func modifyEmote(emoteID: String, guildID: String, newEmoteName: String?, rolesAllowed: [String]? = nil) async throws -> Discord.Emote {
        var params: [String: Any] = [:]
        
        if let newEmoteName = newEmoteName {
            params["name"] = newEmoteName
        }
        
        if let rolesAllowed = rolesAllowed {
            params["roles"] = rolesAllowed
        }
        
        let url = Discord.APIEndpoints.guildEmotesEndpoint(guildID: guildID, emoteID: emoteID)
        return try await self.client.request(using: URLRequest(withURL: url, httpMethod: "PATCH"), bodyObject: params, headers: ["Content-type": "application/json"], decodeTo: Discord.Emote.self, decoder: .discordDateCompatible)
    }
}
