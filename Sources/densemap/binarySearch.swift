
public enum BinarySearchResult<T: Equatable>{
  // we found a match, here's it index
case hit(T)
  // we missed our find, but this is the insert point
case miss(T)
}

extension  BinarySearchResult: Equatable {
  public static func == (l: BinarySearchResult, r: BinarySearchResult) -> Bool {
    switch (l, r) {
    case (.hit(let lv), .hit(let rv)):
      return lv == rv
    case (.miss(let lv), .miss(let rv)):
      return lv == rv
    default:
      return false
    }
  }
}

extension RandomAccessCollection where
Element : Comparable {

  func binarySearch(forElement el: Element) -> BinarySearchResult<Index> {
    var lower = startIndex
    var upper = endIndex

    while lower < upper {
      let mid = index(lower, offsetBy: distance(from: lower, to: upper)/2)

      let v = self[mid]
      if v == el {
        return .hit(mid)
      } else if v < el {
        lower = index(mid, offsetBy: 1)
      } else {
        upper = mid
      }
    }

    return .miss(lower)
  }
}
