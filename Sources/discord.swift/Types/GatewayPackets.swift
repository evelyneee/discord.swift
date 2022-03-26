
import Foundation

enum GatewayPackets {
    static func identify(token: String) throws -> Data {
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
        return try JSONSerialization.data(withJSONObject: packet, options: [])
    }
}
