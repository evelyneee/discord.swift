
import Foundation
import Starscream

public class Bot {
    
    private (set) var token: String
    
    // Initialize client from token
    public init (_ token: String) {
        self.token = token
    }
    
    // Initialize client from BOT_TOKEN env var
    public init? () {
        guard let token = ProcessInfo.processInfo.environment["BOT_TOKEN"] else { return nil }
        self.token = token
    }
    
    var socket: WebSocket = {
        let request = URLRequest(url: Discord.Endpoints.gateway)
        return WebSocket(request: request)
    }()
}
