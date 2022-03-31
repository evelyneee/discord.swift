@testable import discord_swift
import XCTest

enum TestErrors: Error, LocalizedError {
    case enviromentVariableNotProvided(variableName: String)
    
    var errorDescription: String? {
        switch self {
        case .enviromentVariableNotProvided(let variableName):
            return "Needed enviroment variable \"\(variableName)\" not provided."
        }
    }
}

final class Tests: XCTestCase {
    let enviroment = ProcessInfo.processInfo.environment
    
    private func initBot() throws -> Bot {
        guard let bot = Bot() else {
            throw TestErrors.enviromentVariableNotProvided(variableName: "BOT_TOKEN")
        }
        return bot
    }
    
    func testExampleGuild() async throws {
        let bot = try initBot()
        guard let exampleGuildID = enviroment["EXAMPLE_GUILD_ID"] else {
            throw TestErrors.enviromentVariableNotProvided(variableName: "EXAMPLE_GUILD_ID")
        }
        let guild = try await bot.fetchGuild(id: exampleGuildID)
        print("Guild name: \(guild.name)")
        print("Guild id: \(guild.id)")
        print("Guild Description: \(guild.description ?? "Unavailable")")
        print("Guild vanity URL: \(guild.vanityURLCode ?? "Unavailable")")
    }
    
    func testExampleUser() async throws {
        let bot = try initBot()
        guard let userID = enviroment["EXAMPLE_USER_ID"] else {
            throw TestErrors.enviromentVariableNotProvided(variableName: "EXAMPLE_USER_ID")
        }
        let userDetails = try await bot.fetchUser(id: userID)
        print("Username: \(userDetails.username)")
        print("User discriminator: \(userDetails.discriminator)")
        print("User verified email: \(userDetails.hasVerifiedEmail ?? true)")
        print("User bio: \(userDetails.bio ?? "unavailable")")
    }
    
    func testBanUser() async throws {
        let bot = try initBot()
        guard let userID = enviroment["USER_ID_BAN_TEST"] else {
            throw TestErrors.enviromentVariableNotProvided(variableName: "USER_ID_BAN_TEST")
        }
        guard let exampleGuild = enviroment["GUILD_ID_BAN_TEST"] else {
            throw TestErrors.enviromentVariableNotProvided(variableName: "GUILD_EXAMPLE_BAN_ID")
        }
        try await bot.ban(userID: userID, guildID: exampleGuild)
    }
    
    func testUnbanUser() async throws {
        let bot = try initBot()
        guard let userID = enviroment["USER_ID_UNBAN_TEST"] else {
            throw TestErrors.enviromentVariableNotProvided(variableName: "USER_ID_UNBAN_TEST")
        }
        guard let exampleGuild = enviroment["GUILD_ID_UNBAN_TEST"] else {
            throw TestErrors.enviromentVariableNotProvided(variableName: "GUILD_ID_UNBAN_TEST")
        }
        try await bot.unban(userID: userID, guildID: exampleGuild)
    }
}
