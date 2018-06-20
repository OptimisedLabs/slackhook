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
    public func post(_ message: Message, completionHandler: @escaping (Error?) -> Void) throws {
        var request = Request.with(URL.absoluteString, method: .post)
        try request.addJSONBody(message)
        client.execute(request) { (result: Result<Data>) in
            switch result {
            case .success(_):
                completionHandler(nil)
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
}
