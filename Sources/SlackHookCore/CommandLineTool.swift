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
        
        print("WebHook URL: \(arguments[1])")
    }
}

public extension CommandLineTool {
    enum Error: Swift.Error {
        case missingWebHookURL
    }
}
