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

//  Task 3
//  The following enums define cell contents for a simple 2-dimensional spreadsheet.
//  Each cell can contain an element of type Values that can be simple values,
//  operators or references to another cell. The Values with operators can recursively
//  contain values with other operators. FYI, the enum is marked indirect to let the
//  comopiler know that we deliberately defined a recursive enum. Since the
//  compiler cannot determine the size of a member of the enum at compile time,
//  the compiler must know to store values of that Type indirectly (by reference
//  rather than by value).
//
//  Your assignment is to write code in task4() and probably some other functions
//  you will define that will evaluate a spreadsheet containing cells of type Values and
//  return a two-dimensional array of the same Type, but with fully evaluated cells
//  that contains no values of .unary, .binary or .ref.
//  In evaluating a cell, the following rules apply:
//      1) If an operator has invalid operatnds, produce a descriptive error for that cell
//      2) Some operators do not make sense as unary, but may appear in the spreadsheet and should produce a descriptive error
//      3) If an operator has only Int operands, produce an Int, except divide should produce an exact Int if possible and a Double otherwise
//      4) A reference outside the dimensions of the array should produce a descriptive error
//      5) You need to detect circular references and produce a descriptive error in each cell in the referene loop
//
//  We recommend that you set up two Dictionaries, one for unary and one for binary
//  operators that have the operators as the key and closures as the value.
//  We have provided typealiases to help you define those dictionaries.
////  You will probably find it useful to use throw-catch to handle error
////  values since they may be detected down a recursive operator chain.
//  Hint: You may find it easier to detect circular references
//  in a separate part of your code from the other processing
//  that runs before the other processing.
//
//  Changing the return value of task4()) from nil to a result of Type [[ProcessedValues]] indicates you are ready for your spreadsheet
//  processor to be tested.
//
enum Operators: String, CustomStringConvertible {
    case plus // if either parameter is String, convert both to String and concatenate
    case minus
    case times
    case divide
    case square
    case reverse // only works for strings
    var description: String { return self.rawValue }
}
indirect enum Values: CustomStringConvertible {
    case int(Int)
    case double(Double)
    case string(String)
    case unary(Operators, Values)
    case binary(Values, Operators, Values)
    case ref(Int, Int) // reference to contents of cell at (column, row).
        // User oriented so 1 based meaning ref(1,1) is contents of top left cell
    case error(String)
    var description: String {
        switch self {
        case let .int(anInt): return ".int(\(anInt))"
        case let .double(aDouble): return ".double(\(aDouble))"
        case let .string(aString): return ".string(\"\(aString)\")"
        case let .unary(anOp, value): return "(\(anOp) \(value))"
        case let .binary(lhs, anOp, rhs): return "(\(lhs) \(anOp) \(rhs))"
        case let .ref(col, row): return ".ref(\(col), \(row))"
        case let .error(aString): return ".error: \(aString)"
        }
    }

}
typealias UnaryOperatorClosure = (Values) -> Values
typealias BinaryOperatorClosure = (Values, Values) -> Values

