import XCTest
@testable import SlackHookTests

XCTMain([
    testCase(SlackHookTests.allTests),
    testCase(MessageTests.allTests)
])
