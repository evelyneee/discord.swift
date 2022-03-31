
import Foundation

public extension Bot {
    func fetchGuilds() async throws -> [Discord.Guild] {
        let items = try await self.client.fetch([Discord.Guild].self, url: Discord.Endpoints.myGuilds)
        return items
    }
    
    func fetchGuild(id: String) async throws -> Discord.Guild {
        let guildURL = Discord.Endpoints.guilds.appendingPathComponent(id)
        let item = try await self.client.fetch(Discord.Guild.self, url: guildURL)
        return item
    }
}

extension Discord.Guild {
    #warning("TODO: Bans, kicks, fetch members, etc")
//    public func ban() async throws -> Bool {
//        let (items, response) = try await self.client.fetch(AnyDecodable.self, url: Discord.Endpoints.guilds)
//    }
}
