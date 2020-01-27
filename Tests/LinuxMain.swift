import XCTest

import densemapTests

var tests = [XCTestCaseEntry]()
tests += densemapTests.allTests()
tests += binarySearchTests.allTests()
XCTMain(tests)
