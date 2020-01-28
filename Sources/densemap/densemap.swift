
public struct DenseMap<Key: Comparable, Value> {
  typealias Keys = Array<Key>
  typealias Values = Array<Value>

  var keys = Keys()
  var values = Values()

  public var capacity: Int {
    return keys.capacity
  }

  public var count: Int {
    return keys.count
  }

  public subscript(k: Key) -> Value? {
    get {
      let searchResult = keys.binarySearch(forElement: k)

      switch (searchResult) {
      case .hit(let idx):
        return values[idx]
      case .miss:
        return nil
      }
    }
    set (v) {
      if let val = v {
        insertValue(val, forKey: k)
      } else {
        removeValue(forKey: k)
      }
    }
  }

  public mutating func insertValue(_ v: Value, forKey k: Key) {
    // see if our key is already here
    let searchResult = keys.binarySearch(forElement: k)

    switch (searchResult) {
    case .hit(let idx):
      values[idx] = v
    case .miss(let idx):
      keys.insert(k, at: idx)
      values.insert(v, at: idx)
    }
  }

  public mutating func removeValue(forKey k: Key) {
    let searchResult = keys.binarySearch(forElement: k)

    switch (searchResult) {
    case .hit(let idx):
      keys.remove(at: idx)
      values.remove(at: idx)
    default:
      break
    }
  }
}
