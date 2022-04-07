import Foundation

extension Bot {
    
    /// Returns an Array of `Discord.Emote` instances
    /// for a specified Guild
    func fetchEmotes(guildID: String) async throws -> [Discord.Emote] {
        let url = Discord.Endpoints.guildEmotesEndpoint(guildID: guildID)
        return try await self.client.Request(with: url, decodeTo: [Discord.Emote].self)
    }
    
    /// Returns a `Discord.Emote` instance of a specified Guild and EmoteID
    func fetchEmote(guildID: String, emoteID: String) async throws -> Discord.Emote {
        let url = Discord.Endpoints.guildEmotesEndpoint(guildID: guildID, emoteID: emoteID)
        return try await self.client.Request(with: url, decodeTo: Discord.Emote.self)
    }
    
    /// Sends a request to discord to remove a specific Emote
    func removeEmote(guildID: String, emoteID: String) async throws {
        let url = Discord.Endpoints.guildEmotesEndpoint(guildID: guildID, emoteID: emoteID)
        let request = URLRequest(withURL: url, httpMethod: "DELETE")
        _ = try await self.client.Request(using: request)
    }
}
