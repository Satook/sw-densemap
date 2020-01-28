import XCTest
@testable import densemap

final class binarySearchTests: XCTestCase {
  func testSearching() {
    let cases : [([Int], Int, BinarySearchResult<Int>)] = [
      ([], 1, .miss(0)),
      ([1], 1, .hit(0)),
      ([1,2], 1, .hit(0)),
      ([1,2,3], 1, .hit(0)),
      ([1,2,3], 2, .hit(1)),
      ([1,2,3], 3, .hit(2)),
      ([1,2,3], 0, .miss(0)),
      ([1,2,3,4,5,6,7], 1, .hit(0)),
      ([1,2,3,4,5,6,7], 3, .hit(2)),
      ([1,2,3,4,5,6,7], 4, .hit(3)),
      ([1,2,3,4,5,6,7], 6, .hit(5)),
      ([1,2,3,4,5,6,7], 7, .hit(6)),
      ([1,2,3,4,5,6,7], 0, .miss(0)),
      ([1,3,4,5,7], 1, .hit(0)),
      ([1,3,4,5,7], 3, .hit(1)),
      ([1,3,4,5,7], 7, .hit(4)),
      ([1,3,4,5,7], 2, .miss(1)),
      ([1,3,4,5,7], 6, .miss(4)),
      ([1,3,4,5,7], 24, .miss(5)),
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
