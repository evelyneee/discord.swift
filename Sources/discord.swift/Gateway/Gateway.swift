
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
    internal var sessionID: String?
    internal var intents: Discord.Intents = []

    
    lazy var socket: WebSocket = {
        let request = URLRequest(url: Discord.Endpoints.gateway)
        return WebSocket(request: request)
    }()
    
    init(token: String, intents: Discord.Intents) {
        self.token = token
        self.intents = intents
    }
    
    private func send<C: Collection>(json packet: C) async throws {
        let data = try JSONSerialization.data(withJSONObject: packet, options: [])
        socket.write(stringData: data) {}
    }
    
    func identify() async throws {
        print(self.intents.rawValue)
        let packet: [String:Any] = [
            "op":2,
            "d":[
                "token":token,
                "intents": self.intents.rawValue,
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
    
    private func heartbeat() async throws {
        let packet: [String: Any] = [
            "op": 1,
            "d": seq,
        ]
        try await send(json: packet)
    }

    public func updatePresence(status: String, since: Int) async throws {
        let packet: [String: Any] = [
            "op": 3,
            "d": [
                "status": status,
                "since": since,
                "activities": [],
                "afk": false,
            ],
        ]
        try await send(json: packet)
    }

    public func reconnect(session_id: String? = nil, seq: Int? = nil) async throws {
        let packet: [String: Any] = [
            "op": 6,
            "d": [
                "seq": seq ?? self.seq,
                "session_id": session_id ?? sessionID ?? "",
                "token": self.token,
            ],
        ]
        try await send(json: packet)
    }

    public func subscribe(to guild: String) async throws {
        let packet: [String: Any] = [
            "op": 14,
            "d": [
                "guild_id": guild,
                "typing": true,
                "activities": true,
                "threads": true,
            ],
        ]
        try await send(json: packet)
    }

    public func memberList(for guild: String, in channel: String) async throws {
        let packet: [String: Any] = [
            "op": 14,
            "d": [
                "channels": [
                    channel: [[
                        0, 99,
                    ]],
                ],
                "guild_id": guild,
            ],
        ]
        try await send(json: packet)
    }

    public func subscribeToDM(_ channel: String) async throws {
        let packet: [String: Any] = [
            "op": 13,
            "d": [
                "channel_id": channel,
            ],
        ]
        try await send(json: packet)
        print("sent packet")
    }

    public func getMembers(ids: [String], guild: String) async throws {
        let packet: [String: Any] = [
            "op": 8,
            "d": [
                "limit": 0,
                "user_ids": ids,
                "guild_id": guild,
            ],
        ]
        try await send(json: packet)
    }
}
