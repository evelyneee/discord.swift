
import Foundation
import Starscream

public class Bot {
    
    private (set) var token: String
    internal var status: Gateway.Status = .idle
    
    // Initialize client from token
    public init (_ token: String) {
        self.token = token
    }
    
    // Initialize client from BOT_TOKEN env var
    public init? () {
        guard let token = ProcessInfo.processInfo.environment["BOT_TOKEN"] else { return nil }
        self.token = token
    }
    
    public func connect() async throws {
        self.socket.onEvent = handleEvent(_:)
        self.socket.connect()
    }
    
    lazy var socket: WebSocket = {
        let request = URLRequest(url: Discord.Endpoints.gateway)
        print("[Socket] Hello world!")
        return WebSocket(request: request)
    }()
    
}
