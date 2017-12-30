import XCTest
@testable import SlackHook

class MessageTests: XCTestCase {
    #if os(Linux)
    let padding = ""
    #else
    let padding = " "
    #endif
    
    func testTextOnlyMessage() {
        let message = Message(text: "Hello World")
        let expectedJson = """
        {
          "text"\(padding): "Hello World"
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    func testMessageWithUsername() {
        let message = Message(text: "Hello World", username: "john")
        let expectedJson = """
        {
          "text"\(padding): "Hello World",
          "username"\(padding): "john"
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    static var allTests = [
        ("testTextOnlyMessage", testTextOnlyMessage),
        ("testMessageWithUsername", testMessageWithUsername),
    ]
}

extension Message {
    fileprivate func json() -> String {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dataEncodingStrategy = .base64
        jsonEncoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        
        return String(
            data: try! jsonEncoder.encode(self),
            encoding: .utf8
        )!
    }
}
