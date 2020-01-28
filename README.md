# densemap

Main export is the DenseMap<Key, Value> type that allows you to store mostly
contiguous runs of keys with their values in a cache-friendly way. It it built
for fast in-order queries and enumeration but insertion can be slow.

Some performance characteristics:
 - In-order enumeration: O(1)
 - Random item fetch: O(Log n)
 - Random inserts|deletes: O(n)
 - Inserting|Deleting on the high end: O(1)
