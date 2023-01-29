// *************************
//  Do not modify this file!
// *************************
//  You are welcome to read this file and to try to understand it,
//  Your assignment is to edit tasks.swift and then run this file and tasks.swift in a project.
//  The code in this file will test your task functions and indicate which task functions pass.
//  It will also provide diagnostic information if a task function fails. You should definitely
//  not try to just copy code from a test here to your task, but instead, understand how to
//  correctly create a task that meets the needs of the test.
//
//  main.swift
//  Week 5 Tasks
//

import Foundation

enum TestResults {
    case testNotImplemented
    case testPassed
    case testFailed
}

// This must list the tests in order: test0, test1... so they can be called with their test number and
// not need to hard code the Task name into the test except when calling the task function
private var tests: [(Int) -> TestResults] = [test0, test1, test2, test3]
private var taskResults: [TestResults] = Array(repeating: .testNotImplemented, count: tests.count)
private var savedInput: [String?] = []
private var savedPrint: [String?] = []
private var currentTest = 0


#if false
    print("savedInput:")
    print(savedInput)
    print("savedPrint:")
    print(savedPrint)
#endif

//  ========= Utility functions =========

//  This prints the a list of the tasks that match a particular status
private func printResults(message: String, result: TestResults) {
    var toPrint = message
    // count the tasks in that status
    let resultCount = taskResults.filter { $0 == result }.count
    toPrint += String(describing: resultCount)
    // List the numbers of the tasks that match that status
    if resultCount > 0 {
        toPrint += " Task numbers:"
        var first = true // the first one does not need a comma in front of it
        for testNum in 0 ..< tests.count {
            if taskResults[testNum] == result {
                if first { first = false }
                else { toPrint += "," }
                toPrint += " " + String(describing: testNum)
            }
        }
    }
    print(toPrint)
}

// Called before starting each test. It sets up testReadLine() and testPrint()
private func setupReadLineAndPrint(testNum: Int) {
    // clear input and print caches in case some other function used them
    savedInput = []
    if savedPrint.count > 0 {
        savedPrint = []
        print() // print a blank line between output for tasks
    }
    currentTest = testNum
}

// This allows us to capture the students' use of readLine() for testing
func testReadLine() -> String? {
    // so the user input stands out in the console log
    print("Input>>> ", terminator: "")
    let aString = readLine()
    savedInput.append(aString)
    return aString
}

// This allows us to capture the students' use of print() for testing
// Note: if you print with testPrint(something, terminator: ""), it will
// correctly continue printing on the same line, but savedPrint will still
// capture a separate "line" for each call to testPrint.
func testPrint(_ parameters: Any..., terminator: String = "\n") {
    if savedPrint.count == 0 {
        // this is the first print for this task
        print("===== Output for Task \(currentTest) =====")
    }
    var countDown = parameters.count
    if countDown == 0 {
        // Being asked to print a blank line
        savedPrint.append(nil)
        print()
    } else {
        for parameter in parameters {
            savedPrint.append(String(describing: parameter))
            countDown -= 1
            if countDown > 0 {
                print(parameter, terminator: "")
            } else {
                print(parameter, terminator: terminator)
            }
        }
    }
}

// This function lets us write cleaner code in the tests for all of the error messages
func fail(_ testNum: Int, _ message: String) -> TestResults {
    print("Task \(testNum) Error: \(message)")
    return .testFailed
}

//  ========= Concepts taught or reinforced in each task  =========
/*
 Task 0
 •  enums with associated values
 •  working with arrays of enums
 •  simulating a random walk
 Task 1
 •  implementing code that throws errors
 •  processing arrays of optionals
 Task 2
 •  calling a function that can throw
 •  using Do-Try-Catch to handle thrown errors
 •  using "throw error" to forward an error up the call stack
 Task 3
 •  substantial mini project
 •  enums with associated values
 •  recursive enums
 •  closures stored in a Dictionary
 •  general recursion to process recursive data structures
        (recursion in two different ways: recursive formula
        structures within an Array cell and recursive
        references to other cells
 •  type conversions
 •  string concatenation
 •  complex switch and case handling
 •  dealing with invalid values
 •  adapting to user view (cell references being 1 based,
        and having a column row order of parameters)
 */

