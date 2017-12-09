import Foundation
import SimpleRESTLayer

public struct SlackHook {
    // MARK: - Properties
    private let URL: URL
    #if os(Linux)
    private let client = RESTClient(configuration: .default)
    #else
    private let client = RESTClient()
    #endif
    
    // MARK: - Initialiser
    public init(from URL: URL) throws {
        if URL.scheme != "https" { throw SlackError.webhookNotSecure }
        self.URL = URL
    }
    
    // MARK: - Instance methods
    public func post(_ message: Message) throws {
        var request = Request.with(method: .post, address: URL.absoluteString)
        try request.addJSONBody(message)
        client.execute(request: request) { (response: Response<RawResponse>) in
            switch response {
            case .success(_):
                break
            case let .failure(error):
                print("[SlackHook] Unable to post message, because of error: \(error)")
            }
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

enum SlackError: Error {
    case webhookNotSecure
}
