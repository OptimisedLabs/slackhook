import XCTest
@testable import slack_vapor

class slack_vaporTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(slack_vapor().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
