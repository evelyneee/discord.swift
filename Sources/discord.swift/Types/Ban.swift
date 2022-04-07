public extension Discord {
    /// Represents a `Ban` object in Discord
    struct Ban: Decodable {
        /// The reason for the ban
        let reason: String?
        /// The banned user
        let user: Discord.User
    }
}
