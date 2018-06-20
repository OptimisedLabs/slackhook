import XCTest

extension MessageTests {
    static let __allTests = [
        ("testAttachmentWithColour", testAttachmentWithColour),
        ("testAttachmentWithFields", testAttachmentWithFields),
        ("testAttachmentWithMarkDown", testAttachmentWithMarkDown),
        ("testAttachmentWithText", testAttachmentWithText),
        ("testAttachmentWithTitle", testAttachmentWithTitle),
        ("testCompleteMessage", testCompleteMessage),
        ("testMessageWithUsername", testMessageWithUsername),
        ("testTextOnlyMessage", testTextOnlyMessage),
    ]
}

extension SlackHookTests {
    static let __allTests = [
        ("testInsecureWebhook", testInsecureWebhook),
        ("testSecureWebhook", testSecureWebhook),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MessageTests.__allTests),
        testCase(SlackHookTests.__allTests),
    ]
}
#endif
