
import Foundation
import Starscream

public class Bot {
    
    private (set) var token: String
    
    internal var intents: Discord.Intents
    internal var status: Gateway.Status = .idle
    public var gateway: Gateway
    public let client: NetworkClient
    
    // Initialize client from token
    public init (_ token: String, intents: Discord.Intents = []) {
        self.token = token
        self.gateway = Gateway(token: token, intents: intents)
        self.client = NetworkClient(token)
        self.intents = intents
    }
    
    // Initialize client from BOT_TOKEN env var
    public convenience init? () {
        guard let token = ProcessInfo.processInfo.environment["BOT_TOKEN"] else { return nil }
        self.init(token)
    }
    
    public func connect() async throws {
        self.gateway.socket.onEvent = gateway.handleEvent(_:)
        self.gateway.socket.connect()
    }
    
}
