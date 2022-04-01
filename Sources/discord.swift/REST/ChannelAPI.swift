
import Foundation

public extension Bot {
    func fetchPrivateChannels() async throws -> [Discord.Channel] {
        return try await self.client.Request(with: Discord.Endpoints.myChannels, decodeTo: [Discord.Channel].self)
    }
    
    func fetchChannel(id: String) async throws -> Discord.Channel {
        let channelURL = Discord.Endpoints.channels
            .appendingPathComponent(id)
        let item = try await self.client.Request(with: channelURL, decodeTo: Discord.Channel.self)
        return item
    }
}
