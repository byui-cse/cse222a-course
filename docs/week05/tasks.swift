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
    return nil // when ready to test, change this to "return true"
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
    return nil
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
    return nil
}

//  Task 3
//  Most of you are vary familiar with spreadsheets which are basically two dimensional
//  arrays of cells. Each cell can contain a number or text or a formula. The formulas
//  can use numbers in the formula itself or they can reference the values of other cells.
//  THe spreadsheet software needs to evaluate each cell and figure out what number
//  or text to display. Let's simulate a simple spreadsheet and have you evaluate the
//  spreadsheet so it could be displayed a hypothetical user.
//
//  Together the enums ValueOrFormula and Operators define the contents of a cell in our
//  spreadsheet. Each cell can contain a .int, a .double, a .string, an .op (operation)
//  (with a lhs (left-hand-side), an Operator, and a rhs (right-hand-side)), a .ref
//  (reference to the contents of another cell) or an .error (with an assocated String).
//  The lhs and rhs of a operation cam themselves be anyting in ValueOrFormula
//  allowing the user to write more complex formulas.
//
//  For example, a user might type something like this into the firs row of a spreadsheet:
//      2               One String           @(2,1)
//  This would be represented internally like this:
//      [ .int(2), .string("One String"), .ref(2,1) ]
//  The first two cellls contain values. The thrid cell contains a reference to the
//  second cell so when we evaluata this row we would wind up with:
//      [ .int(2), .string("One String"),  .string("One String")]
//  and the user display would have something like this:
//      2               One String          One String
//
//  In the second row, the user might type something like this:
//      1.2 * 2         3.1 - @(1,1)        -7.4 + ( @(1,1) + @(3,1) )
//  We would represent that internally like this:
//     [ .op(.double(1.2), .times, .int(2)),
//              .op(.double(3.1), .minus, .ref(1,1)),
//              .op(.double(-7.4), .plus, .op(.ref(1,1), .plus, .ref(3,1))) ]
//  When we evaluate it, the result would be this:
//     [ .double(2.4)   .double(1.1)    .string("-7.42One String") ]
//
//  Your assignment is to write code in task4() and probably some other functions
//  you create that will evaluate a spreadsheet containing cells of type ValueOrFormula
//  and return an array of the same Type with fully evaluated cells with no .op nor .ref
//  values in the cells. The evaluation rules are as follows (in priority order):
//      1) If a cell contains an .int, .double, .string, or .error just leave it as-is
//      2) If either operand of any operator is a .error, the value of the operation is
//              same the .error
//      2) If either operand of .plus is a .string, convert both operators to strings
//              and concatenate the strings together
//      2) If either operand of the other three operators is a .string, the result
//              will be a descriptive .error
//      3) If the rhs of .divide evaluates to 0, the result will be a descriptive .error
//      4) If both operands of an operator are .int, the result should be .int except
//              for .divide. If both operands of .divide are .int the result should
//              be .int if the rhs divides into the lhs evenly and otherwise the
//              result should be .double
//      5) If one operand of an operator is a .double and the other operand is either
//              a .int or a .double convert both operands to Double before performing
//              the operation and the result is .double
//      6) A .ref reference has the evaluated value of the referenced cell. That means
//              as you evaluate the a cell that contains a reference, you will need to
//              evaluate the referenced cell before continuing to evaluate the current
//              cell containing the reference. So your evaluation function will need to
//              be recursive. Recursion is also needed since an operand of an operator
//              can itself contain a nested operator. If .ref refers to an call outside
//              the bounds of the spreadsheet, replace it with a descriptive .error.
//      7) Usually, you would need to detect and handle recursive loops where a chain
//              of references refers back to an earlier cell in the chain. We have
//              provided a routine called removeCicrular that turns all cells in a
//              recursive loop of references into descriptive .errors so you do not
//              need to handle those cases.
//
//  Note: When we code user facing software, we must remember to represent things
//  the way the user expects to see them, not the way we would normally handle
//  and represent them internal to our code. For that reason .ref is 1 based, not
//  0 based so (1,1) refers to the top left cell. Your bounds checkiong needs to
//  take that into account. Also, while we internally refer to arrays with row
//  first like "anArray[row][column]", Spreadsheet users expect to refer to
//  a cell in Column,Row order so that is how .ref(col,row) is used. Be careful
//  to adjust for the 1 based references and for the use of the column,row
//  ordering inside a .ref or your code may may give you interesting crashes.
//
//  We recommend that you set up a Dictionary to help you evaluate operators
//  with a key of type Operators and a value that is a closure to evaluate that
//  Oparator. We provide a typealias for the closure to help you define that
//  Dictionary. We have also provided a function printSheet() that will print a
//  spreadsheet in a format that is easier to read and more meaningful than
//  the default printout you would get from just calling testPrint(). We
//  also defined discription and userDescription properties for the two
//  types and made them comply with CustomStringConvertible to help us
//  print more descriptive information about them.
//
//  Changing the the last line of task3() from "return nil" to instead say
//  return resultSheet will indicate that you are ready to have the code
//  in main.swift test your evaluation of the input spreadsheet
//  stored in resultSheet.
//
enum Operators: String, CustomStringConvertible {
    case plus // if either parameter is String, convert both to String and concatenate
    case minus
    case times
    case divide

