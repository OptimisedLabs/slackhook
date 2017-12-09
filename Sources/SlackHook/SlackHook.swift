import Foundation
import SimpleRESTLayer

public struct Slack {
    // MARK: - Properties
    private let URL: URL
    private let client = RESTClient()
    
    // MARK: - Initialiser
    public init(from URL: URL) throws {
        if URL.scheme != "https" { throw Error.webhookNotSecure }
        self.URL = URL
    }
    
    // MARK: - Instance methods
    public func post(_ message: Message) throws {
        var request = Request.with(method: .post, address: URL.absoluteString)
        try request.addJSONBody(message)
        client.execute(request: request) { (response: Response<Message>) in
            print("It probably worked™")
        }
    }
}

public struct Message: Codable {
    let text: String
    let username: String?
    
    public init(text: String, username: String? = nil) {
        self.text = text
        self.username = username
    }
}

public extension Slack {
    enum Error: Swift.Error {
        case webhookNotSecure
        case unexpectedResponse
    }
}
