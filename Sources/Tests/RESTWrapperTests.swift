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

final class RESTWrapperTests: XCTestCase {
    let enviroment = ProcessInfo.processInfo.environment
    
    private func getEnv(_ variable: String) throws -> String {
        guard let env = enviroment[variable] else {
            throw TestErrors.enviromentVariablesNotFound(variable: variable)
        }
        return env
    }
    
    private func initBot() throws -> Bot {
        return Bot(token: try getEnv("BOT_TOKEN"))
    }
    
    func testExampleGuild() async throws {
        let bot = try initBot()
        let exampleGuildID = try getEnv("EXAMPLE_GUILD_ID")
        let guild = try await bot.fetchGuild(id: exampleGuildID)
        print("Guild name: \(guild.name)")
        print("Guild id: \(guild.id)")
        print("Guild Description: \(guild.description ?? "Unavailable")")
        print("Guild vanity URL: \(guild.vanityURLCode ?? "Unavailable")")
        if let approxMemberCount = guild.approxMemberCount {
            print("Guild member count: \(approxMemberCount)")
        }
        if let approxOnlineCount = guild.approxPresenceCount {
            print("Guild online users count: \(approxOnlineCount)")
        }
        
        if let iconURL = guild.iconPictureURL() {
            print("Guild Icon URL: \(iconURL)")
        }
    }
    
    func testExampleUser() async throws {
        let bot = try initBot()
        let userID = try getEnv("EXAMPLE_USER_ID")
        let userDetails = try await bot.fetchUser(id: userID)
        print("Username: \(userDetails.username)")
        print("User discriminator: \(userDetails.discriminator)")
        print("User verified email: \(userDetails.hasVerifiedEmail ?? true)")
        print("User bio: \(userDetails.bio ?? "unavailable")")
        if let pfpURL = userDetails.profilePictureURL() {
            print("pfpURL: \(pfpURL)")
        }
        
        if let bannerURL = userDetails.bannerPictureURL() {
            print("Banner Image URL: \(bannerURL)")
        }
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
    
    func testDeleteMessage() async throws {
        let bot = try initBot()
        let exampleChannel = try getEnv("EXAMPLE_CHANNEL_ID")
        let exampleMessage = try getEnv("EXAMPLE_MESSAGE_ID")
        try await bot.deleteMessage(channelID: exampleChannel, messageID: exampleMessage)
    }
    
    func testCreateInvite() async throws {
        let bot = try initBot()
        let exampleChannel = try getEnv("EXAMPLE_CHANNEL_ID")
        let returnedInvite = try await bot.createInvite(channelID: exampleChannel)
        print("returned invite: \(returnedInvite)")
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
        let createdRole = try await bot.createRole(guildID: exampleGuild, name: "An example role", colorRGB: Int.random(in: 1...255))
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
        let inviteFetched = try await bot.fetchInviteInformation(inviteCode: exampleInvite)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        print("Invite Code: \(inviteFetched.inviteCode)")
        print("Expiration Date: \(formatter.string(from: inviteFetched.expirationDate))")
        
        if let channel = inviteFetched.channel {
            print("Invite channel: \(channel)")
        }
        if let guild = inviteFetched.guild {
            print("Invite Guild: \(guild)")
        }
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
                print("message content: \(message.content ?? "unavailable")")
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
    
    func testPinOrUnpinMessage() async throws {
        let bot = try initBot()
        let exampleChannel = try getEnv("EXAMPLE_CHANNEL_ID")
        let exampleMessage = try getEnv("EXAMPLE_MESSAGE_ID")
        let pinAction = (try? getEnv("PIN_ACTION")) ?? "pin"
        
        if pinAction.lowercased() == "pin" {
            try await bot.pin(messageID: exampleMessage, channelID: exampleChannel)
        } else {
            try await bot.unpin(messageID: exampleMessage, channelID: exampleChannel)
        }
    }
    
    func testSendMessage() async throws {
        let bot = try initBot()
        let exampleChannel = try getEnv("EXAMPLE_CHANNEL_ID")
        let returnedMessage = try await bot.sendMessage(channelID: exampleChannel, content: "another msg!")
        print("returned message: \(returnedMessage)")
    }
    
    func testCreateThread() async throws {
        let bot = try initBot()
        let exampleChannel = try getEnv("EXAMPLE_CHANNEL_ID")
        let exampleMessage = try? getEnv("EXAMPLE_MESSAGE_ID")
        let name = (try? getEnv("EXAMPLE_THREAD_NAME")) ?? "Some thread"
        
        let createdThread = try await bot.createThread(fromMessage: exampleMessage, channelID: exampleChannel, threadName: name)
        print("created thread: \(createdThread)")
    }
    
    func testAddUserToThread() async throws {
        let bot = try initBot()
        let exampleThread = try getEnv("EXAMPLE_CHANNEL_ID")
        let exampleUser = (try? getEnv("EXAMPLE_USER_ID")) ?? "@me"
        try await bot.addMemberToThread(threadID: exampleThread, userID: exampleUser)
    }
    
    func testRemoveUserFromThread() async throws {
        let bot = try initBot()
        let exampleThread = try getEnv("EXAMPLE_CHANNEL_ID")
        let exampleUser = (try? getEnv("EXAMPLE_USER_ID")) ?? "@me"
        try await bot.removeUserFromThread(threadID: exampleThread, userID: exampleUser)
    }
    
    func testFetchGuildMember() async throws {
        let bot = try initBot()
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        let exampleUser = try getEnv("EXAMPLE_USER_ID")
        let fetchedMember = try await bot.fetchGuildMember(guildID: exampleGuild, userID: exampleUser)
        print("fetchedMember: \(fetchedMember)")
    }
    
    func testFetchAuditLog() async throws {
        let bot = try initBot()
        let exampleGuild = try getEnv("EXAMPLE_GUILD_ID")
        let auditLog = try await bot.fetchAuditLog(guildID: exampleGuild)
        for entry in auditLog.entries {
            print("entry: \(entry)")
        }
    }
}
