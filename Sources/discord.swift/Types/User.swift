import Foundation

struct User: Codable, Identifiable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }

    var id: String
    var username: String
    var discriminator: String
    var avatarImageURL: String?
    var isBot: Bool?
    var system: Bool?
    var hasMFAEnabled: Bool?
    var userLocale: String?
    var isVerified: Bool?
    var email: String?
    var flags: Int?
    var nitroPremiumType: NitroTypes?
    var publicFlags: Int?
    var bio: String?
    var nickname: String?
    var roleColor: String?
    var banner: String?
    

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, username, discriminator, roleColor, banner, system
        case avatarImageURL = "avatar"
        case isBot = "bot"
        case hasMFAEnabled = "mfa_enabled"
        case userLocale = "locale"
        case isVerified = "verified"
        case nitroPremiumType = "premium_type"
        case publicFlags = "public_flags"
        case nickname = "nick"
    }
}

enum NitroTypes: Int, Codable {
    case none = 0
    case classic = 1
    case nitro = 2
}
