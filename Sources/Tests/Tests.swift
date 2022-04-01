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
}
