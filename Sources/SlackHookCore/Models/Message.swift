import Foundation

public struct Message: Codable {
    public let text: String?
    public let username: String?
    public let attachments: [Attachment]?
    
    public init(text: String?, username: String?, attachments: [Attachment]?) {
        self.text = text
        self.username = username
        self.attachments = attachments
    }
    
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
