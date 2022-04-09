import Foundation

public extension Bot {
    func fetchUser(id: String) async throws -> Discord.User {
        let userURL = Discord.APIEndpoints.users
            .appendingPathComponent(id)
        return try await self.client.request(with: userURL, decodeTo: Discord.User.self)
    }
}
