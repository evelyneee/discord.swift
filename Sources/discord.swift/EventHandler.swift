
import Foundation
import Starscream

extension Bot {
    func handleEvent(_ event: WebSocketEvent) {
        switch event {
        case .connected(_):
            break
        case .disconnected(_, _):
            break
        case .text(let string):
            if let data = string.data(using: .utf8), let packet = try? JSONSerialization.jsonObject(with: data) as? [String:Any] {
                if let opcode = packet["op"] as? Int {
                    switch opcode {
                    case 10:
                        do {
                            let identify = try GatewayPackets.identify(token: token)
                            print(packet["d"])
                            self.socket.write(stringData: identify) {
                                print("[Gateway] Sent IDENTIFY")
                                self.status = .identified
                            }
                        } catch {
                            self.status = .failure(error)
                        }
                    default: break
                    }
                }
                switch packet["t"] as? String {
                case "READY": print(packet)
                default: break
                }
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
        case .reconnectSuggested(_):
            break
        case .cancelled:
            break
        }
    }
}
