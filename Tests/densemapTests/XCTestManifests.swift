import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(densemapTests.allTests),
    testCase(binarySearchTests.allTests),
  ]
}
#endif