//  ========= Tests =========

private var walks: [[Steps]] = []
private func setupGlobals() -> Bool {
    walks = []
    return true
}

func saveWalk(_ theSteps: [Steps]) {
    walks.append(theSteps)
}
private func doWalk(_ theSteps: [Steps]) -> String {
    var location = (0, 0)
    var result = ""
    var direction = 0
    let increments = [(1, 0), (0, 1), (-1, 0), (0, -1)]
    for step in theSteps {
        switch step {
        case .start(let h, let v):
            location = (h, v)
            result += "S\(h),\(v)"
           break
        case .forward(let distance):
            location.0 += increments[direction].0
            location.1 += increments[direction].1
            result += " F\(distance)"
            break
        case .backward(let distance):
            location.0 -= increments[direction].0
            location.1 -= increments[direction].1
            result += " B\(distance)"
        case .turnRight:
            direction = (direction + 3) % 4
            result += " R\(direction)"
           break
        case .turnLeft:
            direction = (direction + 1) % 4
            result += " L\(direction)"
            break
       }
    }
    result += " E\(location.0),\(location.1)"
    return result
}
private func test0(testNum: Int) -> TestResults {

    walks = []
    guard let returnValue = task0() else { return .testNotImplemented }
    if returnValue != true {
        return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
    }

    guard walks.count >= 5 else {
        return fail(testNum, "Expected at least 5 random walk tests, but only see \(walks.count) tests")
    }
    guard walks.count ==  savedPrint.count else {
        return fail(testNum, "Expected one line printed per random walk test, but see \(savedPrint.count) lines printed for \(walks.count) random walk tests")
    }
    var passCode = TestResults.testPassed
    for index in 0..<walks.count {
        let expected = doWalk(walks[index])
        guard let printed = savedPrint[index] else {
            passCode = fail(testNum, "Unexpected blank line printed")
            continue
        }
        guard printed == expected else {
            passCode = fail(testNum, "Expected printWalk to produce:\n\t\(expected)\nbut produced\n\t\(String(describing: printed))")
            continue
        }
    }

    return passCode
}

private func test1(testNum: Int) -> TestResults {

    //  We will randomly do nil or not nil, but we want to do at least 2
    //  with and 2 without nil so we count how many of each we did
    var didWithNil = 0
    var didWithoutNil = 0;
    // We want at least 5 total, but want at least 2 with and 2 without nil
    while didWithNil + didWithoutNil < 5 || didWithNil < 2 || didWithoutNil < 2 {
        var anArray:[Int?] = (-10...10).randomArray(Int.random(in: 5...10))
        var doNil = Int.random(in: 0...1) == 0 // 50% chance of doing nils
        // if we didn't get at least 2 of each then force it
        var firstNil = 0
        //  If we have 5 or more then force coverage of with or without nil,
        //  whichever did not have enough
        if didWithNil + didWithoutNil >= 5 {
            if didWithNil < 2 {
                doNil = true
            } else {
                doNil = false
            }
        }
        // If doing nil, randomly choose where in the array it will appear
        if doNil {
            didWithNil += 1
            firstNil = Int.random(in: 0..<anArray.count)
            anArray[firstNil] = nil
            // If our nil value is in the first half of the array,
            // insert a second nil in the second half
            if firstNil < anArray.count / 2 {
                anArray[Int.random(in: firstNil+1..<anArray.count)] = nil
            }
        } else {
            didWithoutNil += 1
        }
  
        // Call task1() catching the thrown "errors" and comparing results
        do {
            guard let returnValue = try task1(anArray) else {
                return .testNotImplemented
            }
            guard !doNil else {
                return fail(testNum, "Array with nil in index \(firstNil) should have thrown an error, but returned \(returnValue)")
            }
            let wantResult = anArray.compactMap{$0}.reduce(0,+)
            guard returnValue == wantResult else {
                return fail(testNum, "The following array should have returned the total of \(wantResult), but returned \(returnValue)\n\t\(anArray.compactMap{$0})")
            }
        } catch task1ErrorType.nilValueAt(let errorIndex) {
            guard
                doNil else {
                return fail(testNum, "Array without any nil values threw an error claiming there was a nil at index \(errorIndex)")
            }
            guard firstNil == errorIndex else {
                return fail(testNum, "Array with first nil values at index \(firstNil) threw an error claiming there was a nil at index \(errorIndex)")
            }
        } catch {
            return fail(testNum, "Expected throw with task1ErrorType.nilValueAt, but did a throw with other error: \(error)")
        }
        
    }

    return .testPassed
}

