// ******** NOTES TO EDITOR OF tasksCompleted.swift and tasks.swift ******** //
//  Please make any changes to tasksCompleted.swift. This includes all the task code
//  but it also includes sample imlementation for testing. After you edit, lint, etc.
//  this file, copy the entire file to tasks.swift and then follow the indications in
//  in each task function to delete the sample code and just leave behind a stub.
//  Most of the time, that will just be "return nil" but in a few cases it shows
//  stub code that has a template in in for them to use. Finally, in tasks.swift
//  please delete this note to the editor in thie first 8 lines of the file.
//
//  Tasks.swift
//  Week 5 Tasks
//
//  You need to write code to complete the functions below to complete each task.
//  You can develop and test each function individually.
//  As long as a function returns nil, it is assumed to not be implemented.
//  Initially you may see some warnings about unused variables that you will address
//  when you impelement those functions.
//
//  You would usually use the print() function to write to the console and the
//  readline() function to read user input from the console. However, for this class,
//  please instead use testPrint() and testReadline(). Those will behave the same way,
//  but allow test code to see what you print and what is input from the user.
//
//  Due to the tests we need to perform, lines in main.swift may generate
//  warning errors. If you get an unexplained warning error from main.swift, please
//  check if there is a comment near that line saying to ignore warning errors.
//
import Foundation

//  Task 0 Assignment
//  One thing you will do a lot in almost any programming career is to
//  understand code written by other people. So first, as practice at reading
//  code, review the code below that implements randomWalk and try to
//  understand it. We usually try to set a good example by documenting our
//  code carefully, but for this we deliberately did not.
//
extension Range<Int> {
    func randomArray(_ size: Int) -> [Bound] {
        return (0..<size).map { _ in Int.random(in: self) }
    }
}
//  Need to do both Range and ClosedRange since they do not roll up to
//  a partent Type that can be extended this way
extension ClosedRange<Int> {
    func randomArray(_ size: Int) -> [Bound] {
        return (0..<size).map { _ in Int.random(in: self) }
    }
}

enum Steps {
    case start(Int, Int)
    case forward(Int)
    case backward(Int)
    case turnRight
    case turnLeft
    static var count:Int { get { 5 }}
}
func randomWalk(start: (Int, Int), count: Int, maxMove: Int) -> [Steps] {
    return [.start(start.0, start.1)] +
            (1..<Steps.count).randomArray(count).map {
        switch $0 {
        case 1: return Steps.forward(Int.random(in: 1...maxMove))
        case 2: return Steps.backward(Int.random(in: 1...maxMove))
        case 3: return Steps.turnLeft
        case 4: return Steps.turnRight
        default: return Steps.forward(0)
        }
    }
}
//
//  randomWalk(start:count:maxMove:) produces an array of enumeration values
//  wih a sequence of moves in a random walk in 2 dimensional space. The first
//  parameter is the starting point, the second is the count of moves desired
//  and the third is the maximum distance forward or backward in a single move.
//  Some of the enumeration values have associated values.
//
//  Assignment: task0() repeatedly calls randomWalk() followed by printWalk().
//  Your assignment is to add code in printWalk that interprets the array it
//  receives and uses testPrint to print the result in a single line as follows:
//      (Put a single space between each of the following items)
//      start: testPrint "S#,#" replacing # with the starting position numbers
//      forward or backward: testPrint "F#" or "B#" replacing # with the
//          distance
//      turnRight or turnLeft: testPrint "R#" and "L#" replacing # with the
//          direction faced after the turn using the numerals below
//      after the end of the array: testPrint "E#,#" with the ending position
//  The direction numerals are as follows:
//      0 moving to right, x incrementing, we start facing this direction
//      1 moving up, y incrementing
//      2 moving left, x decrementing
//      3 moving down, y incrementing
//  Note: we are using Cartesian coordinates where increasing y goes up. Most
//  of the time in programming screen graphics you are using screen
//  coordinates where increasing y goes down. Think about why the early
//  software designers may have decided to have increasing y go down on the
//  screen instead of going up as had been the tradition for centuries in
//  mathematics.
//
//  After you have completed coding printwalk() and are ready to test it,
//  change the last line in task0() from "return nil" to "return true".
//
func printwalk(theSteps: [Steps]) {
    // put your code here
    //  EDITOR for tasks.swift remove all of the code in this fucntion
    var location = (0, 0)
    var toPrint = ""
    var direction = 0
    let increments = [(1, 0), (0, 1), (-1, 0), (0, -1)]
    for step in theSteps {
        switch step {
        case .start(let h, let v):
            location = (h, v)
            toPrint += "S\(h),\(v)"
           break
        case .forward(let distance):
            location.0 += increments[direction].0
            location.1 += increments[direction].1
            toPrint += " F\(distance)"
            break
        case .backward(let distance):
            location.0 -= increments[direction].0
            location.1 -= increments[direction].1
            toPrint += " B\(distance)"
        case .turnRight:
            direction = (direction + 3) % 4
            toPrint += " R\(direction)"
           break
        case .turnLeft:
            direction = (direction + 1) % 4
            toPrint += " L\(direction)"
            break
       }
    }
    toPrint += " E\(location.0),\(location.1)"
    testPrint(toPrint)
}
func task0() -> Bool? {
    //  Do not edit anyting inside task0() except to change the last line
    //  from "return nil" to "return true" to start testing
    for _ in 0..<5 {
        let someSteps = randomWalk(
            start: (Int.random(in:-10...10), Int.random(in:-10...10)),
                               count: Int.random(in:5...15),
                               maxMove: Int.random(in:1...5))
        saveWalk(someSteps) // do not remove this line
        printwalk(theSteps: someSteps)
    }
    //  EDITOR for tasks.swift change this to "return nil" but do
    //  not change anything else inside task0()
    return true // when ready to test, change this to "return true"
}

