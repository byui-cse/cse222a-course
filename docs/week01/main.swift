//
//  main.swift
//  Installation Test
//
//  Created by Lee Barney on 6/21/21.
//  Edited by Chad Mitchell on 3/27/24.
//

import Foundation

/*
 * A predefined Array of ages
 */
var someAges = [3.4, 54.6, 21.7, 18.4]

printResults(result: calculateAverage(ages: someAges))

/*
 * clear the someAges Array and let the user enter some
 */
someAges = []

while true {
    print("Enter an age or 'done' to finish entering ages:")
    guard let numberAsString = readLine() else {
        continue
    }
    // check if the user is done entering ages
    guard numberAsString != "done" else {
        break
    }
    // make sure they entered a number
    guard let number = Double(numberAsString) else {
        print("\(numberAsString) is not a number")
        continue
    }
    someAges.append(number)
}

printResults(result: calculateAverage(ages: someAges))

func calculateAverage(ages: [Double]) -> (Bool, Double) {
    guard !ages.isEmpty else {
        return (false, -Double.infinity)
    }
    let sum = ages.reduce(0.0) {
        $0 + $1
    }
    return (true, sum / Double(ages.count))
}

func printResults(result: (Bool, Double)) {
    let (succeeded, averageAge) = result
    guard succeeded else {
        print("calculation failed")
        return
    }
    print("The average age is \(averageAge)")
}
