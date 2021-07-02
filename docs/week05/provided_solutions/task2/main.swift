//
//  main.swift
//  cse22a_week05_task2
//
//

import Foundation


//setup of the triangular distribution stream
let triangularDefinition = ["a":0, "b":1, "c":0.22]
let triangularDistStream = RandomDistStream(definitionData: triangularDefinition){ definitionData in
    let a = (definitionData["a"])! as! Double
    let b = (definitionData["b"])! as! Double
    let c = (definitionData["c"])! as! Double
    
    let u = Double.random(in: a...b)
    let v = Double.random(in: a...b)
    //there was no change to the stored data, therefore
    return(1-c)*min(u,v) + c*max(u, v)
}
//exercising the triangular stream
print("Triangular")
for _ in 0..<5{
    print("\t\(triangularDistStream.next())")
}

//setup of the logarithmic distribution stream
let logarithmicDefinition = ["p":0.85]
let logarithmicDistStream = RandomDistStream(definitionData: logarithmicDefinition){ definitionData in
    let p = (definitionData["p"])! as! Double
    let x = Double.random(in: 0..<1)
    return pow(p,x)/(-x * log(1-p))
}
//exercising the logarithmic stream
print("Logarithmic")
for _ in 0..<20{
    print("\t\(logarithmicDistStream.next())")
}
