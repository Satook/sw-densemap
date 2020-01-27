import XCTest
@testable import densemap

final class densemapTests: XCTestCase {
  func createMap() {
    let map = DenseMap()

    XCTAssertEqual(map.count, 0)
    XCTAssertGreaterThan(map.capacity, 0)
  }

  func addItem() {

  }

  static var allTests = [
    ("createMap", createMap),
  ]
}
