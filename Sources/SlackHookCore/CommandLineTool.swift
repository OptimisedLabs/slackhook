import Foundation

public final class CommandLineTool {
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard arguments.count > 1 else {
            throw Error.missingWebHookURL
        }
        guard let slackHookURL = URL(string: arguments[1]),
            slackHookURL.scheme != nil,
            slackHookURL.host != nil else {
            throw Error.invalidWebHookURL
        }
        
        let slackHook = try SlackHook(from: slackHookURL)
        let message = Message(text: "Test message", username: "SlackHook", attachments: nil)
        try slackHook.post(message)
    }
}

extension CommandLineTool {
    enum Error: Swift.Error {
        case missingWebHookURL
        case invalidWebHookURL
    }
}
