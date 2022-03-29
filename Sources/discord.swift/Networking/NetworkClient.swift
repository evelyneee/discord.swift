
import Foundation

final public class NetworkClient {
    
    private var token: String
    
    init(_ token: String) {
        self.token = token
    }
    
    class AnyDecodable: Decodable {}

    enum FetchErrors: Error {
        case invalidRequest
        case invalidForm
        case badResponse(URLResponse)
        case badHTTPResponse(HTTPURLResponse)
        case notRequired
        case decodingError(String, Error?)
        case noData
        case discordError(code: Int?, message: String?)
    }

    struct DiscordError: Decodable {
        var code: Int
        var message: String?
    }

    // MARK: - Perform request with completion handler

    func fetch<T: Decodable>(
        _: T.Type,
        request: URLRequest? = nil,
        url: URL? = nil,
        headers: [AnyHashable:Any] = [:],
        decoder: JSONDecoder = .init()
    ) async throws -> (T, URLResponse) {
        var request: URLRequest? = {
            if let request = request {
                return request
            } else if let url = url {
                return URLRequest(url: url)
            } else {
                print("You need to provide a request method")
                return nil
            }
        }()
        
        if request?.url?.absoluteString.contains("https://discord.com/api") ?? false {
            request?.addValue(self.token, forHTTPHeaderField: "Authorization")
        }
        
        guard let request = request else { throw FetchErrors.invalidRequest }
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = headers
        let (data, response) = try await URLSession(configuration: config).data(for: request)
        let decoded = try decoder.decode(T.self, from: data)
        return (decoded, response)
    }
    
    func fetch(
        url: URL?,
        with payloadJson: [String:Any]? = nil,
        fileURL: String? = nil,
        boundary: String = "Boundary-\(UUID().uuidString)",
        headers: [AnyHashable:Any] = [:]
    ) async throws -> (Data, URLResponse) {
        let request: URLRequest? = {
            if let url = url {
                return URLRequest(url: url)
            } else {
                print("You need to provide a request method")
                return nil
            }
        }()
        guard var request = request else { throw FetchErrors.invalidRequest }
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
