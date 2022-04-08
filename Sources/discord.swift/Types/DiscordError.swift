/// Represents an Error returned by Discord
struct DiscordError: Decodable, CustomStringConvertible {
    let message: String
    let code: Int
    
    var description: String {
        "Discord returned an Error.\nError Message: \(message)\nError Code: \(code)"
    }
}
