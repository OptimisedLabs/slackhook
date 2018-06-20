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
        
        print("WebHook URL: \(slackHookURL)")
    }
}

extension CommandLineTool {
    enum Error: Swift.Error {
        case missingWebHookURL
        case invalidWebHookURL
    }
}
