import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(DensemapTests.allTests),
    testCase(binarySearchTests.allTests),
  ]
}
#endif
