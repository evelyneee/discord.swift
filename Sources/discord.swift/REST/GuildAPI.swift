
import Foundation

extension Bot {
    public func fetchGuilds() async throws -> [Discord.Guild] {
        let (items, response) = try await self.client.fetch([Discord.Guild].self, url: Discord.Endpoints.myGuilds)
        if let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                return items
            } else {
                throw NetworkClient.FetchErrors.badHTTPResponse(response)
            }
        } else {
            throw NetworkClient.FetchErrors.badResponse(response)
        }
    }
    
    public func fetchGuild(id: String) async throws -> Discord.Guild {
        let (item, response) = try await self.client.fetch(Discord.Guild.self, url: Discord.Endpoints.guilds.appendingPathComponent("/" + id))
        if let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                return item
            } else {
                throw NetworkClient.FetchErrors.badHTTPResponse(response)
            }
        } else {
            throw NetworkClient.FetchErrors.badResponse(response)
        }
    }
}

extension Discord.Guild {
    #warning("TODO: Bans, kicks, fetch members, etc")
//    public func ban() async throws -> Bool {
//        let (items, response) = try await self.client.fetch(AnyDecodable.self, url: Discord.Endpoints.guilds)
//    }
}
