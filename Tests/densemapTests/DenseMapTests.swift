import XCTest
@testable import densemap

enum TestError: Error {
case sillyOne(String)
}

final class DensemapTests: XCTestCase {
  var map = DenseMap<UInt16, String>()

  func testCreateMap() {
    XCTAssertEqual(map.count, 0)
    XCTAssertGreaterThan(map.capacity, -1)
  }

  func testAddItem() {
    map[1] = "Testing"

    XCTAssertEqual(map.count, 1)
    XCTAssertEqual(map[1], "Testing")
  }

  func testOrdering() {
    map[1] = "one"
    map[12] = "twelve"
    map[5] = "five"
    map[13] = "thirteen"

    let want = ["one", "five", "twelve", "thirteen"]

    XCTAssertEqual(map.values, want)
  }

  func testIndexingEmpty() {
    XCTAssertEqual(map.startIndex, map.endIndex)
  }

  func testIndexingOne() throws {
    map[111] = "Bilbo"

    let el = map[map.startIndex]
    XCTAssertEqual(el.key, 111)
    XCTAssertEqual(el.value, "Bilbo")
  }

  static var allTests = [
    ("testCreateMap", testCreateMap),
    ("testAddItem", testAddItem),
    ("testOrdering", testOrdering),
    ("testIndexingEmpty", testIndexingEmpty),
    ("testIndexingOne", testIndexingOne),
  ]
}
