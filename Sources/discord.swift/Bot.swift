
import Foundation
import Starscream

public class Bot {
    
    private (set) var token: String
    
    internal var intents: Discord.Intents
    internal var status: Gateway.Status = .idle
    public var gateway: Gateway
    public let client: NetworkClient
    
    public var onConnect: (() async throws -> Void)?
    
    /// Initializes a new instance with the specified Bot Token
    public init (token: String, intents: Discord.Intents = []) {
        self.token = token
        self.gateway = Gateway(token: token, intents: intents)
        self.client = NetworkClient(token)
        self.intents = intents
    }
    
    /// Initializes a new Bot instance from the `BOT_TOKEN` enviroment variable
    public convenience init?(intents: Discord.Intents = []) {
        guard let token = ProcessInfo.processInfo.environment["BOT_TOKEN"] else { return nil }
        self.init(token: token, intents: intents)
    }
    
    public func connect() async throws {
        self.gateway.socket.onEvent = gateway.handleEvent(_:)
        self.gateway.socket.connect()
        self.gateway.onConnect = self.onConnect
    }
    
}
