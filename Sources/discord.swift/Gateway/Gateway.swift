
import Foundation
import Starscream

final public class Gateway {
    
    enum GatewayErrors: Error {
        case noStringData(String)
        case maxRequestReached
        case essentialEventFailed(String)
        case noSession
        case eventCorrupted
        case unknownEvent(String)
        case heartbeatMissed
        
        var localizedDescription: String {
            switch self {
            case .essentialEventFailed(let event):
                return "Essential Gateway Event failed: \(event)"
            case .noStringData(let string):
                return "Invalid data \(string)"
            case .maxRequestReached:
                return "Internal rate limit hit, you're going too fast!"
            case .noSession:
                return "Session missing?"
            case .eventCorrupted:
                return "Bad event sent"
            case .unknownEvent(let event):
                return "Unknown event: \(event)"
            case .heartbeatMissed:
                return "Heartbeat ACK missed"
            }
        }
    }
    
    enum Status {
        case ready
        case identified
        case failure(Error)
        case idle
    }
    
    private var token: String
    
    internal var interval: Int = 45000
    internal var seq: Int = 0
    
    lazy var socket: WebSocket = {
        let request = URLRequest(url: Discord.Endpoints.gateway)
        return WebSocket(request: request)
    }()
    
    init(token: String) {
        self.token = token
    }
    
    private func send<C: Collection>(json packet: C) async throws {
        let data = try JSONSerialization.data(withJSONObject: packet, options: [])
        socket.write(stringData: data) {}
    }
    
    func identify() async throws {
        let packet: [String:Any] = [
            "op":2,
            "d":[
                "token":token,
                "intents": 513,
                "properties": [
                    "$os": "macOS",
                    "$browser": "discord.swift",
                    "$device": "discord.swift"
                ]
            ]
        ]
        #if DEBUG
        log("~> IDENTIFY")
        #endif
        try await self.send(json: packet)
    }
}
