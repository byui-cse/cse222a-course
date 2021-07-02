//
//  random_distribution_stream.swift
//  cse22a_week05_task2
//
//

import Foundation

/// This is a generic struct that allows for the creation of any
/// random distribution stream.
///
///The values produced by this stream are determined by the interaction of
///the provided definition data and the behavior closure.
///
struct RandomDistStream {
    let definitionData:[String:Any]
    //Some distributions don't need any data. That's why the parameter is an optional
    let behavior:([String:Any])->Any
    /// A function to get another random value
    ///
    /// This function's return value is determined by the calculations defined in
    /// the behavior closure as it uses the definition data as defined for each type of
    /// distribution
    ///
    /// - Returns: a value
    /// - Complexity: O(1) plus the complexity of the behavior closure
    func next() -> Any {
        return behavior(definitionData)
    }
}
