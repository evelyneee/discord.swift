
import Foundation

extension Discord {
    public struct Role: Codable {
        var id: String
        var name: String
        var color: Int?
        var position: Int
        var permissions: String?
    }
}
