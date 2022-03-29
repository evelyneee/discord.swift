
import Foundation

public let ENABLE_LINE_LOGGING: Bool = true
public let ENABLE_FILE_EXTENSION_LOGGING: Bool = false

public func log<T>(_ items: T..., file: String = #fileID, line: Int = #line, separator: String = " ") {
    let file = ENABLE_FILE_EXTENSION_LOGGING ?
        file.components(separatedBy: "/").last ?? "discord.swift" :
        file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? "discord.swift"
    let line = ENABLE_LINE_LOGGING ? ":\(String(line))" : ""
    log(items: items, file: file, line: line, separator: separator)
}

public func log<S: StringProtocol>(_ items: S?..., file: String = #fileID, line: Int = #line, separator: String = " ") {
    let items: [String] = items.map { $0 ?? "nil" }.compactMap { String($0) }
    let file = ENABLE_FILE_EXTENSION_LOGGING ?
        file.components(separatedBy: "/").last ?? "discord.swift" :
        file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? "discord.swift"
    let line = ENABLE_LINE_LOGGING ? ":\(String(line))" : ""
    log(items: items, file: file, line: line, separator: separator)
}

public func log(_ items: Any..., file: String = #fileID) {
    let file = ENABLE_FILE_EXTENSION_LOGGING ?
        file.components(separatedBy: "/").last ?? "discord.swift" :
        file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? "discord.swift"
    log(items: items, file: file)
}

public func log(_ item: Any, file: String = #fileID, line: Int = #line) {
    let file = ENABLE_FILE_EXTENSION_LOGGING ?
        file.components(separatedBy: "/").last ?? "discord.swift" :
        file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? "discord.swift"
    let line = ENABLE_LINE_LOGGING ? ":\(String(line))" : ""
    log(items: [item], file: file, line: line)
}

private func log<T>(items: [T], file: String, line: String? = nil, separator: String = " ") {
    var out = String()
    for item in items {
        if type(of: item) is AnyClass {
            out.append(String(reflecting: item))
        } else if let data = item as? Data {
            out.append(String(data: data, encoding: .utf8) ?? String(describing: item))
        } else {
            out.append(String(describing: item))
        }
        out.append(separator)
    }
    Swift.print("[\(file)\(line ?? "")]", out)
}
