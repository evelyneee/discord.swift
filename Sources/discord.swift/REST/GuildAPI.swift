
import Foundation

public extension Bot {
    func fetchGuilds() async throws -> [Discord.Guild] {
        return try await self.client.Request(with: Discord.Endpoints.myGuilds, decodeTo: [Discord.Guild].self)
    }
    
    func fetchGuild(id: String, withCounts: Bool = true) async throws -> Discord.Guild {
        let guildURL = Discord.Endpoints.guilds.appendingPathComponent(id)
        let encodedURL = try self.client.EncodeURL(guildURL, with: ["with_counts": "\(withCounts)"])
        return try await self.client.Request(with: encodedURL, decodeTo: Discord.Guild.self)
    }
    
    /// Bans a user from a specified Guild
    func ban(userID: String, guildID: String, deleteMessageDays: Int = 0) async throws {
        let banURL = Discord.Endpoints.banEndpoint(guildID: guildID, userID: userID)
        let request = URLRequest(withURL: banURL, httpMethod: "PUT")
        let params: [String: Any] = [
            "delete_message_days": deleteMessageDays
        ]
        
        _ = try await self.client.Request(using: request, bodyObject: params, headers: ["Content-type": "application/json"])
    }
    
    /// Unbans a user from the specified Guild
    func unban(userID: String, guildID: String) async throws {
        let banURL = Discord.Endpoints.banEndpoint(guildID: guildID)
            .appendingPathComponent(userID)
        let request = URLRequest(withURL: banURL, httpMethod: "DELETE")
        _ = try await self.client.Request(using: request)
    }
    
    /// Kicks a member from the specified Guild
    func kick(userID: String, guildID: String) async throws {
        let url = Discord.Endpoints.guildMembersEndpoint(guildID: guildID, userID: userID)
        let request = URLRequest(withURL: url, httpMethod: "DELETE")
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
    
    /// Returns an Array of `Discord.Roles` instances belonging to a specified Guild
    func fetchRoles(guildID: String) async throws -> [Discord.Role] {
        let url = Discord.Endpoints.roleEndpoint(guildID: guildID, roleID: nil)
        return try await self.client.Request(with: url, decodeTo: [Discord.Role].self)
    }
    
    /// Sends a request to Discord to create a role, and returns the Role created
    /// - Parameters:
    ///   - guildID: The ID of the Guild to create the role for
    ///   - name: The name of the Role to create
    ///   - unicodeEmoji: The Unicode Emoji of the Role
    ///   - colorRGB: the Color of the Role, in RGB
    ///   - shouldDisplayInSidebar: Whether or not the role should be displayed in the sidebar
    ///   - shouldBeMentionable: Whether or not the role should be mentionable
    /// - Returns: The created Role as a `Discord.Role` instance
    func createRole(
        guildID: String,
        name: String,
        unicodeEmoji: String? = nil,
        colorRGB: Int = 0,
        shouldDisplayInSidebar: Bool = true,
        shouldBeMentionable: Bool = false
    ) async throws -> Discord.Role {
        var params: [String: Any] = [
            "name": name,
            "hoist": shouldDisplayInSidebar,
            "color": colorRGB,
            "mentionable": shouldBeMentionable
        ]
        
        if let unicodeEmoji = unicodeEmoji {
            params["unicode_emoji"] = unicodeEmoji
        }
        let request = URLRequest(withURL: Discord.Endpoints.roleEndpoint(guildID: guildID), httpMethod: "POST")
        let headers = ["Content-type": "application/json"]
        return try await self.client.Request(using: request, bodyObject: params, headers: headers, decodeTo: Discord.Role.self)
    }
    
    /// Sends a request to remove a specified Role
    func removeRole(guildID: String, roleID: String) async throws {
        let url = Discord.Endpoints.roleEndpoint(guildID: guildID, roleID: roleID)
        let request = URLRequest(withURL: url, httpMethod: "DELETE")
        _ = try await self.client.Request(using: request)
    }
    
    /// Returns an Array of `Discord.Sticker` instance
    /// belonging to the specified Guild
    func fetchStickers(guildID: String) async throws -> [Discord.Sticker] {
        let url = Discord.Endpoints.guildStickerEndpoint(guildID: guildID)
        return try await self.client.Request(with: url, decodeTo: [Discord.Sticker].self)
    }
    
    /// Returns information about a specified Sticker in a
    /// `Discord.Sticker` Instance
    func fetchSticker(guildID: String, stickerID: String) async throws -> Discord.Sticker {
        let url = Discord.Endpoints.guildStickerEndpoint(guildID: guildID, stickerID: stickerID)
        
        return try await self.client.Request(with: url, decodeTo: Discord.Sticker.self)
    }
    
    /// Sends a Request to Discord to delete a specified Sticker
    func deleteSticker(guildID: String, stickerID: String) async throws {
        let url = Discord.Endpoints.guildStickerEndpoint(guildID: guildID, stickerID: stickerID)
        let request = URLRequest(withURL: url, httpMethod: "DELETE")
        _ = try await self.client.Request(using: request)
    }
}

extension Discord.Guild {
//    #warning("TODO: Bans, kicks, fetch members, etc")
//    public func ban() async throws -> Bool {
//        let (items, response) = try await self.client.fetch(AnyDecodable.self, url: Discord.Endpoints.guilds)
//    }
}
