import Foundation

public final class CommandLineTool {
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run(completionHandler: ((Swift.Error?) -> Void)? = nil) throws {
        guard arguments.count > 1 else {
            throw Error.missingWebHookURL
        }
        guard let slackHookURL = URL(string: arguments[1]),
            slackHookURL.scheme != nil,
            slackHookURL.host != nil else {
            throw Error.invalidWebHookURL
        }
        
        let slackHook = try SlackHook(from: slackHookURL)
        let attachements = [
            Attachment(colour: .good, text: "All is good", title: nil, markdownUsedIn: nil, fields: nil),
            Attachment(colour: .warning, text: nil, title: nil, markdownUsedIn: nil, fields: [Field(title: "Energy", value: "50%"), Field(title: "Light", value: "Low")]),
            Attachment(colour: .danger, text: "The `decoder` threw a few warning", title: "Possible problem", markdownUsedIn: [.fields], fields: nil)
        ]
        let message = Message(text: "👋🏻 from Swift", username: "SlackHook", attachments: attachements)
        try slackHook.post(message) { completionHandler?($0) }
    }
}

extension CommandLineTool {
    enum Error: Swift.Error {
        case missingWebHookURL
        case invalidWebHookURL
    }
}
