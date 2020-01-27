
extension RandomAccessCollection where
Element : Comparable {
  func binarySearch(forElement el: Element) -> Index? {
    var lower = startIndex
    var upper = endIndex

    while lower < upper {
      let mid = index(lower, offsetBy: distance(from: lower, to: upper)/2)

      let v = self[mid]
      if v == el {
        return mid
      } else if v < el {
        lower = index(mid, offsetBy: 1)
      } else {
        upper = mid
      }
    }

    return nil
  }
}
