
import Foundation

extension Bot {
    public func fetchPrivateChannels() async throws -> [Discord.Channel] {
        let (items, response) = try await self.client.fetch([Discord.Channel].self, url: Discord.Endpoints.myChannels)
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
}

extension Channel {
    #warning("TODO: Message type")
    // public func fetchMessages() async throws ->
}
