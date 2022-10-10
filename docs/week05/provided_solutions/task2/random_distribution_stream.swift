//
//  random_distribution_stream.swift
//  cse22a_week05_task2
//
//

import Foundation

/// This is a generic struct that allows for the creation of any
/// random distribution stream.
///
/// The values produced by this stream are determined by the interaction of
/// the provided definition data and the behavior closure.
///
struct RandomDistSequence: Sequence, IteratorProtocol {
    let definitionData: [String: Any]
    // Some distributions don't need any data. That's why the parameter is an optional
    var resultCount: Int?
    /// This optional value will limit the sequence to a specific number of results, then return Nil after that.
    /// If this is set to Nil, then a for...in loop using this sequence will never automaticlaly terminate.
    let behavior: ([String: Any]) -> Any
    /// A function to get another random value
   ///
    /// This function's return value is determined by the calculations defined in
    /// the behavior closure as it uses the definition data as defined for each type of
    /// distribution
    ///
    /// - Returns: a value
    /// - Complexity: O(1) plus the complexity of the behavior closure
    mutating func next() -> Any? {
         // if resultCount is defined, make sure it is still >0 and decrement it
        guard let c = resultCount, c > 0 else {
            return nil
        }
        if let c = resultCount {resultCount = c - 1} // decrement resultCount if used
        return behavior(definitionData)
    }
}