// EDITOR for tasks.swift delete the remainder of this file and leave
// a version of task3() that just returns nil
enum EvaluationErrors: Error {
    case cellError(String)
}
let unaryOperators: Dictionary<Operators, UnaryOperatorClosure> = [
    .plus : { (aValue) in
        return aValue  // unary plus does nothing
    },
    .minus : { (aValue) in
        switch aValue {
        case .int(let anInt):
            return .int(-anInt)
        case .double(let aDouble):
            return .double(-aDouble)
        default:
            return .error("unary minus not applicable to \(aValue)")
        }
    },
    .times : { (aValue) in
        return .error("times is not a unary operator")
    },
    .divide : { (aValue) in
        return .error("divide is not a unary operator")
    },
    .square : { (aValue) in
        switch aValue {
        case .int(let anInt):
            return .int(anInt * anInt)
        case .double(let aDouble):
            return .double(aDouble * aDouble)
        default:
            return .error("square not applicable to \(aValue)")
        }
    },
    .reverse : { (aValue) in
        switch aValue {
        case .string(let aString):
            return .string(String(aString.reversed()))
        default:
            return .error("reverse not applicable to \(aValue)")
        }
    }
]
let binaryOperators: Dictionary<Operators, BinaryOperatorClosure> = [
    //  I could write this more effeciently than covering each combination of cases,
    //  but it was easy to copy and paste once I set up .plus and I don't want to
    //  assume every stucent will figure out to convert the operands first and
    //  then process the operator to simplify the code. The rule for integer divide
    //  would still need special handling.
    .plus : { (lhs, rhs) in
        switch lhs {
        case .int(let lhsInt):
            switch rhs {
            case .int(let rhsInt):
                return .int(lhsInt + rhsInt)
            case .double(let rhsDouble):
                return .double(Double(lhsInt) + rhsDouble)
            case .string(let rhsString):
                return .string(String(lhsInt) + rhsString)
            default:
                 return .error("binary minus not applicable to rhs of \(rhs)")
            }
        case .double(let lhsDouble):
            switch rhs {
            case .int(let rhsInt):
                return .double(lhsDouble + Double(rhsInt))
            case .double(let rhsDouble):
                return .double(Double(lhsDouble + rhsDouble))
            case .string(let rhsString):
                return .string(String(lhsDouble) + rhsString)
            default:
                 return .error("binary minus not applicable to rhs of \(rhs)")
            }
        case .string(let lhsString):
            return .string(lhsString)
       default:
            return .error("binary minus not applicable to lhs of \(lhs)")
        }
    },
    .minus : { (lhs, rhs) in
        switch lhs {
        case .int(let lhsInt):
            switch rhs {
            case .int(let rhsInt):
                return .int(lhsInt - rhsInt)
            case .double(let rhsDouble):
                return .double(Double(lhsInt) - rhsDouble)
            default:
                 return .error("binary minus not applicable to rhs of \(rhs)")
            }
        case .double(let lhsDouble):
            switch rhs {
            case .int(let rhsInt):
                return .double(lhsDouble - Double(rhsInt))
            case .double(let rhsDouble):
                return .double(Double(lhsDouble - rhsDouble))
            default:
                 return .error("binary minus not applicable to rhs of \(rhs)")
            }
        case .string(let lhsString):
            return .string(lhsString)
       default:
            return .error("binary minus not applicable to lhs of \(lhs)")
        }
    },
    .times : { (lhs, rhs) in
        switch lhs {
        case .int(let lhsInt):
            switch rhs {
            case .int(let rhsInt):
                return .int(lhsInt * rhsInt)
            case .double(let rhsDouble):
                return .double(Double(lhsInt) * rhsDouble)
            default:
                 return .error("binary minus not applicable to rhs of \(rhs)")
            }
        case .double(let lhsDouble):
            switch rhs {
            case .int(let rhsInt):
                return .double(lhsDouble * Double(rhsInt))
            case .double(let rhsDouble):
                return .double(Double(lhsDouble * rhsDouble))
            default:
                 return .error("binary minus not applicable to rhs of \(rhs)")
            }
        case .string(let lhsString):
            return .string(lhsString)
       default:
            return .error("binary minus not applicable to lhs of \(lhs)")
        }
    },
    .divide : { (lhs, rhs) in
        switch lhs {
        case .int(let lhsInt):
            switch rhs {
            case .int(let rhsInt):
                if lhsInt % rhsInt == 0 {
                    return .int(lhsInt / rhsInt)
                } else {
                    return .double(Double(lhsInt) / Double(rhsInt))
                }
            case .double(let rhsDouble):
                return .double(Double(lhsInt) / rhsDouble)
            default:
                 return .error("binary minus not applicable to rhs of \(rhs)")
            }
        case .double(let lhsDouble):
            switch rhs {
            case .int(let rhsInt):
                return .double(lhsDouble / Double(rhsInt))
            case .double(let rhsDouble):
                return .double(Double(lhsDouble / rhsDouble))
            default:
                 return .error("binary minus not applicable to rhs of \(rhs)")
            }
        case .string(let lhsString):
            return .string(lhsString)
       default:
            return .error("binary minus not applicable to lhs of \(lhs)")
        }
    },
    .square : { (lhs, rhs) in
        return .error("square is not a binary operator")
    },
    .reverse : { (lhs, rhs) in
        return .error("reverse is not a binary operator")
    }
]
var aSheet: [[Values]] = []
func evaluate(_ value: Values) -> Values {
    switch value {
        case .int, .double, .string, .error: return value
    case let .unary(op, opValue):
        guard let closure = unaryOperators[op] else { return .error("Operator not in unaryOperators[]") }
        return closure(evaluate(opValue)) // pre-evaluate the operator so each closure does not need to
    case let .binary(lhs, op, rhs):
        guard let closure = binaryOperators[op] else { return .error("Operator not in binaryOperators[]") }
        return closure(evaluate(lhs), evaluate(rhs))  // pre-evaluate the operators so each closure does not need to
    case let .ref(col, row):
        guard row > 0, row <= aSheet.count else { return .error("row \(row) in reference not in range") }
        guard col > 0, col <= aSheet[row-1].count else { return .error("row \(row) in reference not in range") }
        aSheet[row][col] = evaluate(aSheet[row-1][col-1]) // make sure the cell is fully evaluated first
        return aSheet[row-1][col-1]
    }
}
func task3(_ theSheet: [[Values]]) -> ([[Values]])? {
    aSheet = theSheet
    // Check for circular loops first and put a value of .error in any circular cells
    
    // Now evaluate the spreadsheet
    for rowIndex in 0..<aSheet.count {
        for colIndex in 0..<aSheet[rowIndex].count {
            aSheet[rowIndex][colIndex] = evaluate(aSheet[rowIndex][colIndex])
        }
    }

    return aSheet
}
