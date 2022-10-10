//
//  main.swift
//  cse22a_week05_task2
//
//

import Foundation

// setup of the triangular distribution stream
let triangularDefinition = ["leastValue": 0, "greatestValue": 1, "peakValue": 0.22]
let triangularDistSequence = RandomDistSequence(definitionData: triangularDefinition, resultCount: 10) { definitionData in
    let leastValue = (definitionData["leastValue"] as? Double) ?? 1
    let greatestValue = (definitionData["greatestValue"] as? Double) ?? 1
    let peakValue = (definitionData["peakValue"] as? Double) ?? 1

    let u = Double.random(in: leastValue ... greatestValue)
    let v = Double.random(in: leastValue ... greatestValue)
    // there was no change to the stored data, therefore
    return (1 - peakValue) * min(u, v) + peakValue * max(u, v)
}

// exercising the triangular stream
print("Triangular")
for result in triangularDistSequence {
    print("\t\(result)")
}

// setup of the logarithmic distribution stream
let logarithmicDefinition = ["p": 0.85]
let logarithmicDistSequence = RandomDistSequence(definitionData: logarithmicDefinition, resultCount: 20) {
    definitionData in
    let p = (definitionData["p"] as? Double) ?? 1
    let x = Double.random(in: 0 ..< 1)
    return pow(p, x) / (-x * log(1 - p))
}

// exercising the logarithmic stream
print("Logarithmic")
for result in logarithmicDistSequence {
    print("\t\(result)")
}
