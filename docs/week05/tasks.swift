//
//  Tasks.swift
//  Week 5 Tasks
//
//  You need to write code to complete the functions below to complete each task.
//  You can develop and test each function individually, but some sequentially
//  depend on the prior tasks.
//  As long as a function returns nil, it is assumed to not be implemented.
//
//  You would usually use the print() function to write to the console and the
//  readline() function to read user input from the console. However, for this class,
//  please instead use testPrint() and testReadline(). Those will behave the same way,
//  but allow the test code to see what you print and what is input from the user.
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
func randomWalk(start: (Int, Int), numMoves: Int, maxMove: Int, twoDimensional: Bool = true) -> [Steps] {

    var rangeForSteps = (1..<Steps.count - 2)
    if twoDimensional { rangeForSteps = (1..<Steps.count) }

    return [.start(start.0, start.1)] +
        rangeForSteps.randomArray(numMoves).map {
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
//  Now that you have tried to understand the code above on your own, here is
//  a summary of what it does. You may want to review the code again after
//  reading the following explanation:
//
//  randomWalk(start:numSteps:maxMove:) produces an Array of enumeration values
//  wih a sequence of moves for a random walk in 2 dimensional space. The first
//  parameter is the starting point, the second is the number moves desired,
//  the third is the maximum distance forward or backward in a single move and
//  the fourth tells whether this is a one or two dimensional walk.
//  In the enum Type Steps, the first three values have associated values.
//
//  We use an extension to define a randomArray method for ranges that can
//  generate an Array of random elements chosen from that range. To be tidy,
//  we proivided extensions for both Range and ClosedRange since they do
//  not roll up to a parent Type that can be extended generically even
//  though we are only using an open range in this task. We then use
//  that to generate an Array of Ints corresponding to all values of Steps
//  except the "start" value (since we only use that one once at the beginning).
//
//  If it is not a two dimensional walk then we do not include turnRight and
//  turnLeft in our range from which to select the random steps.
//
//  We use map() and a switch statement to convert that Array of Ints to the
//  matching enum values.
//
//  Assignment: task0() repeatedly calls randomWalk() followed by printWalk().
//  Your assignment is to add code in printWalk that interprets the Array it
//  receives and uses testPrint to print in a single line the result of
//  actually doing that random walk, printing the moves as follows:
//      (Put a single space between each of the following items)
//      start: testPrint "S#,#" replacing # with the starting position numbers
//      forward or backward: testPrint "F#" or "B#" replacing # with the
//          distance
//      turnRight or turnLeft: testPrint "R#" and "L#" replacing # with the
//          direction faced after the turn using the direction numerals below
//      After the end of the Array: testPrint "E#,#" with the ending position
//  The direction numerals are as follows:
//      0 moving to right, x incrementing, we start facing this direction
//      1 moving up, y incrementing
//      2 moving left, x decrementing
//      3 moving down, y decrementing
//
//  Note: we are using Cartesian coordinates where increasing y goes up.
//  Most of the time in programming screen graphics you will use screen
//  coordinates where increasing y goes down. Pause for a moment and think
//  about why early software designers may have decided to have increasing
//  y go down on the screen instead of going up as had been the tradition
//  in mathematics for centuries before that time.
//
//  After you have completed coding printWalk() and are ready to test it,
//  change the last line in task0() from "return nil" to "return true".
//  As you have probably figured out, you can change trom nil to true
//  earlier if you want to start getting feedback on your work as you
//  proceed. For example, if you choose to do so and since the first
//  tests are one dimensional you can implement .start, .forward and
//  .backward first and test those, then implement turnRight and turnLeft.
//  It is usually good practice to break a problem into pieces and then
//  develop and test your code incrementally.
//
func printWalk(theSteps: [Steps]) {
    // put your code here
}
func task0() -> Bool? {
    //  Do not edit anything inside task0() except to change the last line
    //  from "return nil" to "return true" to start testing

    // First we will test a few one dimensional walks starting at (0, 0)
    for testNum in 0..<3 {
        let someSteps = randomWalk(
                                start: (0,0),
                                numMoves: Int.random(in:5...10),
                                maxMove: testNum + 1, // start with moves of 1, then 1..2, then 1..3
                                twoDimensional: false)
        saveWalk(someSteps) // do not remove this line, testing depends on it
        printWalk(theSteps: someSteps)
    }

    // Noe test some two dimenensional walks
    for _ in 0..<5 {
        let someSteps = randomWalk(
            start: (Int.random(in:-10...10), Int.random(in:-10...10)),
                                numMoves: Int.random(in:5...15),
                                maxMove: Int.random(in:1...5))
        saveWalk(someSteps) // do not remove this line, testing depends on it
        printWalk(theSteps: someSteps)
    }
    return nil // when ready to test, change this to "return true"
}

//  Task 1 Assignment
//  This task is to simulate the implementation of a function or utility that
//  sometimes throws an error condition to the caller. The Task1() function
//  will be called repeatedly with Arrays of optional Ints. Your assignment is
//  to return nil or an Int as follows:
//      If none of the values in the input Array are nil return the sum of the
//      Array.
//      If any values are nil throw an error using .nilValueAt with the (0
//          based) index of the first nil value in the Array.
//
//  By changing the return value of task1() from nil to the sum of the Array
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
//  Task2 will be called with an Array of Ints and a function that takes and
//  returns an Int. Your assignment is to add code to Task2 that loops through
//  the Array parameter and passes the values one by one to the function
//  parameter, then sums the values returned from that function. The
//  complication is that the function can throw an error sometimes when it is
//  called. Most of the thrown errors will be of Type Task2ErrorType. To handle
//  those errors, you need to implement Do-Try-Catch inside your loop so that you
//  can catch errors and recover from a thrown error and continue processing the
//  Array. When an error is caught, testPrint "Error: " followed by the name of
//  of the error and the associated value (if there is one). For example:
//      Error: errorWithInt 7
//  Once you catch and testPrint an error of type Task2ErrorType, continue the
//  loop to process the next Int in the Array. However, if you catch a "generic"
//  error that is not in Type Task2ErrorType, you should "throw error" which
//  forwards the error up the call chain to let some other function handle it.
//  This is a typical pattern where the errors a function does not understand
//  or know how to handle are forwarded up the call chain.
//
//  When you change the return value of task2 from returning nil to instead
//  return the sum of values returned by the function, that will tell the
//  test code to test your function.
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
//  Most of you are very familiar with spreadsheets that are basically two dimensional
//  Arrays of cells. Each cell can contain a number or text or a formula. The formulas
//  can use numbers in the formula itself or they can reference the values of other cells.
//  The spreadsheet software needs to evaluate each cell and figure out what number
//  or text to display. Let's simulate a simple spreadsheet and have you evaluate the
//  spreadsheet so it could be displayed to a hypothetical user.
//
//  Together, the enums ValueOrFormula and Operators define the contents of a cell in our
//  spreadsheet. Each cell can contain:
//      an .int,
//      a .double,
//      a .string,
//      an .op (operation) with associated values indicating the lhs (left-hand-side),
//              the Operator, and the rhs (right-hand-side)),
//      a .ref (reference) with associated values indicating to which cell it refers
//      or an .error (with an associated descriptive String).
//  The lhs and rhs of a operation cam themselves be anything in ValueOrFormula
//  allowing the user to write more complex (recursive) formulas.
//
//  For example, a user might enter cell values like this in the first row:
//      2               One String           @(2,1)
//  Those values would be represented internally like this:
//      [ .int(2), .string("One String"), .ref(2,1) ]
//  The first two cells contain values. The third cell contains a reference to the
//  second cell so when we evaluate this row we would wind up with:
//      [ .int(2), .string("One String"),  .string("One String")]
//  and the user display would show something like this:
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
//  Your assignment is to write code in task4(), probably using some other functions
//  you create, that will evaluate a spreadsheet containing cells of type ValueOrFormula
//  and return an Array of the same Type with fully evaluated cells. Fully evaluated
//  cells should have no .op nor .ref values in the cells.
//
//  The evaluation rules are as follows (in priority order):
//      1) If a cell contains an .int, .double, .string, or .error just leave it as-is
//      2) If either operand of any operator is a .error, the value of the operation is
//              the same .error
//      2) If either operand of .plus is a .string, convert both operators to strings
//              and concatenate the strings together
//      2) If either operand of the other three operators is a .string, the result
//              should be a descriptive .error
//      3) If the rhs of .divide evaluates to 0, the result should be an .error
//      4) If both operands of an operator are .int, the result should be .int except
//              for .divide. If both operands of .divide are .int the result should
//              be .int if the rhs divides into the lhs evenly and otherwise the
//              result should be .double
//      5) If one operand of an operator is a .double and the other operand is either
//              a .int or a .double convert both operands to Double before performing
//              the operation and the result is .double (be sure to do the conversion
//              before the operation).
//      6) A .ref reference has the evaluated value of the referenced cell. That means
//              as you evaluate a cell that contains a reference, you will need to
//              evaluate the referenced cell before continuing to evaluate the current
//              cell containing the reference. So your evaluation function will need to
//              be recursive. Recursion is also needed since an operand of an operator
//              can itself contain a nested operator. If .ref refers to an call outside
//              the bounds of the spreadsheet, replace it with a descriptive .error.
//      Note: Usually, you would need to detect and handle recursive loops where a chain
//      of references refers back to an earlier cell in the chain. We have provided a
//      function called removeCircularReferences() that turns all cells in a recursive
//      loop of references into descriptive .errors so you do not need to check for those
//      situations. The code in task3() below is already set up to call removeCircular()
//      as the first thing it does so the Array will be ready for your code to process.
//
//  Note on Presenting Data to the User:
//  When we code user facing software, we must remember to represent things
//  the way the user expects to see them, not the way we would normally handle
//  and represent them internal to our code. For that reason .ref is 1 based, not
//  0 based so (1,1) refers to the top left cell. Your bounds checking needs to
//  take that into account. Also, while we internally refer to Arrays with row
//  first like "anArray[row][column]", Spreadsheet users expect to refer to
//  a cell in Column Row order so that is how .ref(col,row) is set up. We could
//  have set it up to store the references as 0 based and with the row in the
//  first associated value and translated when we present the interface to the
//  the user, but in this case we chose to represent the data as close to the
//  user view of the data as possible to help ensure we present it correctly.
//  That does require extra caution in the code evaluating .ref values. Be
//  careful to adjust for 1 based references and for to remember that the ordering
//  inside a .ref is column,row or your code may generate interesting crashes.
//  Also note that unlike Task 0, we have increasing y (row number) go down
//  on the screen rather than up since that is what spreadsheet users expect.
//
//  We recommend that you set up a Dictionary to help you evaluate operators
//  with a key of type Operators and a value that is a closure to evaluate that
//  Operator. We provide a typealias for the closure to help you define that
//  Dictionary. We have also provided a function printSheet() that will print a
//  spreadsheet in a format that is easier to read and more meaningful than
//  the default printout you would get from just calling testPrint(). We
//  also defined "description"" and "userDescription properties" for the two
//  enum Types and made them comply with CustomStringConvertible to help us
//  print more descriptive information about them.
//
//  Changing the last line of task3() from "return nil" to instead say
//  "return resultSheet" will indicate that you are ready to have the code
//  in main.swift test your evaluation of the input spreadsheet that is
//  stored in resultSheet.
//
//  As mentioned in Task0, it sometimes helps to incrementall build and test
//  a solution. To help with that, if you change task3() to return resultSheet
//  it will run a series of test spreadsheets through your code. Sheet 0
//  will only include .int, .double and .string values. Sheet 1 one will also
//  include a single .plus operations in each cell. Both Sheets 0 and 1 will
//  only be one dimensional. Sheet 2 will have a single operation of any kind
//  in each cell and will be two dimensional (.plus, .minus, .times, .divide).
//  Sheet 3 one will include more complex equations in the cells that will test
//  the recursion in processing operators. Sheet 4 will do do simple cell
//  references. Sheet 5 one will test everything together. It will only test each
//  sheet until one fails so, for example, if Sheet 2 fails, it will not proceed
//  to test Sheet 3.
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
//  at runtime the size of a particular value of ValueOrFormula. To address
//  this, we must mark the type "indirect" which causes it to be used
//  by reference like a class rather than by value like other enums.
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
        case let .op(lhs, anOp, rhs): return "(" + lhs.userDescription + anOp.userDescription + rhs.userDescription + ")"
        case let .ref(col, row): return "@[\(col), \(row)]"
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
//      func printSheet(_ aSheet: Spreadsheet, userView: Bool = false)
//      func removeCircularReferences(_ aSheet: Spreadsheet) -> Spreadsheet

//  This variable is where you will build your return value after we remove
//  circular references from it
var resultSheet: Spreadsheet = []

func task3(_ theSheet: Spreadsheet) -> (Spreadsheet)? {
    resultSheet = removeCircularReferences(theSheet)

    return nil
}
    
