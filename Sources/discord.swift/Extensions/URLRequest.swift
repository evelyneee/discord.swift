import Foundation

extension URLRequest {
    init(withURL url: URL, httpMethod: String = "GET") {
        var instance = URLRequest(url: url)
        instance.httpMethod = httpMethod
        self = instance
    }
}
