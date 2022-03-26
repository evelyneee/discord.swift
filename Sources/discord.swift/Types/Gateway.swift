
import Foundation
import Starscream

final class Gateway {
    enum Status {
        case ready
        case identified
        case failure(Error)
        case idle
    }
}
