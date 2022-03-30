
import Foundation

public extension Bot {
    func fetchPrivateChannels() async throws -> [Discord.Channel] {
        let (items, response) = try await self.client.fetch([Discord.Channel].self, url: Discord.Endpoints.myChannels)
        guard let response = response as? HTTPURLResponse,
              (200...299) ~= response.statusCode else {
                  throw NetworkClient.FetchErrors.badResponse(response)
              }
        return items
    }
    
    func fetchChannel(id: String) async throws -> Discord.Channel {
        let channelURL = Discord.Endpoints.channels
            .appendingPathComponent(id)
        let (item, response) = try await self.client.fetch(Discord.Channel.self, url: channelURL)
        guard let response = response as? HTTPURLResponse,
              (200...299) ~= response.statusCode else {
                  throw NetworkClient.FetchErrors.badResponse(response)
              }
        return item
    }
}
