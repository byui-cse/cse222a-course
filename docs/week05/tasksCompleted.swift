// ******** NOTES TO EDITOR OF tasksCompleted.swift and tasks.swift ******** //
//  Please make any changes to tasksCompleted.swift. This includes all the task code
//  but it also includes sample implementations for testing. After you edit, lint, etc.
//  this file, copy the entire file to tasks.swift and then follow the indications in
//  in each task function to delete the sample code and just leave behind a stub.
//  Most of the time, that will just be "return nil" but in a few cases we leave
//  stub code that has a template in it for them to use. Finally, in tasks.swift
//  please delete this note to the editor in the first 8 lines of this file.
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
extension Range where Bound == Int {
    func randomArray(_ size: Int) -> [Bound] {
        return (0..<size).map { _ in Int.random(in: self) }
    }
}
extension ClosedRange where Bound == Int {
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
//      on start: testPrint "S#,#" replacing # with the starting position numbers
//      on forward or backward: testPrint "F#" or "B#" replacing # with the
//          distance
//      on turnRight or turnLeft: testPrint "R#" and "L#" replacing # with the
//          direction faced after the turn using the direction numerals below
//      After the end of the Array: testPrint "E#,#" with the ending position
//  The direction numerals are as follows:
//      0 moving to right, x incrementing, we start facing this direction
//      1 moving up, y incrementing
//      2 moving left, x decrementing
//      3 moving down, y decrementing
//
//  Here is an example of format of the desired output:
//      "S9,6 B2 B1 R3 L0 F2 B2 R3 E6,6"
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
//  proceed. If you choose to do so and since the first
//  tests are one dimensional you can implement .start, .forward and
//  .backward first and test those, then implement turnRight and turnLeft.
//  It is usually good practice to break a problem into pieces and then
//  develop and test your code incrementally.
//
func printWalk(theSteps: [Steps]) {
    // put your code here
    //  EDITOR for tasks.swift remove all of the code in this function
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
            location.0 += increments[direction].0 * distance
            location.1 += increments[direction].1 * distance
            toPrint += " F\(distance)"
            break
        case .backward(let distance):
            location.0 -= increments[direction].0 * distance
            location.1 -= increments[direction].1 * distance
            toPrint += " B\(distance)"
            break
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
    //  EDITOR for tasks.swift change this to "return nil" but do
    //  not change anything else inside task0()
    return true // when ready to test, change this to "return true"
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
//      "Error: errorWithInt 7"
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
//  Most of you are very familiar with spreadsheets that are basically two dimensional
//  Arrays of cells. Each cell can contain a number or text or a formula. The formulas
//  can use numbers in the formula itself or they can reference the values of other cells.
//  The spreadsheet software needs to evaluate each cell and figure out what number
//  or text to display. Let's simulate a simple spreadsheet and have you evaluate the
//  spreadsheet so it could be displayed to a hypothetical user.
//
//  We define two enum Types: ValueOrFormula and Operators. Together, they define the
//  contents of a cell in our spreadsheet. Each cell can contain:
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
//      2.3               One String           @(2,1)
//  Those values would be represented internally like this:
//      [ .double(2.3), .string("One String"), .ref(2,1) ]
//  The first two cells contain values. The third cell contains a reference to the
//  second cell so when we evaluate this row we would wind up with:
//      [ .double(2.3), .string("One String"),  .string("One String")]
//  and the user display would show something like this:
//      2.3               One String          One String
//
//  In the second row, the user might type something like this:
//      1.2 * 2.3         3.1 - @(1,1)        -7.4 + ( @(1,1) + @(3,1) )
//  We would represent that internally like this:
//     [ .op(.double(1.2), .times, .double(2.3)),
//              .op(.double(3.1), .minus, .ref(1,1)),
//              .op(.double(-7.4), .plus, .op(.ref(1,1), .plus, .ref(3,1))) ]
//  When we evaluate it, the result would be this:
//     [ .double(2.76)   .double(0.34)    .string("-7.42One String") ]
//
//  Your assignment is to complete some functions to make task3() correctly evaluate
//  spreadsheets, reducing each cell to the basic enums of .double, .string or .error.
//  Fully evaluated cells should have no .op nor .ref values in the cells.
//
//  The Evaluation Rules are as follows (in priority order):
//      1) If a cell contains a .double, .string, or .error just leave it as-is,
//      2) If the cell contains a .op, first call the evaluate() function to (recursively)
//              evaluate the operands, then try to process the operator,
//      3) If either operand of any operator is a .error, the value of the operation is
//              the same .error (just return the value of that operand),
//      4) If either operand of .plus is a .string and the other is a .string or .double,
//              convert both operators to strings and concatenate the strings together,
//      5) .plus works on .strings and .doubles while .minus, .times and .divide work only
//              on .doubles so any other operands should return a .error,
//      6) If the second operand of .divide is .double(0.0), return an .error,
//      7) A .ref reference has the value of the referenced cell. But it may reference
//              a cell that has not yet been evaluated (simplified) so you need to
//              find the referenced cell in the array, call evaluate() to simplify it
//              and save the new value, then return the evaluated value as the value of
//              the .reference. See the "Note on Presenting Data to the User for .ref"
//              below to make sure you are referencing the correct cell in the array.
//      ** As you write your code, please refer back to this list of evaluation rules. **
//
//  Note on Presenting Data to the User for .ref:
//      When we write code that interacts directly with the user, we must remember to
//      represent things the way the user expects to see them. For example, we index arrays
//      starting at 0, but users expect to see spreadsheets start numberint cells with 1. So
//      the .ref associated values will start at (1,1) for the top left cell.
//      Also, if we are accessing elements of a two-dimensional array, we usually would access
//      them like  "anArray[row][column]", but spreadsheet users expect to list the column first
//      so our .ref associated values will be ".ref(column, row)". Be careful to do your .ref
//      lookup in to the array correctly, adjusting for the fact that the .ref assocaited values
//      start at (1,1) and list the numbers (column,row).
//
//  Note on recursion:
//      We need to have a separate evaluate() function and cannot do the switch on the contents
//      of an Array cell because we need to be able to recursively  evaluate the operands of a
//      .op and also to recursively evaluate a cell referenced by .ref. The .op recursion can
//      only go as deep as the formula being evaluated, but a .ref could possibly refer to itself
//      or to a cell that refers bacck to the same cell. This could cause what spreadsheets call
//      a circular reference. That could cause your recursive calls to loop infinitely. You do
//      not need to worry about that because we have a funcation at the top of task3() that
//      looks for circular references and evaluates them into a .error.
//
//  Here are the enum types that make up our spreadsheet contents:
enum Operators: String, CustomStringConvertible {
    case plus // if either parameter is String, convert both to String and concatenate
    case minus
    case times
    case divide

    // This will print an internal view of the spreadsheet
    var description: String { return self.rawValue }
    // This is used to print the user view of the spreadsheet
    var userDescription: String {
        switch self {
            case .plus: return " + "
            case .minus: return " - "
            case .times: return " * "
            case .divide: return " / "
        }
    }
}
//  Because ValueOrFormula has some associated values of type ValueOrFormula
//  it is a recursive Type. That means that the compiler cannot determine
//  at runtime the size of a particular value of ValueOrFormula. To address
//  this, we must mark the type "indirect" which causes it to be used
//  "by reference" like a class rather than "by value" like other enums.
indirect enum ValueOrFormula: CustomStringConvertible {
    case double(Double)
    case string(String)
    case op(ValueOrFormula, Operators, ValueOrFormula)
    case ref(Int, Int) // reference to contents of cell at (column, row).
        // User oriented so 1 based meaning ref(1,1) is contents of top left cell
    case error(String)

    // This will print an internal view of the spreadsheet
    var description: String {
        switch self {
        case let .double(aDouble): return ".double(\(aDouble))"
        case let .string(aString): return ".string(\(aString))"
        case let .op(lhs, anOp, rhs): return "(\(lhs) \(anOp) \(rhs))"
        case let .ref(col, row): return ".ref(\(col), \(row))"
        case let .error(aString): return ".error(\(aString))"
        }
    }
    // This is used to print the user view of the spreadsheet
    var userDescription: String {
        switch self {
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
//  This variable is where you will build your return value after we remove
//  circular references from it
var resultSheet: Spreadsheet = []

// Step by step instructions:
//      We encourage you to implement this task incrementally step by step. This is
//      good practice to develop more complex solutions.
//
//  1)  Change "return nil" at the end of task3() to "return resultSheet". This tells
//      the test code to start testing. The first test just checks that simple values
//      are returned as-is. The code currently returns all values as-is so it should
//      pass the first test. As each test is passed, the test code passes more complex
//      spreadsheets into task3(). If there are errors in the evaluation it will show
//      what was passed in, what it expected to have returned and what was returned.
//      You can compare what was expected to what was returned to see what you need
//      to fix next.
//  2)  The code in evaluate() for .op looks up a closure for each operator and calls it.
//      Implement the closure for .plus. It is already partially set up. It does a
//      switch on the lhs operator. You need fill in the cases for .double, .string and
//      .error and change the default to return a .error. You can call invalid() to
//      construct that .error. The .error case should just return the value for the lhs
//      operator. The other two cases have a switch on the rhs inside them. The default
//      and .error cases should do the same as for the lhs. For the .double and .string
//      cases you need to follow the "Evaluation Rules" above. Once you do that correctly,
//      your code should pass the second test that only uses simple .plus operators.
//  3)  You will notice that your code fails the third test that has more complicated .plus
//      operators. That is because the operands of a .plus can themselves contain operators
//      so we need to first evaluate the operands and then the operator. Change the line
//      in evaluate() that has "return operatorClosure(lhs, rhs)" to evaluate the operators
//      first by changing it to be "return operatorClosure(evaluate(lhs), evaluate(rhs))".
//      Your code should now pass the third test.
//  4)  The fourth test uses the other operators: .minus, .times and .divide. Add entries
//      to the operators dictionary for each of those operators. Notice the differences for
//      those operators in the "Evaluation Rules" above. They do not accept strings and the
//      .divide operator needs to check for divide by 0. Once you correctly impelement the
//      other three operators, your code should pass the fourth test.
//  5)  Now you need to impelment the .ref option inside the evaluate() function. Review
//      the "Evaluation Rules" above closely. Once you have the .ref implemented, your
//      code should pass all tests. If it crashes or seems to go into an infinite loop
//      you are probably referencing the wrong call of the array. Make sure you allow
//      for the references to be based at (1,1) and to be (column, row) and not
//      (row, column). Also, you should check that the .ref values are valid and return
//      a .error if the value for row or column is less than 1 or if the value for row
//      is greater than resultSheet.count or the value for column is greater than
//      resultSheet[0].count (the size of the first row). We only have square spreadsheets
//      so the size of all rows is the same and you can just use the size of the first row.

//  The following two functions are defined in main.swift, but can be used here
//      func printSheet(_ aSheet: Spreadsheet, userView: Bool = false)
//          This will print the sheet showing either the internal or user view.
//      func removeCircularReferences(_ aSheet: Spreadsheet) -> Spreadsheet
//          This is called in task3() to remove circular references.

// This defines a closure Type we use as the value in a Dictionary of operators
typealias OperatorClosure = (ValueOrFormula, ValueOrFormula) -> ValueOrFormula

// This function is provided to help you construct a .error with an invalid operand
// If you detect invalid operands you can return the value of this to construct the .error
func invalid(_ operand: ValueOrFormula, for anOperator: String) -> ValueOrFormula {
    return .error("\(operand) invalid operand for \(anOperator)")
}

// This is a dictionary of closures to implement the operators
// We have partially constructed the closure for .plus
#if true // this is the verson for tasksCompleted
let operators: Dictionary<Operators, OperatorClosure> = [
        .plus : { (lhs, rhs) in
        switch lhs {
        case .double(let lhsDouble):
            switch rhs {
            case .double(let rhsDouble):
                return .double(lhsDouble + rhsDouble)
            case .string(let rhsString):
                return .string(String(lhsDouble) + rhsString)
            case .error:
                return rhs
            default:
                return invalid(rhs, for: "plus")
            }
        case .string(let lhsString):
            switch rhs {
            case .double(let rhsDouble):
                return .string(lhsString + String(rhsDouble))
            case .string(let rhsString):
                return .string(lhsString + rhsString)
            case .error:
                return rhs
            default:
                return invalid(rhs, for: "plus")
            }
        case .error:
            return lhs
       default:
            return invalid(lhs, for: "plus")
        }
    },
    .minus : { (lhs, rhs) in
        switch lhs {
        case .double(let lhsDouble):
            switch rhs {
            case .double(let rhsDouble):
                return .double(Double(lhsDouble - rhsDouble))
            case .error:
                return rhs
            default:
                 return invalid(rhs, for: "minus")
            }
        case .error:
            return lhs
        default:
            return invalid(lhs, for: "minus")
        }
    },
    .times : { (lhs, rhs) in
        switch lhs {
        case .double(let lhsDouble):
            switch rhs {
            case .double(let rhsDouble):
                return .double(lhsDouble * rhsDouble)
            case .error:
                return rhs
            default:
                 return invalid(rhs, for: "times")
            }
        case .error:
            return lhs
        default:
            return invalid(lhs, for: "times")
        }
    },
    .divide : { (lhs, rhs) in
        switch lhs {
        case .double(let lhsDouble):
            switch rhs {
            case .double(let rhsDouble):
                guard rhsDouble != 0 else { return .error("cannot divide by zero") }
                return .double(Double(lhsDouble / rhsDouble))
            case .error:
                return rhs
            default:
                 return invalid(rhs, for: "divide")
            }
        case .error:
            return lhs
        default:
            return invalid(lhs, for: "divide")
        }
    }
]
#else // this is the version for tasks
let operators: Dictionary<Operators, OperatorClosure> = [
    .plus : { (lhs, rhs) in
        switch lhs {
        case .double(let lhsDouble):
            switch rhs {
            case .double(let rhsDouble):
                return .error("not yet implemented")
            case .string(let rhsString):
                return .error("not yet implemented")
            case .error:
                return .error("not yet implemented")
            default:
                return .error("not yet implemented")
            }
        case .string(let lhsString):
            switch rhs {
            case .double(let rhsDouble):
                return .error("not yet implemented")
            case .string(let rhsString):
                return .error("not yet implemented")
            case .error:
                return .error("not yet implemented")
            default:
                return .error("not yet implemented")
            }
        case .error:
            return .error("not yet implemented")
       default:
            return .error("not yet implemented")
        }
    }
]
#endif

func evaluate(_ value: ValueOrFormula) -> ValueOrFormula {
    switch value {
        // simple values are returned as-is
    case .double, .string, .error: return value
    case let .op(lhs, op, rhs):
        // Look up the operator in the array of operator closures
        guard let operatorClosure = operators[op] else { return .error("Operator not in operators[]") }
#if true // this is the verson for tasksCompleted
        // recursively pre-evaluate the operators so they are simplified before we use them
        return operatorClosure(evaluate(lhs), evaluate(rhs))  // pre-evaluate the operators so each closure does not need to
#else // this version is for tasks
        return operatorClosure(lhs, rhs)
#endif
    case let .ref(col, row):
#if true // this is the verson for tasksCompleted
        guard row > 0, row <= resultSheet.count else { return .error("row \(row) in reference not in range") }
        guard col > 0, col <= resultSheet[row-1].count else { return .error("row \(row) in reference not in range") }
        resultSheet[row-1][col-1] = evaluate(resultSheet[row-1][col-1]) // make sure the cell is fully evaluated first
        return resultSheet[row-1][col-1]
#else // this version is for tasks
        return value // for now, return the value unevaluated
#endif
    }
}

func task3(_ theSheet: Spreadsheet) -> (Spreadsheet)? {
    // This will replace circular references with .error values to avoide infinite recursion
    resultSheet = removeCircularReferences(theSheet)

    // Step through the spreadsheet evaluating (simplifying) each cell
    for rowIndex in 0..<resultSheet.count {
        for colIndex in 0..<resultSheet[rowIndex].count {
            resultSheet[rowIndex][colIndex] = evaluate(resultSheet[rowIndex][colIndex])
        }
    }

    //  EDITOR for tasks.swift replace the rest of task3 with "return nil"
    return resultSheet
}
