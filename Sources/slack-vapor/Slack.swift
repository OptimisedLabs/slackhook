import Foundation
import HTTP
import TLS

public struct Slack {
    // MARK: - Properties
    private let uri: String
    private let client: Client
    
    // MARK: - Initialiser
    public init(from URL: URL) throws {
        if URL.scheme != "https" { throw Error.webhookNotSecure }
        self.uri = URL.path
        guard let scheme = URL.scheme, let host = URL.host else { throw Error.invalidWebhookURL }
        
        let socket = try TCPInternetSocket(
            scheme: scheme,
            hostname: host,
            port: 443
        )
        let context = try Context(.client)
        let tlsSocket = TLS.InternetSocket(socket, context)
        self.client = try TLSClient(tlsSocket)
    }
    
    // MARK: - Instance methods
    public func post(from username: String, message: String) throws {
        let request = Request(
            method: .post,
            uri: uri,
            headers: ["Content-Type": "application/x-www-form-urlencoded; charset=utf-8"]
        )
        let payload = """
        payload={"username":"\(username)","text":"\(message)"}
        """
        request.body = payload.urlQueryPercentEncoded.makeBody()
        
        let response = try execute(request)
        if response.status != .ok { throw Error.unexpectedResponse }
    }
    
    // MARK: - Private methods
    private func execute(_ request: Request) throws -> Response {
        let response: Response
        
        do {
            response = try client.respond(to: request)
        } catch (let error) {
            print("Request: \(request)")
            print("Error: \(error)")
            
            throw error
        }
        if response.status != .ok {
            print("Request: \(request)")
            print("Response: \(response)")
        }
        
        return response
    }
}

public extension Slack {
    enum Error: Swift.Error {
        case webhookNotSecure
        case invalidWebhookURL
        case unexpectedResponse
    }
}
