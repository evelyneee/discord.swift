
import Combine
import Foundation
import Starscream

extension Gateway {
    func handleEvent(_ event: WebSocketEvent) {
        Task.detached {
            switch event {
            case .connected(_): break
            case .disconnected(let reason, let code):
                log("Disconnected with code " + String(code) + " for reason: " + reason)
                if code != Starscream.CloseCode.normal.rawValue {
                    try await self.reconnect()
                }
            case .text(let string):
                if let data = string.data(using: .utf8) {
                    let event = try GatewayEvent(data: data)
                    try self.handleMessage(event: event)
                }
            case .binary(_):
                break
            case .pong(_):
                break
            case .ping(_):
                break
            case .error(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(let reconnect):
                if reconnect {
                    try await self.reconnect()
                }
            case .cancelled:
                break
            }
        }
    }
    
    func handleMessage(event: GatewayEvent) throws {
        switch event.op {
        case .heartbeatACK:
            #if DEBUG
            log("ACK success")
            #endif
            return
        case .reconnect:
            log("Reconnecting..")
        case .hello:
            log("[Gateway] <~ HELLO")
            let packet = try JSONSerialization.jsonObject(with: event.data, options: []) as? [String:Any]
            let d = packet?["d"] as? [String:Any]
            guard let interval = d?["heartbeat_interval"] as? Int else { return }
            self.interval = interval
            Task.detached {
                try await self.identify()
            }
        case .invalidSession: log(event.data)
        default: break
        }
        if let s = event.s {
            self.seq = s
        }
        switch event.t {
        case .messageACK: break
        case .sessionsReplace: break
        case .channelCreate: break
        case .channelUpdate: break
        case .channelDelete: break
        case .guildCreate: break
        case .guildDelete: break
        case .guildMemberAdd: break
        case .guildMemberRemove: break
        case .guildMemberUpdate: break
        case .guildMemberChunk: break
        case .guildMemberListUpdate: break
        case .inviteCreate: break
        case .inviteDelete: break
        case .messageCreate: break
        case .messageUpdate: break
        case .messageDelete: break
        case .messageReactionAdd: break
        case .messageReactionRemove: break
        case .messageReactionRemoveAll: break
        case .messageReactionRemoveEmoji: break
        case .presenceUpdate: break
        case .typingStart: break
        case .userUpdate: break
        case .channelUnreadUpdate: break
        case .threadListSync: break
        case .messageDeleteBulk: break
        case .applicationCommandUpdate: break
        case .applicationCommandPermissionsUpdate: break
        case .guildApplicationCommandsUpdate: break
        case .readySupplemental: break
        case .ready:
            #if DEBUG
            log("<~ READY")
            #endif
            let packet = try JSONSerialization.jsonObject(with: event.data, options: []) as? [String:Any]
            let d = packet?["d"] as? [String:Any]
            let sessionID = d?["session_id"] as? String
            self.sessionID = sessionID
            Task.detached {
                if let onConnect = self.onConnect {
                    try await onConnect()
                }
            }
            log(event.data)
        default: break
        }
    }
}
