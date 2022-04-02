/// Represents an Error returned by Discord
struct DiscordError: Decodable {
    let message: String
    let code: Int
}
