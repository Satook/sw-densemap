
public class DenseMap<K: Comparable, V> {
  public typealias Keys = Array<K>
  public typealias Values = Array<V>
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
}

extension DenseMap: RandomAccessCollection, MutableCollection {
  public typealias Index = Int
  public typealias Indices = Range<Int>
  public typealias Iterator = IndexingIterator<DenseMap>

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

  public func insertValue(_ v: Value, forKey k: Key) {
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

  public func removeValue(forKey k: Key) {
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

/// Merge updates
public extension DenseMap {
  /// Merge in a set of updates
  func mergeSortedUpdates<S: Sequence>(_ updates: S)
    where
      S.Element == (Key, Value) {

    // get our first index and then search starting from there onwards
    var offset = 0
    for (k, v) in updates {
      let slice = keys[0..<keys.count]

      // this is the index relative to the base of the slice
      let relIdx: Int
      switch slice.binarySearch(forElement: k) {
      case .hit(let i):
        relIdx = i
      case .miss:
        continue
      }

      let idx = relIdx + offset
      offset = idx + 1

      values[idx] = v
    }
  }

  func mergeUpdates<S: Sequence>(_ updates: S)
    where
      S.Element == (Key, Value) {

    for (k, v) in updates {
      if let idx = index(forKey: k) {
        values[idx] = v
      }
    }
  }
}
