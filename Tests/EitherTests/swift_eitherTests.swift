import XCTest
@testable import swift_either

final class swift_eitherTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(swift_either().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
