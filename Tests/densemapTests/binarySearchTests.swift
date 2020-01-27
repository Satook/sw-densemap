import XCTest
@testable import densemap

final class binarySearchTests: XCTestCase {
  func testSearching() {
    let cases : [([Int], Int, Array<Int>.Index?)] = [
      ([], 1, nil),
      ([1], 1, 0),
      ([1,2], 1, 0),
      ([1,2,3], 1, 0),
      ([1,2,3], 2, 1),
      ([1,2,3], 3, 2),
      ([1,2,3], 0, nil),
      ([1,2,3,4,5,6,7], 1, 0),
      ([1,2,3,4,5,6,7], 3, 2),
      ([1,2,3,4,5,6,7], 4, 3),
      ([1,2,3,4,5,6,7], 6, 5),
      ([1,2,3,4,5,6,7], 7, 6),
      ([1,2,3,4,5,6,7], 0, nil),
      ([1,3,4,5,7], 1, 0),
      ([1,3,4,5,7], 3, 1),
      ([1,3,4,5,7], 7, 4),
      ([1,3,4,5,7], 2, nil),
    ]

    for (i, c) in cases.enumerated() {
      let got = c.0.binarySearch(forElement: c.1)
      let want = c.2

      XCTAssertEqual(got, want, "Case: \(i)")
    }
  }

  static var allTests = [
    ("testSearching", testSearching),
  ]
}
