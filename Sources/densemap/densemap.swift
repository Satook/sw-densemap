
public class DenseMap<K: Comparable, V> {
  public typealias Keys = Array<K>
  public typealias Values = Array<V>
  public typealias Key = K
  public typealias Value = V

  @usableFromInline
  var _keys = Keys()

  @usableFromInline
  var _values = Values()

  public init() {}

  @inlinable
  public var capacity: Int {
    return _keys.capacity
  }
}

extension DenseMap: RandomAccessCollection, MutableCollection {
  public typealias Index = Int
  public typealias Indices = Range<Int>
  public typealias Iterator = IndexingIterator<DenseMap>

  @inlinable
  public var keys: [Key] {
    _keys
  }

  @inlinable
  public var values: [Value] {
    _values
  }

  @inlinable
  public var count: Int {
    _keys.count
  }

  @inlinable
  public var startIndex: Index {
    _keys.startIndex
  }

  @inlinable
  public var endIndex: Index {
    _keys.endIndex
  }

  @inlinable
  public func index(after idx: Index) -> Index {
    _keys.index(after: idx)
  }

  @inlinable
  public func distance(from: Index, to: Index) -> Int {
    _keys.distance(from: from, to: to)
  }

  public func index(forKey k: Key) -> Index? {
    switch (_keys.binarySearch(forElement: k)) {
    case .hit(let idx):
      return idx
    case .miss:
      return nil
    }
  }

  @inlinable
  public subscript(idx: Index) -> (key: Key, value: Value) {
    get {
      return (key: _keys[idx], value: _values[idx])
    }
    set (v) {
      _values[idx] = v.value
    }
  }

  public subscript(k: Key) -> Value? {
    get {
      let searchResult = _keys.binarySearch(forElement: k)

      switch (searchResult) {
      case .hit(let idx):
        return _values[idx]
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
    let searchResult = _keys.binarySearch(forElement: k)

    switch (searchResult) {
    case .hit(let idx):
      _values[idx] = v
    case .miss(let idx):
      _keys.insert(k, at: idx)
      _values.insert(v, at: idx)
    }
  }

  public func removeValue(forKey k: Key) {
    let searchResult = _keys.binarySearch(forElement: k)

    switch (searchResult) {
    case .hit(let idx):
      _keys.remove(at: idx)
      _values.remove(at: idx)
    default:
      break
    }
  }
}

/// constructors
public extension DenseMap {
  convenience init<S: Sequence>(_ s: S) where S.Element == (Key, Value) {
    self.init()

    for (k, v) in s {
      self[k] = v
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
      let slice = _keys[0..<_keys.count]

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

      _values[idx] = v
    }
  }

  func mergeUpdates<S: Sequence>(_ updates: S)
    where
      S.Element == (Key, Value) {

    for (k, v) in updates {
      if let idx = index(forKey: k) {
        _values[idx] = v
      }
    }
  }
}
