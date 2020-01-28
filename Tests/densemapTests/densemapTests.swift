import XCTest
@testable import densemap

final class densemapTests: XCTestCase {
  func testCreateMap() {
    let map = DenseMap<Int, String>()

    XCTAssertEqual(map.count, 0)
    XCTAssertGreaterThan(map.capacity, -1)
  }

  func testAddItem() {
    var map = DenseMap<Int, String>()

    map[1] = "Testing"

    XCTAssertEqual(map.count, 1)
    XCTAssertEqual(map[1], "Testing")
  }

  static var allTests = [
    ("testCreateMap", testCreateMap),
    ("testAddItem", testAddItem),
  ]
}
