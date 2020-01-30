
@frozen
public struct DenseMap<K: Comparable, V> {
  public typealias Keys = Array<K>
  public typealias Values = Array<V>
  public typealias Index = Keys.Index
  public typealias Key = K
  public typealias Value = V

  @usableFromInline
  var keys = Keys()

  @usableFromInline
  var values = Values()

  public init() {}

  @inlinable
  public var capacity: Int {
    return keys.capacity
  }

  @inlinable
  public var count: Int {
    return keys.count
  }

  @inlinable
  public var startIndex: Index {
    keys.startIndex
  }

  @inlinable
  public var endIndex: Index {
    keys.endIndex
  }

  @inlinable
  public func index(after idx: Index) -> Index {
    keys.index(after: idx)
  }

  @inlinable
  public func distance(from: Index, to: Index) -> Int {
    keys.distance(from: from, to: to)
  }

  public func index(forKey k: Key) -> Index? {
    switch (keys.binarySearch(forElement: k)) {
    case .hit(let idx):
      return idx
    case .miss:
      return nil
    }
  }

  @inlinable
  public subscript(idx: Index) -> (key: Key, value: Value) {
    get {
      return (key: keys[idx], value: values[idx])
    }
    set (v) {
      values[idx] = v.value
    }
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
