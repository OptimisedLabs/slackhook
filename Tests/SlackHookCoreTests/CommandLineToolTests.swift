import XCTest
@testable import SlackHookCore

class CommandLineToolTests: XCTestCase {
    func testNoArgument() {
        let tool = CommandLineTool(arguments: [])
        
        XCTAssertThrowsError(try tool.run(), "Trying to initialise with no WebHook URL should throw") { error in
            XCTAssertEqual(error as? CommandLineTool.Error, CommandLineTool.Error.missingWebHookURL, "Thrown error should be missingWebHookURL")
        }
    }
}