//  Task 1 Assignment
//  This task is to simulate the implementation of a function or utility that
//  sometimes throws an an error condition to the caller. The Task1() function
//  will be called repeatedly with Arrays of optional Ints. Your assignment is
//  to return nil or an Int as follows:
//      If none of the values in the input array are nil return the sum of the
//      Array.
//      If any values are nil throw an error using .nilValueAt with the (0
//          based) index of the first nil value in the array.
//
//  By changing the return value of task1() from nil to the sum of the array
//  you are indicating that the test code should start testing this task.
//
enum task1ErrorType: Error {
    case nilValueAt(Int)
}
func task1(_ someInts: [Int?]) throws -> Int? {
//    return nil
//  EDITOR for tasks.swift remove all of the remaining code in this function
//  and just leave "return nil"
    var returnValue = 0
    for index in 0..<someInts.count {
        guard let anInt = someInts[index] else {
            throw task1ErrorType.nilValueAt(index)
        }
        returnValue += anInt
    }
    return returnValue
}

//  Task 2 Assignment
//  Sometimes you will call a function in a module that you do not control.
//  And sometimes those functions will indicate that they can throw errors.
//  Task2 will be called with an array of Ints and a function that takes and
//  returns an Int. Your assignmnent is to add code to Task2 that loops through
//  the array parameter and passes the values one by one to the function summing
//  the returned values. The complication is that the function can throw an
//  error, most of which will be of Type Task2ErrorType. To handle that
//  situation you need to implement Do-Try-Catch inside your loop so that you
//  can catch errors and recover from a thrown error and continue processing the
//  array. When an error is caught, testPrint "Error:" followed by the name of
//  of the error and the associated value (if there is one). For example:
//      Error: errorWithInt 7
//
//  Once you catch and testPrint an error of type Task2ErrorType, continue the
//  loop to process the next Int in the Array. However, if you catch a "generic"
//  error that is not in Type Task2ErrorType, you should "throw error" which
//  forwards the error up the call chain to let some other function handle it.
//  This is a typical pattern where the errors a function does not understand or
//  know how to handle are forwarded up the call chain.
//
//  When you change the return value of task2 from returning nil to instead
//  return the sum of values returned by the parameters function, that will
//  signal he test code to test your function.
//
enum Task2ErrorType: Error {
    case someError
    case errorWithInt(Int)
    case errorWithString(String)
    case errorWithDouble(Double)
}
typealias throwingFunction = (Int) throws -> Int

func task2(intArray: [Int], canThrow: throwingFunction) throws -> Int? {
    // return nil
    // EDITOR replace all the code in this function with "return nil"
    var sum = 0
    for anInt in intArray {
        do {
            sum += try canThrow(anInt)
        } catch Task2ErrorType.someError {
            testPrint("Error: someError")
        } catch Task2ErrorType.errorWithInt(let errorInt) {
            testPrint("Error: errorWithInt \(errorInt)")
        } catch Task2ErrorType.errorWithString(let errorString) {
            testPrint("Error: errorWithString \(errorString)")
        } catch Task2ErrorType.errorWithDouble(let errorDouble) {
            testPrint("Error: errorWithDouble \(errorDouble)")
        } catch {
            throw error
        }
    }
    return sum
}

// The following are placeholders for the mini-project

func task3() -> Bool? {
    return nil
}


func task4() -> Bool? {
    return nil
}
