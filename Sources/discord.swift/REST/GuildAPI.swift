
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
        var request = URLRequest(url: Discord.Endpoints.roleEndpoint(guildID: guildID))
        request.httpMethod = "POST"
        let headers = ["Content-type": "application/json"]
        return try await self.client.Request(using: request, bodyObject: params, headers: headers, decodeTo: Discord.Role.self)
    }
    
    /// Sends a request to remove a specified Role
    func removeRole(guildID: String, roleID: String) async throws {
        let url = Discord.Endpoints.roleEndpoint(guildID: guildID, roleID: roleID)
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        _ = try await self.client.Request(using: request)
    }
}

extension Discord.Guild {
//    #warning("TODO: Bans, kicks, fetch members, etc")
//    public func ban() async throws -> Bool {
//        let (items, response) = try await self.client.fetch(AnyDecodable.self, url: Discord.Endpoints.guilds)
//    }
}
