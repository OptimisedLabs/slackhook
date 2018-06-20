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
    
    func testMessageSuccess() {
        let tool = CommandLineTool(arguments: ["executable", "https://httpbin.org/status/200"])
        
        let expect = expectation(description: "Expect successful POSTing")
        try! tool.run() { error in
            XCTAssertNil(error, "Should not error when able to send message")
            expect.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testMessageError() {
        let tool = CommandLineTool(arguments: ["executable", "https://httpbin.org/status/500"])
        
        let expect = expectation(description: "Expect failure POSTing")
        try! tool.run() { error in
            XCTAssertNotNil(error, "Should error when not able to send message")
            expect.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
}
