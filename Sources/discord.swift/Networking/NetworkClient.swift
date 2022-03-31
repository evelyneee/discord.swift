
import Foundation

final public class NetworkClient {
    
    private var token: String
    
    init(_ token: String) {
        self.token = token
    }
    
    class AnyDecodable: Decodable {}

    enum NetworkErrors: Error, LocalizedError, CustomStringConvertible {
        case badResponseReturned(statusCode: Int, responseString: String?)
        
        var description: String {
            switch self {
            case .badResponseReturned(let statusCode, let responseString):
                return "Server unexpectadly returned status code \(statusCode) (should be between 200 and 299)\nResponse: \(responseString ?? "Unavailable")"
            }
        }
        
        var errorDescription: String? {
            description
        }
    }
    // MARK: - Perform request with completion handler

    func fetch<T: Decodable>(
        _: T.Type,
        url: URL,
        bodyObject: [String:Any]? = nil,
        headers: [AnyHashable:Any] = [:],
        decoder: JSONDecoder = .init()
    ) async throws -> T {
        try await fetch(T.self, request: URLRequest(url: url), bodyObject: bodyObject, headers: headers, decoder: decoder)
    }
    
    func fetch<T: Decodable>(
        _: T.Type,
        request req: URLRequest,
        bodyObject: [String:Any]? = nil,
        headers: [AnyHashable:Any] = [:],
        decoder: JSONDecoder = .init()
    ) async throws -> T {
        var request = req
        
        if request.url?.absoluteString.contains("https://discord.com/api") ?? false {
            request.addValue(self.token, forHTTPHeaderField: "Authorization")
        }
        
        if let bodyObject = bodyObject  {
            let body = try JSONSerialization.data(withJSONObject: bodyObject, options: [])
            request.httpBody = body
        }
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = headers
        let (data, response) = try await URLSession(configuration: config).data(for: request)
        
        if let response = response as? HTTPURLResponse {
            // make sure the status code returned is between 200 and 299
            guard (200...299) ~= response.statusCode else {
                throw NetworkErrors.badResponseReturned(statusCode: response.statusCode, responseString: String(data: data, encoding: .utf8))
            }
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
    func fetch(
        url: URL,
        with payloadJson: [String:Any]? = nil,
        fileURL: String? = nil,
        boundary: String = "Boundary-\(UUID().uuidString)",
        headers: [AnyHashable:Any] = [:]
    ) async throws -> (Data, URLResponse) {
        var request = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = headers
        
        // Set headers
        request.httpBody = try? self.createMultipartBody(with: try payloadJson?.jsonString(), fileURL: fileURL, boundary: boundary)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        return try await URLSession(configuration: config).data(for: request)
    }
    
    func createMultipartBody(
        with payloadJson: String?,
        fileURL: String? = nil,
        boundary: String = "Boundary-\(UUID().uuidString)",
        fileData: Data? = nil
    ) throws -> Data {
        var body = Data()
        
        body.append("--\(boundary)\r\n")
        
        if let payloadJson = payloadJson {
            body.append(
                "Content-Disposition: form-data; name=\"payload_json\"\r\nContent-Type: application/json\r\n\r\n"
            )
            body.append("\(payloadJson)\r\n")
        }
        
        if let fileURL = fileURL,
           let url = URL(string: fileURL) {
            let filename = url.lastPathComponent
            let data = try fileData ?? Data(contentsOf: url)
            let mimetype = url.mimeType()
            
            body.append("--\(boundary)\r\n")
            body.append(
                "Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n"
            )
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(data)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
}

extension Collection {
    func jsonString() throws -> String? {
        let data = try JSONSerialization.data(withJSONObject: self, options: [])
        let jsonString = String(data: data, encoding: .utf8)
        return jsonString
    }
}
