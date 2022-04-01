public extension Discord {
    /// Represents a `Ban` object in Discord
    struct Ban: Decodable {
        /// The reason for the ban
        let reason: String?
        let user: Discord.User
    }
}
