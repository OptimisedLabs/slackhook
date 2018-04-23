import Foundation

public struct Attachment: Codable {
    let colour: Colour?
    let text: String?
    let title: String?
    let markdownUsedIn: [MarkDownUsage]?
    let fields: [Field]?
    
    public enum Colour: String, Codable {
        /// Indicator to the left of attachment will be greenish
        case good
        
        /// Indicator to the left of attachment will be yellowish
        case warning
        
        /// Indicator to the left of attachment will be reddish
        case danger
    }
    
    public enum MarkDownUsage: String, Codable {
        /// The text contains MarkDown
        case text
        
        /// One or more fields make use of MarkDown
        case fields
    }
}

extension Attachment {
    enum CodingKeys: String, CodingKey {
        case colour = "color"
        case text
        case title
        case markdownUsedIn = "mrkdwn_in"
        case fields
    }
}