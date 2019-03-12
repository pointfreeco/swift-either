import XCTest

import EitherTests

var tests = [XCTestCaseEntry]()
tests += EitherTests.allTests()
XCTMain(tests)
