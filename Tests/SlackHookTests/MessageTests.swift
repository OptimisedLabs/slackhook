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
        let message = Message(text: "Hello World", username: "john", attachments: nil)
        let expectedJson = """
        {
          "text"\(padding): "Hello World",
          "username"\(padding): "john"
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    func testAttachementWithTitle() {
        let attachment = Attachment(colour: nil, text: nil, title: "Title", markdownUsedIn: nil)
        let message = Message(attachments: [attachment])
        let expectedJson = """
        {
          "attachments"\(padding): [
            {
              "title"\(padding): "Title"
            }
          ]
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    func testAttachementWithText() {
        let attachment = Attachment(colour: nil, text: "Text", title: nil, markdownUsedIn: nil)
        let message = Message(attachments: [attachment])
        let expectedJson = """
        {
          "attachments"\(padding): [
            {
              "text"\(padding): "Text"
            }
          ]
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    func testCompleteMessage() {
        let attachment1 = Attachment(colour: nil, text: nil, title: "Title1", markdownUsedIn: nil)
        let attachment2 = Attachment(colour: .good, text: "This is some text", title: "Title2", markdownUsedIn: [.fields])
        let attachment3 = Attachment(colour: .warning, text: nil, title: "Title3", markdownUsedIn: [.fields])
        let attachment4 = Attachment(colour: .danger, text: nil, title: "Title4", markdownUsedIn: nil)
        
        let message = Message(
            text: nil,
            username: "Custom Username",
            attachments: [attachment1, attachment2, attachment3, attachment4]
        )
        let expectedJson = """
        {
          "attachments"\(padding): [
            {
              "title"\(padding): "Title1"
            },
            {
              "color"\(padding): "good",
              "mrkdwn_in"\(padding): [
                "fields"
              ],
              "text"\(padding): "This is some text",
              "title"\(padding): "Title2"
            },
            {
              "color"\(padding): "warning",
              "mrkdwn_in"\(padding): [
                "fields"
              ],
              "title"\(padding): "Title3"
            },
            {
              "color"\(padding): "danger",
              "title"\(padding): "Title4"
            }
          ],
          "username"\(padding): "Custom Username"
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
        print(message.json())
    }
    
    static var allTests = [
        ("testTextOnlyMessage", testTextOnlyMessage),
        ("testMessageWithUsername", testMessageWithUsername),
        ("testAttachementWithTitle", testAttachementWithTitle),
        ("testAttachementWithText", testAttachementWithText),
        ("testCompleteMessage", testCompleteMessage),
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
