import Foundation


public extension Bot {
    
    /// Returns information about a specified Invite
    /// in the form of a `Discord.Invite` instance
    /// - Parameters:
    ///   - inviteCode: The invite code to fetch information from
    ///   - withCounts: Whether the `Discord.Invite` object returned should include counts
    ///   - withExpiration: Whether the `Discord.Invite` object returnd should inclue the Expiration Date
    /// - Returns: A `Discord.Invite` instance.
    func fetchInviteInformation(inviteCode: String, withCounts: Bool = true, withExpiriation: Bool = true) async throws -> Discord.Invite {
        let url = Discord.APIEndpoints.invites
            .appendingPathComponent(inviteCode)
        let body = [
            "with_counts": "\(withCounts)",
            "with_expiration": "\(withExpiriation)"
        ]
        
        let encodedURL = try self.client.EncodeURL(url, with: body)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try await self.client.Request(with: encodedURL, decodeTo: Discord.Invite.self, decoder: decoder)
    }
    
    /// Sends a Request to discord to delete the specified invite
    func deleteInvite(inviteCode: String) async throws {
        let url = Discord.APIEndpoints.invites
            .appendingPathComponent(inviteCode)
        let request = URLRequest(withURL: url, httpMethod: "DELETE")
        _ = try await self.client.Request(using: request)
    }
}
