import Foundation

extension Discord {
    public struct User: Codable, Identifiable, Hashable {
        static public func == (lhs: User, rhs: User) -> Bool {
            lhs.id == rhs.id
        }

        public let id: String
        var username: String
        var discriminator: String
        var avatarHash: String?
        var isBot: Bool?
        var isSystemUser: Bool?
        var hasMFAEnabled: Bool?
        var userLocale: String?
        var hasVerifiedEmail: Bool?
        var email: String?
        var flags: Int?
        var nitroPremiumType: NitroTypes?
        var publicFlags: Int?
        var bio: String?
        var nickname: String?
        var roleColor: String?
        var banner: String?
        

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        enum CodingKeys: String, CodingKey {
            case id, username, discriminator, roleColor, banner, email
            case avatarHash = "avatar"
            case isBot = "bot"
            case hasMFAEnabled = "mfa_enabled"
            case userLocale = "locale"
            case hasVerifiedEmail = "verified"
            case nitroPremiumType = "premium_type"
            case publicFlags = "public_flags"
            case nickname = "nick"
            case isSystemUser = "system"
        }
    }

    enum NitroTypes: Int, Codable {
        case none = 0
        case classic = 1
        case nitro = 2
    }
}

public extension Discord.User {
    /// Returns the full URL to the user's Profile Picture
    func profilePictureURL(imageFormat: Discord.CDNFormats = .png) -> URL? {
        guard let avatarHash = avatarHash else {
            return nil
        }
        
        return Discord.CDNEndpoints.avatars
            .appendingPathComponent(self.id)
            .appendingPathComponent(avatarHash)
            .appendingPathExtension(imageFormat.fileExtenstion)
    }
    
    func bannerPictureURL(imageFormat: Discord.CDNFormats = .png) -> URL? {
        guard let bannerHash = self.banner else {
            return nil
        }
        
        return Discord.CDNEndpoints.banners
            .appendingPathComponent(self.id)
            .appendingPathComponent(bannerHash)
            .appendingPathExtension(imageFormat.fileExtenstion)
    }
}
