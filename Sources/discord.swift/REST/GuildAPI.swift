
import Foundation

public extension Bot {
    func fetchGuilds() async throws -> [Discord.Guild] {
        return try await self.client.Request(with: Discord.Endpoints.myGuilds, decodeTo: [Discord.Guild].self)
    }
    
    func fetchGuild(id: String) async throws -> Discord.Guild {
        let guildURL = Discord.Endpoints.guilds.appendingPathComponent(id)
        return try await self.client.Request(with: guildURL, decodeTo: Discord.Guild.self)
    }
    
    /// Bans a user from a specified Guild
    func ban(userID: String, guildID: String, deleteMessageDays: Int = 0) async throws {
        let banURL = Discord.Endpoints.banEndpoint(guildID: guildID, userID: userID)
        var request = URLRequest(url: banURL)
        request.httpMethod = "PUT"
        let params: [String: Any] = [
            "delete_message_days": deleteMessageDays
        ]
        
        _ = try await self.client.Request(using: request, bodyObject: params)
    }
    
    /// Unbans a user from the specified Guild
    func unban(userID: String, guildID: String) async throws {
        let banURL = Discord.Endpoints.banEndpoint(guildID: guildID)
            .appendingPathComponent(userID)
        var request = URLRequest(url: banURL)
        request.httpMethod = "DELETE"
        _ = try await self.client.Request(using: request)
    }
    
    /// Kicks a member from the specified Guild
    func kick(userID: String, guildID: String) async throws {
        let url = Discord.Endpoints.guildMembersEndpoint(guildID: guildID, userID: userID)
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        _ = try await self.client.Request(using: request)
    }
    
    /// Returns a `Discord.Ban` instance detailing ban information
    /// about a banned member
    func fetchBanInformation(userID: String, guildID: String) async throws -> Discord.Ban {
        let url = Discord.Endpoints.banEndpoint(guildID: guildID, userID: userID)
        return try await self.client.Request(with: url, decodeTo: Discord.Ban.self)
    }
    
    /// Returns an Array of `Discord.Ban` instances for a specified Guild
    func fetchBans(guilID: String) async throws -> [Discord.Ban] {
        return try await self.client.Request(with: Discord.Endpoints.banEndpoint(guildID: guilID), decodeTo: [Discord.Ban].self)
    }
}

extension Discord.Guild {
//    #warning("TODO: Bans, kicks, fetch members, etc")
//    public func ban() async throws -> Bool {
//        let (items, response) = try await self.client.fetch(AnyDecodable.self, url: Discord.Endpoints.guilds)
//    }
}
