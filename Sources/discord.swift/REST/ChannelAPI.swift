
import Foundation

public extension Bot {
    func fetchPrivateChannels() async throws -> [Discord.Channel] {
        let items = try await self.client.fetch([Discord.Channel].self, url: Discord.Endpoints.myChannels)
        return items
    }
    
    func fetchChannel(id: String) async throws -> Discord.Channel {
        let channelURL = Discord.Endpoints.channels
            .appendingPathComponent(id)
        let item = try await self.client.fetch(Discord.Channel.self, url: channelURL)
        return item
    }
}
