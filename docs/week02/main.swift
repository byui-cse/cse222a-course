// *************************
//  Do not modify this file!
// *************************
//  You are welcome to read this file and to try to understand it, but it may include
//  elements of Swift that have not yet been taught in the course at this point.
//  Your assignment is to edit task.swift and then run this file and task.swift in a project.
//  The code in this file will test your task functions and indicate which task functions pass.
//  It will also provide diagnostic inforamtion if a task function fails. You should definitely
//  not try to just copy code from a test here to your task, but instead, understand how to
//  correctly create a task that meets the needs of the test.
//
//  main.swift
//  Week 2 Tasks
//
//  Created by Chad Mitchell on 11/8/22.
//

import Foundation

enum TestResults {
    case testNotImplemented
    case testPassed
    case testFailed
}

// This must list the tests in order: test0, test1... so they can be called with their test number and
// not need to hard code the Task name into the test except when calling the task function
var tests: [(Int) -> TestResults] = [test0, test1, test2, test3, test4, test5, test6, test7, test8, test9]
var taskResults: [TestResults] = Array(repeating: .testNotImplemented, count: tests.count)
var savedInput: [String?] = []
var savedPrint: [String?] = []
var currentTest = 0

//  ========= Start of main body of code =========

for testNum in 0 ..< tests.count {
    setupReadLineAndPrint(testNum: testNum)
    taskResults[testNum] = tests[testNum](testNum)
}

print("===== Task Status =====")
printResults(message: "Tasks Passed: ", result: .testPassed)
printResults(message: "Tasks Failed: ", result: .testFailed)
printResults(message: "Tasks Not Implemented: ", result: .testNotImplemented)
print()

