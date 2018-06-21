import Foundation

public struct Message: Codable {
    public var text: String?
    public var username: String?
    public var attachments: [Attachment]?
}

extension Message {
    public init(text: String) {
        self.text = text
        self.username = nil
        self.attachments = nil
    }
    
    public init(attachments: [Attachment]) {
        self.text = nil
        self.username = nil
        self.attachments = attachments
    }
}
