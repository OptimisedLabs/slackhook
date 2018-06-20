import XCTest
@testable import SlackHookCore

class CommandLineToolTests: XCTestCase {
    func testNoArgumentThrow() {
        let tool = CommandLineTool(arguments: [])
        
        XCTAssertThrowsError(try tool.run(), "Trying to initialise with no WebHook URL should throw")
    }
}
