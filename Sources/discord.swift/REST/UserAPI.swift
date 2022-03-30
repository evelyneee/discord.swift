import Foundation

public extension Bot {
    func fetchUser(id: String) async throws -> Discord.User {
        let userURL = Discord.Endpoints.users
            .appendingPathComponent(id)
        let (item, response) = try await self.client.fetch(Discord.User.self, url: userURL)
        guard let response = response as? HTTPURLResponse,
              (200...299) ~= response.statusCode else {
                  throw NetworkClient.FetchErrors.badResponse(response)
              }
        
        return item
    }
}
