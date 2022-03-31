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
    func testExampleGuild() async throws {
        guard let bot = Bot() else {
            throw TestErrors.enviromentVariableNotProvided(variableName: "BOT_TOKEN")
        }
        guard let exampleGuildID = ProcessInfo.processInfo.environment["EXAMPLE_GUILD_ID"] else {
            throw TestErrors.enviromentVariableNotProvided(variableName: "EXAMPLE_GUILD_ID")
        }
        let guild = try await bot.fetchGuild(id: exampleGuildID)
        print("Guild name: \(guild.name)")
        print("Guild id: \(guild.id)")
        print("Guild Description: \(guild.description ?? "Unavailable")")
        print("Guild vanity URL: \(guild.vanityURLCode ?? "Unavailable")")
    }
}