//  ========= End of main body of code =========

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
func testPrint(_ parameters: Any...) {
    if savedPrint.count == 0 {
        // this is the first print for this task
        print("===== Output for Task \(currentTest) =====")
    }
    var countDown = parameters.count
    for parameter in parameters {
        savedPrint.append(String(describing: parameter))
        countDown -= 1
        if countDown > 0 {
            print(parameter, terminator: "")
        } else {
            print(parameter)
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
 •    guard
 •    enum
 •    .count for size of Array or String
 •    String interpolation such as “Result: \(result)”
 •    print() (we use testPrint to capture what is printed for validation)
 Task 1
 •    optionals
 •    guard let (Hint mentions “if let” and “??” as well)
 •    _ for unnamed parameter from caller
 •    String interpolation
 •    enum
 •    readLine() (we use testreadLine to capture what is printed for validation)
 •    Strong comparison
 Task 2
 •    while true { }
 •    optionals
 •    if let (Hint mentions “guard var” and “if var” as well
 •    enum
 •    testReadLine()
 •    General user interaction through the console
 Task 3
 •    Simple closures
 •    Closure templates include both explicit and implicit parameters
 •    Mentions map(), filter(), reduce() as reasons for covering closures
 Task 4
 •    The concept of mutable
 •    Passing parameters by value and by reference
 •    Demonstrates reference as a way to get more than one ‘result” from a function,
 •    (A more typical way to return multiple values in Swift will be introduced next week)
 •    map()
 •    filter()
 •    simple closures
 •    function scope
 Task 5
 •    reduce (to produce sum)
 •    simple closures
 Task 6
 •    reduce (to produce sum)
 •    simple closures
 Task 7
 •    for loops (on range, object and sequence)
 •    Closed ranges
 •    stride()
 Task 8
 •    Two dimensional Arrays
 •    Creating an empty Array
 •    Expanding a two-dimensional Array by appending one dimensional arrays
 •    Int.random(in:)
 Task 9
 •    Working with two dimensional Arrays
 •    Converting from Int to Double
 •    Calculating min, max and mean or average
 •    Possibly using reduce()
 •    Constructing an array out of a list of variables or calculated values
 Not covered, so teach these in later weeks (this part will be deleted once we implement these later)
 •    Hint mentioned “??” to unpack an optional, but did not have them use it
 •    Type “Any”
 •    Operator “as”?
 •    compactMap() (with heavy use of optionals,
 */

//  ========= Tests =========

// To reorder tasks, just change the numbers in the names of the task function stub, the test function
// and the call of the task function in the test function. All else should cleanly adjust.

private func test0(testNum: Int) -> TestResults {
    // Set up some test values. We have not taught struct yet, but that is clearly called for here
    struct testValueStruct {
        let aBool: Bool
        let int1: Int
        let int2: Int
        let aString: String
        let error: GuardedErrors
    }
    let testValues = [
        testValueStruct(aBool: false, int1: 6, int2: 7, aString: "four", error: .aBoolFalse),
        testValueStruct(aBool: true, int1: -6, int2: 7, aString: "four", error: .int1_less_than_0),
        testValueStruct(aBool: true, int1: 6, int2: 5, aString: "four", error: .int1_less_than_or_equal_int1),
        testValueStruct(aBool: true, int1: 6, int2: 6, aString: "four", error: .int1_less_than_or_equal_int1),
        testValueStruct(aBool: true, int1: 6, int2: 7, aString: "eight", error: .aString_not_4_chars),
        testValueStruct(aBool: true, int1: 6, int2: 7, aString: "four", error: .success),
    ]

    // This is just to simplify the error reporting code below by having way to print what was passed into the test
    func printTestValue(test: testValueStruct) {
        print("\t\tCalled task\(testNum)(aBool: \(test.aBool), int1: \(test.int1), int2: \(test.int2), aString: \(test.aString))")
    }
    for test in testValues {
        // We want to know how many prints were done on this iteration of the loop
        // so cache the current number of calls to print.
        let priorPrintCount = savedPrint.count
        // Call the task function and report "testNotImplemented if it returns nil
        guard let result = task0(aBool: test.aBool, int1: test.int1, int2: test.int2, aString: test.aString) else {
            return .testNotImplemented
        }

        // did it return the correct error code from GuardedErrors
        guard result == test.error else {
            printTestValue(test: test)
            return fail(testNum, "Expected return value of \(test.error), but function returned \(result)")
        }

        // Did they print an error message
        guard savedPrint.count - priorPrintCount == 1, let message = savedPrint[priorPrintCount] else {
            printTestValue(test: test)
            return fail(testNum, "Expected one call to testPrint() with an error message or product of int1 * int2")
        }

        // Are we at the last test? If so, make sure they printed the correct final value
        if test.error == .success {
            guard message == "\(test.int1 * test.int2)" else {
                printTestValue(test: test)
                return fail(testNum, "Expected past testPrint to be the product int1 * int2 = '\(test.int1 * test.int2)', but printed '\(message)'")
            }

            // if not the last test, the error message should contain the String version of the code from GuardedErrors
        } else {
            guard message.contains(result.value) else {
                printTestValue(test: test)
                return fail(testNum, "Expected error message '\(message)' to contain '\(result.value)'")
            }
        }
    }

    return .testPassed
}

private func test1(testNum: Int) -> TestResults {
    // Call the task function and report "testNotImplemented if it returns nil
    guard let result = task1(nil) else { return .testNotImplemented }

    // Did they detect the error of optionalString beign nil
    guard result == .string_is_nil else {
        return fail(testNum, "Called task1(nil) so expected return value \(GuardedErrors.string_is_nil.value)")
    }

    let testString = "Swift is fun"
    while true {
        // Should not return nil here after returning non-nil on the previous call
        guard let result2 = task1(testString) else { return .testFailed }

        // Did they call testReadLine
        guard savedInput.count > 0 else {
            if result2 == .testReadLine_is_nil { continue }
            return fail(testNum, "Should not return from calling test1(\"\(testString)\") if there was no call to testReadLine()")
        }

        // Was the last input nil? Not sure that should happen, but if so, did they report that correctly?
        guard let lastInput = savedInput[savedInput.count - 1] else {
            if result2 == .testReadLine_is_nil { continue }
            else {
                return fail(testNum, "Should not return from calling test1(\"\(testString)\") if there last call to testReadLine() was empty")
            }
        }

        // Did they report success, and if so, did the user iput the correct string?
        if result2 == .success {
            guard lastInput == testString else {
                return fail(testNum, "Should only return .success if testReadLine input '\(lastInput)' matched optionalString: '\(testString)'")
            }
            break // we succeeded

            // If the last inoput was nil, just continue
        } else if result2 != .testReadLine_is_nil {
            // If they did not report input not matching, we are out of valid return codes for this task
            guard result2 == .input_does_not_match else {
                return fail(testNum, "Unknown return value fron calling test1(\(testString))")
            }
            // If they did report input not matching, make sure the input does not match
            guard lastInput != testString else {
                return fail(testNum, "Should  return .success if testReadLine input '\(lastInput)' matches optionalString: '\(testString)'")
            }
            // If input did not match, let them try again
            continue
        }
    }

    return .testPassed
}

private func test2(testNum: Int) -> TestResults {
    // Call the task function and report "testNotImplemented if it returns nil
    guard let result = task2() else { return .testNotImplemented }

    // test that we saw some use of savedPrint
    guard savedPrint.count > 0 else {
        return fail(testNum, "Expected use of testPrint()")
    }

    // Captuure the first thing printed which should be the instruction to enter a name ro "done"
    let firstQuerry = savedPrint[0]
    // filter out nil values and empty strings
    var nonNilInput = savedInput.compactMap { $0 }.filter { $0 != "" }

    // check that the last input was "done"
    guard nonNilInput.count > 0, nonNilInput[nonNilInput.count - 1] == "done" else {
        return fail(testNum, "Expected last input to be 'done', but last input was \((nonNilInput.count > 0) ? nonNilInput[nonNilInput.count - 1] : "nil")")
    }

    // remove done from the nonNilInput Array
    nonNilInput.removeLast()
    // test for correct return value
    guard result == nonNilInput.count else {
        return fail(testNum, "Expected return value to be count of non-nil readLine() calls: \(nonNilInput.count), but function returned \(result)")
    }

    // remove any nil values and any use of the instruction message from the cache of testPrint() calls
    let helloMessages = savedPrint.compactMap { $0 }.filter { $0 != firstQuerry }
    // check that our remaining messages all start with "Hello"
    let nonHelloMessages = helloMessages.filter { !$0.hasPrefix("Hello ") }
    guard nonHelloMessages.count == 0 else {
        return fail(testNum, "Only testPrint() calls should be resuest to user to input a name and 'Hello ' responses, but had '\(nonHelloMessages[0])'")
    }

    // We should have one "Hello " message per non-empty name input to testReadLine()
    guard helloMessages.count == nonNilInput.count else {
        return fail(testNum, "Expected one Hello message per name input. Had \(nonNilInput.count) names input, but had \(helloMessages.count) Hello messages")
    }

    // Check for correctly formatted Hello messages. These are warning errors since they could somewhat
    // correctly use different spacing, etc. but we warn them so they can note if their messages vary widely
    // from what we expected
    for index in 0 ..< helloMessages.count {
        // we already confirmed that helloMessages.count == nonNilInput.count so we can index them together
        let expectedMessage = "Hello \(nonNilInput[index])!"
        if helloMessages[index] != expectedMessage {
            print("Task \(testNum) Warning: Expected '\(expectedMessage)', but printed '\(helloMessages[index])'")
        }
    }

    return .testPassed
}

private func test3(testNum: Int) -> TestResults {
    // Call the task function and report "testNotImplemented if it returns nil
    guard let result = task3() else { return .testNotImplemented }

    // Make sure resulting Array has 5 elements
    guard result.count == 5 else {
        return fail(testNum, "Return value should contain 5 closures, but had \(result.count)")
    }

    // Define some hard-wired tests rather than generating random tests for this Task
    struct testStruct {
        let num: Int // which closure are we testing
        let p1: Int // first parameter to pass into the closrue for this test
        let p2: Int // second parameter to pass into the closrue for this test
        let want: Int // value that we want returned from the closure
    }
    let tests = [
        testStruct(num: 0, p1: 1, p2: 2, want: 3), // 1 + 2 = 3
        testStruct(num: 0, p1: -1, p2: 1, want: 0), // -1 + 1 = 0
        testStruct(num: 1, p1: 1, p2: 7, want: 7), // 1 * 7 = 7
        testStruct(num: 1, p1: -2, p2: 3, want: -6), // -2 * 3 = -6
        testStruct(num: 1, p1: 0, p2: 3, want: 0), // 0 * 3 = 0
        testStruct(num: 2, p1: -2, p2: 3, want: -1), // -2 < 3 -> -1
        testStruct(num: 2, p1: -4, p2: -4, want: 0), // -4 == -4 -> 0
        testStruct(num: 2, p1: -2, p2: -3, want: 1), // -2 > -3 -> 1
        testStruct(num: 3, p1: -2, p2: 0, want: -1), // -2 < 0 -> -1
        testStruct(num: 3, p1: 6, p2: 0, want: -2), // 6 >= test3Array.count -> -2
        testStruct(num: 3, p1: 0, p2: 0, want: 0), // test3Array[0] != 0 -> 0
        testStruct(num: 3, p1: 4, p2: 0, want: 0), // test3Array[4] != 0 -> 0
        testStruct(num: 3, p1: 5, p2: 0, want: 1), // test3Array[5] == 0 -> 1
        testStruct(num: 3, p1: 2, p2: 3, want: 1), // test3Array[2] == 3 -> 1
        testStruct(num: 4, p1: 1, p2: 3, want: -1), // 1 and 3 both odd -> -1
        testStruct(num: 4, p1: -2, p2: 4, want: 1), // -2 and 4 both even -> 1
        testStruct(num: 4, p1: 1, p2: 2, want: 0), // 1 odd 2 even -> 0
        testStruct(num: 4, p1: 2, p2: 1, want: 0), // 2 odd 1 even -> 0
    ]

    // Default passing, but we do not stop this on the first failure so record any failure.
    var myReturnValue = TestResults.testPassed
    for test in tests {
        let aFunc = result[test.num]
        let retVal = aFunc(test.p1, test.p2)
        // Report error if closure did not return the desired value
        if retVal != test.want {
            myReturnValue = fail(testNum, "Called closure \(test.num) with (\(test.p1), \(test.p2)). Expected \(test.want), but closure returned \(retVal)")
        }
    }

    return myReturnValue
}

//  Note about random arrays: we have seen code that contained something like
//  the following to create an array of random numbers:
//      Array(repeating: Int.random(in: 1...100), count: 10)
//  Unfortunately this actually just picks a single random number in the range
//  and reoeats that one number across the array.
//  You can generate a random array using a for loop, which we expect most to use for Task 8.
//  Another correct way to do this is something like this:
//      (0..<10).map{_ in Int.random(in: 1...100)}
//  Here is another way if you want to have all the numbers from 0 to size-1 with no repeats
//      Array(0..<size).shuffled()

private func test4(testNum: Int) -> TestResults {
    // Do tests with five random arrays
    for _ in 0 ..< 5 {
        // Set up random Array parameter
        let testArray = (0 ..< 10).map { _ in Int.random(in: 1 ... 100) }

        // Call the task function and report "testNotImplemented if it returns nil
        guard let result = task4(inArray: testArray) else { return .testNotImplemented }

        // Compare returned value to expected value
        let testTarget = testArray.map { $0 * $0 }.filter { $0 % 10 != 1 }
        guard result == testTarget else {
            print("Task \(testNum) Error: Incorrect return value")
            print("Passed in: '\(testArray)'")
            print("Expected: '\(testTarget)'")
            print("Returned: '\(result)'")
            return .testFailed
        }
    }

    return .testPassed
}

private func test5(testNum: Int) -> TestResults {
    // Do tests with five random arrays
    for _ in 0 ..< 5 {
        // Set up random Array parameter
        let testArray = (0 ..< 10).map { _ in Int.random(in: -100 ... 100) }

        // Call the task function and report "testNotImplemented if it returns nil
        guard let result = task5(inArray: testArray) else { return .testNotImplemented }

        // Compare returned value to expected value
        let testTarget = testArray.reduce(0,+)
        guard result == testTarget else {
            print("Task \(testNum) Error: Incorrect return value")
            print("Passed in: '\(testArray)'")
            print("Expected: '\(testTarget)'")
            print("Returned: '\(result)'")
            return .testFailed
        }
    }
    return .testPassed
}

private func test6(testNum: Int) -> TestResults {
    // Do tests with five random arrays
    for _ in 0 ..< 5 {
        // Set up random Array parameter
        // Limit it to 10 numbers -10 to 10 to avoid integer overflow
        let testArray = (0 ..< 10).map { _ in Int.random(in: -10 ... 10) }

        // Call the task function and report "testNotImplemented if it returns nil
        guard let result = task6(inArray: testArray) else { return .testNotImplemented }

        let testTarget = testArray.reduce(1,*)
        guard result == testTarget else {
            print("Task \(testNum) Error: Incorrect return value")
            print("Passed in: '\(testArray)'")
            print("Expected: '\(testTarget)'")
            print("Returned: '\(result)'")
            return .testFailed
        }
    }
    return .testPassed
}

private func test7(testNum: Int) -> TestResults {
    // Specify the array we will pass in
    let passArray = [7, 2, 5, 3, 1, 9]
    // Specify the expected values according to the instructions
    // We could organize this as a one dimensional array
    // but it seemed cleaner to list the four steps separately
    let wantedResults: [[Int]] = [
        [2, 3, 4, 5, 6, 7],
        [1, 2, 3, 4, 5, 6, 7, 8, 9],
        [5, 4, 3, 2, 1, 0],
        // The final instruction is to return the values from the input array
        // so we include it in the wantedResults
        passArray,
    ]

    // Call the task function and report "testNotImplemented if it returns nil
    guard let result = task7(inArray: passArray) else { return .testNotImplemented }

    // We use for...in to step through wantedResults, but we also need to index through the result
    var resultIndex = 0
    // Step through the desired results
    for row in wantedResults {
        for anInt in row {
            // Compare the wanted result to the actual returned values
            guard anInt == result[resultIndex] else {
                return fail(testNum, "Expected item at index \(resultIndex) in returned array to be \(anInt), but it was \(result[resultIndex])")
            }
            // Increment to the next returned value
            resultIndex += 1
        }
    }

    return .testPassed
}

private func test8(testNum: Int) -> TestResults {
    // Do tests with five random arrays
    for _ in 0 ... 5 {
        // Each time choose random parameters
        let myRowCount = Int.random(in: 10 ... 30)
        let myColumnCount = Int.random(in: 10 ... 30)
        let myRange = Int.random(in: 0 ... 10) ... Int.random(in: 20 ... 30)

        // Call the task function and report "testNotImplemented if it returns nil
        guard let result = task8(rowCount: myRowCount, columnCount: myColumnCount, aRange: myRange)
        else { return .testNotImplemented }

        // Make sure the row count is correct
        guard result.count == myRowCount else {
            return fail(testNum, "Expected \(myRowCount) rows, result has \(result.count) rows")
        }

        // Step through the rows
        for oneRow in result {
            // Make sure the column counts is correct in each row
            guard oneRow.count == myColumnCount else {
                return fail(testNum, "Expected \(myColumnCount) columns, result has \(oneRow.count) columns")
            }
            // Mke sure the random numbers are in the expected range
            for oneInt in oneRow {
                guard myRange.contains(oneInt) else {
                    return fail(testNum, "Value \(oneInt) not in assigned range \(myRange)")
                }
            }
        }
    }

    return .testPassed
}

private func test9(testNum: Int) -> TestResults {
    // Do tests with five random arrays
    for _ in 0 ... 5 { // Run the test 5 times
        // Each time send a random array
        let myArray = Array(repeating: Array(repeating: Int.random(in: 0 ... 40), count: Int.random(in: 10 ... 30)), count: Int.random(in: 10 ... 30))

        // Call the task function and report "testNotImplemented if it returns nil
        guard let result = task9(intValues: myArray) else { return .testNotImplemented }

        // Make sure the number of rows in the result matches the input
        guard result.count == myArray.count else {
            return fail(testNum, "Expected \(myArray.count) rows, result has \(result.count) rows")
        }

        // Step through the rows
        for rowNum in 0 ..< result.count {
            // Make sure the result has 3 columns in each row
            guard result[rowNum].count == 3 else {
                return fail(testNum, "Expected 3 columns, result has \(result[rowNum].count) columns")
            }

            // Calculate the min from the array. Since it has >0 valid elements, min() should never return nil.
            guard let myMin = myArray[rowNum].min() else { return fail(testNum, "Testing Error") }
            // Make sure the first value is the correct minimum for each row
            guard Double(myMin) == result[rowNum][0] else {
                return fail(testNum, "Expected mininum of row \(rowNum) to be \(Double(myMin)), result has \(result[rowNum][0])")
            }

            // Calculate the max from the array. Since it has >0 valid elements, max() should never return nil.
            guard let myMax = myArray[rowNum].max() else { return fail(testNum, "Testing Error") }
            // Make sure the second value is the correct maximum for each row
            guard Double(myMax) == result[rowNum][1] else {
                return fail(testNum, "Expected maximum of row \(rowNum) to be \(Double(myMax)), result has \(result[rowNum][1])")
            }

            // Calculate the mean or average
            let myAverage = Double(myArray[rowNum].reduce(0,+)) / Double(myArray[rowNum].count)
            // Make sure the third value is the correct mean for each row
            guard myAverage == result[rowNum][2] else {
                return fail(testNum, "Expected average of row \(rowNum) to be \(myAverage), result has \(result[rowNum][2])")
            }
        }
    }

    return .testPassed
}
