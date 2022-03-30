
import Foundation

public extension Bot {
    func fetchGuilds() async throws -> [Discord.Guild] {
        let (items, response) = try await self.client.fetch([Discord.Guild].self, url: Discord.Endpoints.myGuilds)
        if let response = response as? HTTPURLResponse {
            guard (200...299) ~= response.statusCode else {
                throw NetworkClient.FetchErrors.badHTTPResponse(response)
            }
            return items
        } else {
            throw NetworkClient.FetchErrors.badResponse(response)
        }
    }
    
    func fetchGuild(id: String) async throws -> Discord.Guild {
        let guildURL = Discord.Endpoints.guilds.appendingPathComponent(id)
        let (item, response) = try await self.client.fetch(Discord.Guild.self, url: guildURL)
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
