import XCTest
@testable import SlackHookCore

class SlackHookTests: XCTestCase {
    func testInsecureWebhook() {
        let url = URL(string: "http://hooks.slack.com/services/.../.../...")!
        XCTAssertThrowsError(try SlackHook(from: url), "Trying to initialise with an insecure URL should throw")
    }
    
    func testSecureWebhook() {
        let url = URL(string: "https://hooks.slack.com/services/.../.../...")!
        XCTAssertNoThrow(try SlackHook(from: url), "Trying to initialise with a secure URL should not throw")
    }
}
