import Foundation

public struct Field: Codable {
    let title: String
    let short: Bool
    let value: String
    
    init(title: String, short: Bool = true, value: String) {
        self.title = title
        self.short = short
        self.value = value
    }
}
