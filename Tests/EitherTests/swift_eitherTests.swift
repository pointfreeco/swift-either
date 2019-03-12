import XCTest
import Either

final class swift_eitherTests: XCTestCase {
  func testExample() {
    let e = Either<Int, Bool>.in1(1)
    e.at1 { $0 + 1 }
  }

  static var allTests = [
    ("testExample", testExample),
  ]
}
