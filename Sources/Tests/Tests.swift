@testable import discord_swift
import XCTest

enum TestErrors: Error, LocalizedError {
    case enviromentVariablesNotFound(variable: String)
    
    var errorDescription: String? {
        switch self {
        case .enviromentVariablesNotFound(let variables):
            return "Needed enviroment variable not provided: \(variables)"
        }
    }
}

final class Tests: XCTestCase {
    let enviroment = ProcessInfo.processInfo.environment
    
    private func getEnv(_ variable: String) throws -> String {
        guard let env = enviroment[variable] else {
            throw TestErrors.enviromentVariablesNotFound(variable: variable)
        }
        return env
    }
    
    private func initBot() throws -> Bot {
        return Bot(try getEnv("BOT_TOKEN"))
    }
    
    func testExampleGuild() async throws {
        let bot = try initBot()
        let exampleGuildID = try getEnv("EXAMPLE_GUILD_ID")
        let guild = try await bot.fetchGuild(id: exampleGuildID)
        print("Guild name: \(guild.name)")
        print("Guild id: \(guild.id)")
        print("Guild Description: \(guild.description ?? "Unavailable")")
        print("Guild vanity URL: \(guild.vanityURLCode ?? "Unavailable")")
    }
    
    func testExampleUser() async throws {
        let bot = try initBot()
        let userID = try getEnv("EXAMPLE_USER_ID")
        let userDetails = try await bot.fetchUser(id: userID)
        print("Username: \(userDetails.username)")
        print("User discriminator: \(userDetails.discriminator)")
        print("User verified email: \(userDetails.hasVerifiedEmail ?? true)")
        print("User bio: \(userDetails.bio ?? "unavailable")")
    }
    
    func testBanUser() async throws {
        let bot = try initBot()
        let userID = try getEnv("EXAMPLE_USER_ID")
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        try await bot.ban(userID: userID, guildID: exampleGuild)
    }
    
    func testUnbanUser() async throws {
        let bot = try initBot()
        let userID = try getEnv("EXAMPLE_USER_ID")
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        try await bot.unban(userID: userID, guildID: exampleGuild)
    }
    
    func testKickUser() async throws {
        let bot = try initBot()
        let userID = try getEnv("EXAMPLE_USER_ID")
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        try await bot.kick(userID: userID, guildID: exampleGuild)
    }
    
    func testFetchBanInfo() async throws {
        let bot = try initBot()
        let userID = try getEnv("EXAMPLE_USER_ID")
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        let banInfo = try await bot.fetchBanInformation(userID: userID, guildID: exampleGuild)
        print("Banned user: \(banInfo.user)")
        print("Ban reason: \(banInfo.reason ?? "Unknown")")
    }
    
    func testFetchBans() async throws {
        let bot = try initBot()
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        let bans = try await bot.fetchBans(guilID: exampleGuild)
        if bans.isEmpty {
            print("Server has no bans")
        } else {
            print("Server bans: ")
            for ban in bans {
                print(ban)
            }
        }
    }
    
    func testFetchRoles() async throws {
        let bot = try initBot()
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        let roles = try await bot.fetchRoles(guildID: exampleGuild)
        for role in roles {
            print("Role name: \(role.name)")
            print("Role Position: \(role.position)")
            print("Role is mentionable: \(role.isMentionable)")
            print("Role Hex Color Code: \(role.HexColorCode)")
        }
    }
    
    func testCreateRole() async throws {
        let bot = try initBot()
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        let createdRole = try await bot.createRole(guildID: exampleGuild, name: "An example role", colorRGB: 1021)
        print("Created Role: \(createdRole)")
    }
    
    func testRemoveRole() async throws {
        let bot = try initBot()
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        let roleToRemove = try getEnv("EXAMPLE_REMOVE_ROLE_ID")
        try await bot.removeRole(guildID: exampleGuild, roleID: roleToRemove)
    }
    
    func testFetchInviteInfo() async throws {
        let bot = try initBot()
        let exampleInvite = try getEnv("EXAMPLE_INVITE_CODE")
        let codeInfo = try await bot.fetchInviteInformation(inviteCode: exampleInvite)
        print("Example invite: \(codeInfo)")
    }
    
    func testDeleteInvite() async throws {
        let bot = try initBot()
        let exampleInvite = try getEnv("EXAMPLE_INVITE_CODE")
        try await bot.deleteInvite(inviteCode: exampleInvite)
    }
    
    func testFetchStickers() async throws {
        let bot = try initBot()
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        let stickers = try await bot.fetchStickers(guildID: exampleGuild)
        if stickers.isEmpty {
            print("guild has no stickers")
        } else {
            for sticker in stickers {
                print("sticker: \(sticker)")
            }
        }
    }
    
    func testFetchMessages() async throws {
        let bot = try initBot()
        let exampleChannel = try getEnv("EXAMPLE_CHANNEL_ID")
        let messages = try await bot.fetchMessages(channelID: exampleChannel)
        if messages.isEmpty {
            print("no messages available :(")
        } else {
            for message in messages {
                print("message content: \(message.content)")
                print("channel ID: \(message.channelID)")
                print("mentioned users: \(message.mentionedUsers)")
                print("attachments: \(message.attachments)")
                print("message type: \(message.type)")
                print("message embds: \(message.embeds)")
            }
        }
    }
    
    func testDeleteChannel() async throws {
        let bot = try initBot()
        let exampleChannel = try getEnv("EXAMPLE_CHANNEL_ID")
        try await bot.deleteChannel(id: exampleChannel)
    }
    
    func testFetchEmotes() async throws {
        let bot = try initBot()
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        let emotes = try await bot.fetchEmotes(guildID: exampleGuild)
        for emote in emotes {
            print("emote name: \(emote.name ?? "unknown")")
            print("emote id: \(emote.id ?? "unknown")")
            print("emote is animated: \(emote.isAnimated ?? false)")
            print("emote is available: \(emote.isAvailable ?? false)")
            print()
        }
    }
    
    func testFetchEmote() async throws {
        let bot = try initBot()
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        let exampleEmote = try getEnv("EXAMPLE_EMOTE_ID")
        let emote = try await bot.fetchEmote(guildID: exampleGuild, emoteID: exampleEmote)
        print("emote: \(emote)")
    }
}
