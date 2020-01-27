
public struct DenseMap<Key: Comparable, Value> {
  var ranges = [Range<Key>]()
  var values = [Value]()

  public init() {

  }

  public var capacity: Int {
    return 1
  }

  public var count: Int {
    return 0
  }

  public subscript(key: Key) -> Value {
    get {
      return values[0]
    }
    set {
    }
  }
}
