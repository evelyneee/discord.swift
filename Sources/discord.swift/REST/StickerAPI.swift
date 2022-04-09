import Foundation


public extension Bot {
    /// Returns an Array of `Discord.Sticker` instance
    /// belonging to the specified Guild
    func fetchStickers(guildID: String) async throws -> [Discord.Sticker] {
        let url = Discord.APIEndpoints.guildStickerEndpoint(guildID: guildID)
        return try await self.client.request(with: url, decodeTo: [Discord.Sticker].self)
    }
    
    /// Returns information about a specified Sticker in a
    /// `Discord.Sticker` Instance
    func fetchSticker(guildID: String, stickerID: String) async throws -> Discord.Sticker {
        let url = Discord.APIEndpoints.guildStickerEndpoint(guildID: guildID, stickerID: stickerID)
        
        return try await self.client.request(with: url, decodeTo: Discord.Sticker.self)
    }
    
    /// Sends a Request to Discord to delete a specified Sticker
    func deleteSticker(guildID: String, stickerID: String) async throws {
        let url = Discord.APIEndpoints.guildStickerEndpoint(guildID: guildID, stickerID: stickerID)
        let request = URLRequest(withURL: url, httpMethod: "DELETE")
        _ = try await self.client.request(using: request)
    }
    
}
