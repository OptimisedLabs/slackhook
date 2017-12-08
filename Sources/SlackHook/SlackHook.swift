import Foundation

public struct Slack {
    // MARK: - Properties
    private let URL: URL
    
    // MARK: - Initialiser
    public init(from URL: URL) throws {
        if URL.scheme != "https" { throw Error.webhookNotSecure }
        self.URL = URL
    }
    
    // MARK: - Instance methods
    public func post(from username: String, message: String) {
        // See https://gitlab.com/optimisedlabs/URLSessionRegression
        let session = URLSession(configuration: .default)

        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let payload = """
        payload={"username":"\(username)","text":"\(message)"}
        """
        let bodyData = payload.urlQueryPercentEncoded.data(using: .utf8)
        request.httpBody = bodyData
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil, let httpResponse = response as? HTTPURLResponse else {
                print("\(Error.unexpectedResponse): \(String(describing: error)) | Response: \(String(describing: response))")
                
                return
            }

            if httpResponse.statusCode != 200 {
                self.dump(request: request)
                self.dump(response: httpResponse)
            }
        }
        task.resume()
    }
    
    // MARK: - Private methods
    private func dump(_ text: String) {
        print("[SlackHook] \(text)")
    }
    
    private func dump(request: URLRequest) {
        dump("Request URL:\t\(request.httpMethod!) \(request.url!.absoluteString)")
        
        if let allHTTPHeaderFields = request.allHTTPHeaderFields, allHTTPHeaderFields.count > 0 {
            dump("Headers:\t\t\(allHTTPHeaderFields)")
        }
        
        if let data = request.httpBody, let body = String(bytes: data, encoding: .utf8) {
            dump("Body:\t\t\t\(body)")
        }
    }
    
    private func dump(response: HTTPURLResponse) {
        if let responseURL = response.url?.absoluteString {
            dump("Response URL:\t\(responseURL)")
        }
        dump("Status:\t\t\(response.statusCode)")
        
        if response.allHeaderFields.count > 0 {
            dump("Headers:")
            for (header, value) in response.allHeaderFields {
                dump("\t\t\t\t\(header): \(value)")
            }
        }
    }
}

public extension Slack {
    enum Error: Swift.Error {
        case webhookNotSecure
        case unexpectedResponse
    }
}

extension String {
    public var urlQueryPercentEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed ) ?? ""
    }
}
