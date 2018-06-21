import Foundation

public struct Field: Codable {
    public let title: String
    public let value: String
    public let short: Bool
    
    public init(title: String, value: String, short: Bool = true) {
        self.title = title
        self.short = short
        self.value = value
    }
}
