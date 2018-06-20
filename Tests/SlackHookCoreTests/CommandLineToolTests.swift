import XCTest
@testable import SlackHookCore

class CommandLineToolTests: XCTestCase {
    func testNoArgument() {
        let tool = CommandLineTool(arguments: [])
        
        XCTAssertThrowsError(try tool.run(), "Trying to initialise with no WebHook URL should throw") { error in
            XCTAssertEqual(error as? CommandLineTool.Error, CommandLineTool.Error.missingWebHookURL, "Thrown error should be missingWebHookURL")
        }
    }
    
    func testInvalidURL() {
        let tool = CommandLineTool(arguments: ["executable", "not-a-url"])
        
        XCTAssertThrowsError(try tool.run(), "Trying to initialise with invalid WebHook URL should throw") { error in
            XCTAssertEqual(error as? CommandLineTool.Error, CommandLineTool.Error.invalidWebHookURL, "Thrown error should be invalidWebHookURL")
        }
    }
    
    func testSendingDemoMessage() {
        let tool = CommandLineTool(arguments: ["executable", "https://hooks.slack.com/services/..."])
        
        XCTAssertNoThrow(try tool.run(), "Should send a demo message")
    }
}
