import Foundation

public extension Bot {
    func fetchUser(id: String) async throws -> Discord.User {
        let userURL = Discord.Endpoints.users
            .appendingPathComponent(id)
        let item = try await self.client.fetch(Discord.User.self, url: userURL)
        return item
    }
}
