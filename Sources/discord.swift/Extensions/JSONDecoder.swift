import Foundation

internal extension JSONDecoder {
    /// A JSONDecoder which is compatible with decoding JSON responses from discord containing Dates
    static var discordDateCompatible: JSONDecoder {
        let _decoder = JSONDecoder()
        _decoder.dateDecodingStrategy = .iso8601
        return _decoder
    }
}