    var description: String { return self.rawValue }
    // this is used to print the user view of the spreadsheet
    var userDescription: String {
        switch self {
            case .plus: return " + "
            case .minus: return " - "
            case .times: return " * "
            case .divide: return " / "
        }
    }
}
//  Because ValueOrFormula has associated values of type ValueOrFormula
//  it is a recursive Type. That means that the compiler cannot determine
//  at runtime the size of a particualr value of ValueOrFormula. To address
//  this, we must mark the type "indirect" which causes it to be used
//  by reference like a class rather than by value like a typical enum.
indirect enum ValueOrFormula: CustomStringConvertible {
    case int(Int)
    case double(Double)
    case string(String)
    case op(ValueOrFormula, Operators, ValueOrFormula)
    case ref(Int, Int) // reference to contents of cell at (column, row).
        // User oriented so 1 based meaning ref(1,1) is contents of top left cell
    case error(String)

    var description: String {
        switch self {
        case let .int(anInt): return ".int(\(anInt))"
        case let .double(aDouble): return ".double(\(aDouble))"
        case let .string(aString): return ".string(\(aString))"
        case let .op(lhs, anOp, rhs): return "(\(lhs) \(anOp) \(rhs))"
        case let .ref(col, row): return ".ref(\(col), \(row))"
        case let .error(aString): return ".error(\(aString))"
        }
    }
    // this is used to print the user view of the spreadsheet
    var userDescription: String {
        switch self {
        case let .int(anInt): return "\(anInt)"
        case let .double(aDouble): return "\(aDouble)"
        case let .string(aString): return "\"\(aString)\""
        case let .op(lhs, anOp, rhs): return lhs.userDescription + anOp.userDescription + rhs.userDescription
        case let .ref(col, row): return "@(\(col), \(row))"
        case let .error(aString): return "Error: \"\(aString)\""
        }
    }
    static func == (lhs: ValueOrFormula, rhs: ValueOrFormula) -> Bool {
        return lhs.description == rhs.description
    }
}
// This defines the type we use for our spreadsheet
typealias Spreadsheet = [[ValueOrFormula]]
// This defines a closure Type you might use as the value in a Dictionary
typealias OperatorClosure = (ValueOrFormula, ValueOrFormula) -> ValueOrFormula

//  The following two functions are defined in main.swift, but can be used here
//  func printSheet(_ aSheet: Spreadsheet, userView: Bool = false)
//  func removeCircularReferences(_ aSheet: Spreadsheet) -> Spreadsheet

//  This is where you will build your return value after we remove
//  circular references from it
var resultSheet: Spreadsheet = []

func task3(_ theSheet: Spreadsheet) -> (Spreadsheet)? {
    resultSheet = removeCircularReferences(theSheet)

    return nil
}
    
