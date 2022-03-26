
import Foundation
import Starscream

public class Bot {
    
    private (set) var token: String
    internal var status: Gateway.Status = .idle
    public var gateway: Gateway
    
    // Initialize client from token
    public init (_ token: String) {
        self.token = token
        self.gateway = Gateway(token: token)
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
