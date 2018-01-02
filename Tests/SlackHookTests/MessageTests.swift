import XCTest
@testable import SlackHook

class MessageTests: XCTestCase {
    #if os(Linux)
    let padding = ""
    #else
    let padding = " "
    #endif
    
    func testTextOnlyMessage() {
        let text = "Hello World"
        let message = Message(text: text)
        let expectedJson = """
        {
          "text"\(padding): "\(text)"
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    func testMessageWithUsername() {
        let text = "Hello World"
        let message = Message(text: text, username: "john", attachments: nil)
        let expectedJson = """
        {
          "text"\(padding): "\(text)",
          "username"\(padding): "john"
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    func testAttachmentWithTitle() {
        let title = "Title"
        let attachment = Attachment(colour: nil, text: nil, title: title, markdownUsedIn: nil, fields: nil)
        let message = Message(attachments: [attachment])
        let expectedJson = """
        {
          "attachments"\(padding): [
            {
              "title"\(padding): "\(title)"
            }
          ]
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    func testAttachmentWithText() {
        let text = "Text"
        let attachment = Attachment(colour: nil, text: text, title: nil, markdownUsedIn: nil, fields: nil)
        let message = Message(attachments: [attachment])
        let expectedJson = """
        {
          "attachments"\(padding): [
            {
              "text"\(padding): "\(text)"
            }
          ]
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    func testAttachmentWithColour() {
        let text = "Life is good"
        let attachment = Attachment(colour: .good, text: text, title: nil, markdownUsedIn: nil, fields: nil)
        let message = Message(attachments: [attachment])
        let expectedJson = """
        {
          "attachments"\(padding): [
            {
              "color"\(padding): "good",
              "text"\(padding): "\(text)"
            }
          ]
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    func testAttachmentWithMarkDown() {
        let text = "_This_ is *really* ~good~ bad example `code`: ```print('Hello World')```"
        let attachment = Attachment(colour: nil, text: text, title: nil, markdownUsedIn: [.text], fields: nil)
        let message = Message(text: nil, username: nil, attachments: [attachment])
        let expectedJson = """
        {
          "attachments"\(padding): [
            {
              "mrkdwn_in"\(padding): [
                "text"
              ],
              "text"\(padding): "\(text)"
            }
          ]
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    func testAttachmentWithFields() {
        let shortField1 = Field(title: "Short 1", value: "Value 1")
        let shortField2 = Field(title: "Short 2", value: "Value 2")
        let longValue = "This field could be really large and span multiple lines"
        let longField = Field(title: "Long", short: false, value: longValue)
        let attachment = Attachment(colour: nil, text: nil, title: nil, markdownUsedIn: nil, fields: [shortField1, shortField2, longField])
        let message = Message(text: nil, username: nil, attachments: [attachment])
        let expectedJson = """
        {
          "attachments"\(padding): [
            {
              "fields"\(padding): [
                {
                  "short"\(padding): true,
                  "title"\(padding): "Short 1",
                  "value"\(padding): "Value 1"
                },
                {
                  "short"\(padding): true,
                  "title"\(padding): "Short 2",
                  "value"\(padding): "Value 2"
                },
                {
                  "short"\(padding): false,
                  "title"\(padding): "Long",
                  "value"\(padding): "\(longValue)"
                }
              ]
            }
          ]
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    func testCompleteMessage() {
        let text = "This is the message text"
        let attachmentText = "This is some text inside the attachment"
        
        let shortField1 = Field(title: "Short 1", value: "Value 1")
        let shortField2 = Field(title: "Short 2", value: "Value 2")
        let longValue = "This field could be really large and span multiple lines"
        let longField = Field(title: "Long", short: false, value: longValue)
        
        let attachment = Attachment(colour: .warning, text: attachmentText, title: "Title2", markdownUsedIn: [.fields], fields: [longField, shortField2, shortField1])
        let message = Message(text: text, username: "Custom Username", attachments: [attachment])
        let expectedJson = """
        {
          "attachments"\(padding): [
            {
              "color"\(padding): "warning",
              "fields"\(padding): [
                {
                  "short"\(padding): false,
                  "title"\(padding): "Long",
                  "value"\(padding): "\(longValue)"
                },
                {
                  "short"\(padding): true,
                  "title"\(padding): "Short 2",
                  "value"\(padding): "Value 2"
                },
                {
                  "short"\(padding): true,
                  "title"\(padding): "Short 1",
                  "value"\(padding): "Value 1"
                }
              ],
              "mrkdwn_in"\(padding): [
                "fields"
              ],
              "text"\(padding): "\(attachmentText)",
              "title"\(padding): "Title2"
            }
          ],
          "text"\(padding): "\(text)",
          "username"\(padding): "Custom Username"
        }
        """
        
        XCTAssertEqual(message.json(), expectedJson)
    }
    
    static var allTests = [
        ("testTextOnlyMessage", testTextOnlyMessage),
        ("testMessageWithUsername", testMessageWithUsername),
        ("testAttachmentWithTitle", testAttachmentWithTitle),
        ("testAttachmentWithText", testAttachmentWithText),
        ("testAttachmentWithColour", testAttachmentWithColour),
        ("testAttachmentWithMarkDown", testAttachmentWithMarkDown),
        ("testAttachmentWithFields", testAttachmentWithFields),
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