private func test2(testNum: Int) -> TestResults {
    
    //  Set up some arrays to control the test
    
    //  This is the array passed to task2()
    let testArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    //  This is the array of values we return from the function
    //  a nil value means to throw an error instead
    let testReturnValue = [0, nil, 2, 3, nil, 5, nil, 7, nil, 9]
 
    //  These are the errors we will throw for the nil values (in sequence)
    let throwErrors: [Task2ErrorType] = [
        .someError,
        .errorWithInt(17),
        .errorWithString("Expected"),
        .errorWithDouble(14.3)
    ]

    //  This is what we expect testPrinted for each error thrown
    let expectedPrint = [
        "Error: someError",
        "Error: errorWithInt 17",
        "Error: errorWithString Expected",
        "Error: errorWithDouble 14.3"
    ]

    // Used to step through the errors each time we throw one
    var throwIndex = 0;
    
    // String for when we throw an "unexpected" error
    let unexpectedErrorString = "Unexpected error that is actually expected at this point"

    // Value expected to come back to us for the unexpected error
    let expectedValueUnexpectedError = "unexpectedError(\"Unexpected error that is actually expected at this point\")"

    //  Remove all the spaces in a string so we can test the student's
    //  printed results without worrying about spaces
    func unSpaced(_ stringWithSpaces: String) -> String {
        return stringWithSpaces.filter { $0 != " "}
    }
    //  used to throw the "unexpected" error
    enum unexpectedErrorType: Error {
        case unexpectedError(String)
    }
    // This is the function we pass to task3()
    func canThrow(_ anInt: Int) throws -> Int {
        // Make sure we were called with a valid value
        guard (0..<testReturnValue.count).contains(anInt) else {
            throw unexpectedErrorType.unexpectedError("Expected canThrow() to be called with values from the passed array which are all in 0..<10, but it was called with \(anInt)")
        }
        // Check if we should return an Int. nil values mean throw error
        guard let returnValue = testReturnValue[anInt] else {
            throwIndex += 1
            if throwIndex-1 < throwErrors.count {
                throw throwErrors[throwIndex-1]
            } else {
                //  The first time we call task2() this should not happen
                //  If it does, it should cause task2() to "throw error"
                //  which would prevent us from testing the returned value
                throw unexpectedErrorType.unexpectedError(unexpectedErrorString)
            }
        }
        return returnValue
    }

    // Call task2() the first time
    // We catch any thrown error, but none of the errors should be passed up the chain the first time
    do {
        guard let returnValue = try task2(intArray: testArray, canThrow: canThrow) else {
            return .testNotImplemented
        }
        guard savedPrint.count == throwErrors.count else {
                return fail(testNum, "Expected \(throwErrors.count) lines testPrinted from throws caught, but only testPrinted \(savedPrint.count) lines")
        }
        let expectedReturn = testReturnValue.compactMap{$0}.reduce(0,+)
        guard returnValue == expectedReturn else {
                return fail(testNum, "Expected return value of \(expectedReturn), but returned \(returnValue)")
        }
        
        // Use an explicit index because we need to loop through two arrays in parallel
        for index in 0..<savedPrint.count {
            guard let aLine = savedPrint[index] else {
                return fail(testNum, "Expected \(throwErrors.count) lines testPrinted from throws caught, line \(index) was empty")
            }
            guard unSpaced(aLine) == unSpaced(expectedPrint[index]) else {
                return fail(testNum, "Expected testPrinted line number \(index + 1) to be\n\t\(expectedPrint[index])\nbut it was\n\t\(aLine)")
            }
        }
    } catch {
        return fail(testNum, "Did not expect unexpected error to be thrown from the first call to task2() during which \(testArray.count) integers should have been processed")
    }

    //  Now call task2() again. This time it should throw an unexpected
    //  error so check if it is correctly thrown.
    do {
        // Call it one more time passing in a value that will cause it to throw an "expected" unexpected error
        guard let returnValue = try task2(intArray: [1], canThrow: canThrow) else {
            return fail(testNum, "Expected the second call to task2() to throw an error, but instead returned nil")
        }
        return fail(testNum, "Expected second call to task2() to throw an \"unexpected\" error, but instead it returned  \(returnValue)")
    } catch {
        guard savedPrint.count == throwErrors.count else {
            return fail(testNum, "Did not expect throw of an \"unexpected\" error to call testPrint()")
        }
        let expectedError = "unexpectedError(\""+unexpectedErrorString+")\""
        guard String(describing: error) == expectedValueUnexpectedError else {
            return fail(testNum, "Expected String(describing:) the error thrown from the second call to task2() to be:\n\t\(expectedError)\nbut it was:\n\t\(String(describing: error))")
        }
    }
    return .testPassed
}
func compareSheets(_ lhsSheet: Spreadsheet, _ rhsSheet: Spreadsheet) -> (Bool, String) {
    guard lhsSheet.count == rhsSheet.count else { return (false, "Number of rows do not match") }
    for rowIndex in 0..<lhsSheet.count {
        guard lhsSheet[rowIndex].count == rhsSheet[rowIndex].count else { return (false, "Number of columns do not match") }
        for colIndex in 0..<lhsSheet[rowIndex].count {
            // if both are .error, do not compare the associated values since we did not specify exact wording
            let lhsValue = lhsSheet[rowIndex][colIndex]
            let rhsValue = rhsSheet[rowIndex][colIndex]
            // handle .error special because we cannot compare associated values since we did not define exact wording
            switch lhsValue {
            case .error:
                switch rhsValue {
                case .error: continue // both .error so consider the cells equal
                default: return (false, "cell at (\(colIndex+1), \(rowIndex+1)) \(lhsValue) != \(rhsValue)")
                }
            default:
                guard lhsSheet[rowIndex][colIndex] == rhsSheet[rowIndex][colIndex] else {
                    return (false, "Cell at (\(colIndex+1), \(rowIndex+1)) has: \(lhsSheet[rowIndex][colIndex]) should have: \(rhsSheet[rowIndex][colIndex])")
                }
            }
        }
    }
    return (true, "")
}
func printSheet(_ aSheet: Spreadsheet, userView: Bool = false) {
    var aString = ""
    if userView {
        var firstRow = true
        var lastCellStart = 0
        for row in aSheet {
            if firstRow { firstRow = false }
            else { aString += "\n" }
            aString += "\t"
            var firstCell = true
            for cell in row {
                if firstCell { firstCell = false }
                else { // pad after cell at least 5, but cell length at least 15
                    while aString.count - lastCellStart < 10 {
                        aString += " "
                    }
                    aString += "     "
                }
                lastCellStart = aString.count
                aString += cell.userDescription
            }
        }
    } else {
        aString += "["
        var firstRow = true
        for row in aSheet {
            if firstRow { firstRow = false }
            else { aString += ",\n" }
            aString += "["
            var firstCell = true
            for cell in row {
                if firstCell { firstCell = false }
                else { aString += ", " }
                aString += "\(cell)"
            }
            aString += "]"
        }
        aString += "]"
    }
    testPrint(aString)
}
var visited: [[Bool]] = []
var tempSheet: Spreadsheet = []
func circularError(row: Int, col: Int) -> Bool {
    visited[row][col] = true
    switch tempSheet[row][col] {
    case let .ref(refCol, refRow):
        guard refRow > 0, refRow <= tempSheet.count else {
            return false // do not check out of range references, let the student handle those
        }
        guard refCol > 0, refCol <= tempSheet[refRow-1].count else {
            return false // do not check out of range references, let the student handle those
        }
        if visited[refRow - 1][refCol - 1] || circularError(row: refRow - 1,col: refCol - 1) {
            tempSheet[row][col] = .error("circular .ref")
            return true
        }
        default: return false
    }
    return false
}
func removeCircularReferences(_ aSheet: Spreadsheet) -> Spreadsheet {
    tempSheet = aSheet
    // Check for circular loops first and put a value of .error in any circular cells
    for rowIndex in 0..<tempSheet.count {
        for colIndex in 0..<tempSheet[rowIndex].count {
            visited = Array(repeating: Array(repeating: false, count: tempSheet[0].count), count: tempSheet.count)
            _ = circularError(row: rowIndex, col: colIndex)
        }
    }
    return tempSheet
}
private func test3(testNum: Int) -> TestResults {
    let firstTest: Spreadsheet = [
        [.int(2), .double(1.2), .string("One String"), .ref(3,1)],
        [.op(.ref(1,1), .plus, .ref(1,1)), .op(.ref(2,1), .plus, .ref(1,1)), .op(.ref(2,1), .plus, .ref(3,1)), .op(.ref(2,1), .minus, .ref(1,1))],
        [.op(.ref(2,1), .times, .ref(1,1)), .op(.ref(2,1), .divide, .ref(1,1)), .op(.int(6), .divide, .ref(1,1)), .op(.int(6), .minus, .string("something"))],
        [.ref(4,1), .op(.ref(2,1), .divide, .int(0)), .op(.int(3), .divide, .ref(1,1)), .op(.ref(3,1), .divide, .ref(1,1))],
        [.ref(3,5), .ref(1,5), .ref(2,5), .op(.op(.op(.ref(1,1), .plus, .string(" + ")), .plus, .ref(2,1)), .plus, .op(.string(" = "), .plus, .op(.ref(1,1), .plus, .ref(2,1))))]
    ]
    let firstResult: Spreadsheet = [
        [.int(2), .double(1.2), .string("One String"),  .string("One String")],
        [.int(4), .double(3.2), .string("1.2One String"), .double(-0.8)],
        [.double(2.4), .double(0.6), .int(3), .error("Some error message")],
        [.string("One String"), .error("Some error message"), .double(1.5), .error("Some error message")],
        [.error("Some error message"), .error("Some error message"), .error("Some error message"), .string("2 + 1.2 = 3.2")]
       ]
        
    guard let returnValue = task3(firstTest) else { return .testNotImplemented }

    testPrint("User view of input spreadsheet:")
    printSheet(firstTest, userView: true)
    testPrint("\nInternal view of input spreadsheet:")
    printSheet(firstTest)
    testPrint("\nInternal view of returned value:")
    printSheet(returnValue)
    testPrint("\nUser view of returned value:")
    printSheet(returnValue, userView: true)
    testPrint()
    let (resultBool, resultString) = compareSheets(returnValue, firstResult)
    guard resultBool else { return fail(testNum, resultString) }
    
    return .testPassed
}

//  ========= Start of main body of code =========

guard setupGlobals() else {
    exit(1)
}

for testNum in 0 ..< tests.count {
    setupReadLineAndPrint(testNum: testNum)
    taskResults[testNum] = tests[testNum](testNum)
}

print()
print("===== Task Status =====")
printResults(message: "Tasks Passed: ", result: .testPassed)
printResults(message: "Tasks Failed: ", result: .testFailed)
printResults(message: "Tasks Not Implemented: ", result: .testNotImplemented)
print()

//  ========= End of main body of code =========
