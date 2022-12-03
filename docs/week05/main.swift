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
private var tests: [(Int) -> TestResults] = [test0, test1, test2, test3, test4, test5, test6, test7, test8, test9]
private var taskResults: [TestResults] = Array(repeating: .testNotImplemented, count: tests.count)
private var savedInput: [String?] = []
private var savedPrint: [String?] = []
private var currentTest = 0

//  ========= Start of main body of code =========

//  The lines between here and the call to setupGlobals are the only lines that differ
//  from week 2 in the first part of this file up to the line with "Concepts taught
//  or reinforced in each task".
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

// This function lets us write cleaner code in the tests for all of the error messages
func fail(_ testNum: Int, _ message: String) -> TestResults {
    print("Task \(testNum) Error: \(message)")
    return .testFailed
}

//  ========= Concepts taught or reinforced in each task  =========
/*
 Task 0
 •
 •
 •
 Task 1
 •
 •
 •
 Task 2
 •
 •
 •
 Task 3
 •  random walk
 •
 •
 Task 4
 •  Do-Try-Catch with nil data
 •
 •
 Task 5
 •  Do-Try-Catch with black box
 •
 •
 Task 6
 •  Read Data from Web site
 •
 •
Task 7
 •  Decode data
 •
 •
 Task 8
 •  Decode data on your own
 •
 •
Task 9
 •  Access web site and decode data
 •
 •
 */

//  ========= Tests =========

private var walks: [[Steps]] = []
private var ExpectedURLdata = ""
private func setupGlobals() -> Bool {
    walks = []
    ExpectedURLdata = #"{"post code": "83460", "country": "United States", "country abbreviation": "US", "places": [{"place name": "Rexburg", "longitude": "-111.691", "state": "Idaho", "state abbreviation": "ID", "latitude": "43.7761"}]}"#
    return true
}

private func test0(testNum: Int) -> TestResults {

    guard let returnValue = task0() else { return .testNotImplemented }
        if returnValue != true {
            return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
        }

    return .testPassed
}

private func test1(testNum: Int) -> TestResults {

    guard let returnValue = task1() else { return .testNotImplemented }
        if returnValue != true {
            return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
        }

    return .testPassed
}

private func test2(testNum: Int) -> TestResults {

    guard let returnValue = task2() else { return .testNotImplemented }
        if returnValue != true {
            return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
        }

    return .testPassed
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
private func test3(testNum: Int) -> TestResults {

    walks = []
    guard let returnValue = task3() else { return .testNotImplemented }
        if returnValue != true {
            return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
        }

    guard walks.count >= 5 else {
        return fail(testNum, "Expected task at least 5 random walk tests, but only see \(walks.count)")
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
            passCode = fail(testNum, "Expected walk to produce:\n\t\(expected)\nbut produced\n\t\(String(describing: printed))")
            continue
        }
    }

    return passCode
}

private func test4(testNum: Int) -> TestResults {

    var didWithNil = 0
    var didWithoutNil = 0;
    while didWithNil + didWithoutNil < 5 || didWithNil < 2 || didWithoutNil < 2 {
        var anArray:[Int?] = (-10...10).randomArray(Int.random(in: 5...10))
        var doNil = Int.random(in: 0...1) == 0 // 50% chance of doing nils
        // if we didn't get at least 2 of each then force it
        var firstNil = 0
        if didWithNil + didWithoutNil >= 5 {
            if didWithNil < 2 {
                doNil = true
            } else {
                doNil = false
            }
        }
        if doNil {
            didWithNil += 1
            firstNil = Int.random(in: 0..<anArray.count)
            anArray[firstNil] = nil
            if firstNil < anArray.count / 2 { // nil in first half so add a second
                anArray[Int.random(in: firstNil+1..<anArray.count)] = nil
            }
        } else {
            didWithoutNil += 1
        }
  
        do {
            guard let returnValue = try task4(anArray) else {
                return .testNotImplemented
            }
            guard !doNil else {
                return fail(testNum, "Array with nil in index \(firstNil) should have thrown an error, but returned \(returnValue)")
            }
            let wantResult = anArray.compactMap{$0}.reduce(0,+)
            guard returnValue == wantResult else {
                return fail(testNum, "The following array should have returned the total of \(wantResult), but returned \(returnValue)\n\t\(anArray.compactMap{$0})")
            }
        } catch task4ErrorType.nilValueAt(let errorIndex) {
            guard
                doNil else {
                return fail(testNum, "Array without any nil values threw an error claiming thre was a nil at index \(errorIndex)")
            }
            guard firstNil == errorIndex else {
                return fail(testNum, "Array with first nil values at index \(firstNil) threw an error claiming thre was a nil at index \(errorIndex)")
            }
        } catch {
            return fail(testNum, "Expected throw with task4ErrorType.nilValueAt, but did a throw with other error: \(error)")
        }
        
    }

    return .testPassed
}

private func test5(testNum: Int) -> TestResults {
    
    // make these global
    let testArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    let testReturnValue = [0, nil, 2, 3, nil, 5, nil, 7, nil, 9]
    let throwErrors: [task5ErrorType] = [
        .someError,
        .errorWithInt(17),
        .errorWithString("Expected"),
        .errorWithDouble(14.3)
    ]
    let expectedPrint = [
        "Error: someError",
        "Error: errorWithInt 17",
        "Error: errorWithString Expected",
        "Error: errorWithDouble 14.3"
    ]
    let unexpectedErrorString = "Unexpected error that is actually expected at this point"
    let expectedValueUnexpectedError = "unexpectedError(\"Unexpected error that is actually expected at this point\")"
    var throwIndex = 0;

    func unSpaced(_ stringWithSpaces: String) -> String {
        return stringWithSpaces.filter { $0 != " "}
    }
    enum unexpectedErrorType: Error {
        case unexpectedError(String)
    }
    func canThrow(_ anInt: Int) throws -> Int {
        guard (0..<testReturnValue.count).contains(anInt) else {
            throw unexpectedErrorType.unexpectedError("Expected canThrow to be called with values from the passsed array which are all in 0..<10, but it was called with \(anInt)")
        }
        guard let returnValue = testReturnValue[anInt] else {
            throwIndex += 1
            if throwIndex-1 < throwErrors.count {
                throw throwErrors[throwIndex-1]
            } else {
                throw unexpectedErrorType.unexpectedError(unexpectedErrorString)
            }
        }
        return returnValue
    }

    do {
        guard let returnValue = try task5(intArray: testArray, canThrow: canThrow) else {
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
        return fail(testNum, "Did not expect unexpected error to be thrown from task5 during the first \(testArray.count) integers processed")
    }
    do {
        // Call it one more time passing in a value that will cause it to throw an "expected" unexpected error
        guard let returnValue = try task5(intArray: [1], canThrow: canThrow) else {
            return fail(testNum, "Expected the second call to task5() to throw an error, but instead returned nil")
       }
        return fail(testNum, "Expected second call to task5() to throw an \"unexpected\" error, but instead it returned  \(returnValue)")
    } catch {
        guard savedPrint.count == throwErrors.count else {
            return fail(testNum, "Did not expect throw of an \"unexpected\" error to call testPrint()")
        }
        let expectedError = "unexpectedError(\""+unexpectedErrorString+")\""
        guard String(describing: error) == expectedValueUnexpectedError else {
            return fail(testNum, "Expected String(describing:) the error thrown from the second call to task5() to be:\n\t\(expectedError)\nbut it was:\n\t\(String(describing: error))")
        }
    }
    return .testPassed
}
private func test6(testNum: Int) -> TestResults {

    guard let (returnData, returnString) = task6(aURL: "https://api.zippopotam.us/us/83460") else { return .testNotImplemented }
    guard returnString == ExpectedURLdata else {
        return fail(testNum, "Returned:\n\t\(returnString)\nbut expected return to be\n\t\(ExpectedURLdata)")
    }
    guard String(data: returnData, encoding: .utf8) == returnString else {
        return fail(testNum, "Returned Data does not match Returned String")
    }
    return .testPassed
}

protocol Task7Protocol {
    var name: String { get set }
    var address: String { get set }
    var city: String { get set }
    var state: String { get set }
    var zip: String { get set }
    var country: String { get set }
}
extension Task7Protocol {
    func checkTestData() -> Bool {
        return name == "Equardo Jones" &&
        address == "13 Camino do Oro" &&
        city == "Rexburg" &&
        state == "Idaho" &&
        zip  == "83460" &&
        country == "United States"
    }
}
private func test7(testNum: Int) -> TestResults {

    // We use Any to allow it to compile while the as? tests fail before task8() is completed
    guard let returnValue: Any = task7() else { return .testNotImplemented }
    guard let returnProtocol = returnValue as? Task7Protocol else {
        return fail(testNum, "Expected Task7Data tp conmform to Task7Protocol")
    }
    let wantReturnedString = #"Task7Data(name: "Equardo Jones", address: "13 Camino do Oro", city: "Rexburg", state: "Idaho", zip: "83460", country: "United States")"#
    guard returnProtocol.checkTestData() else {
       return fail(testNum, "Returned value\n\t\(returnProtocol)\ndoes not match\n\t\(wantReturnedString)")
    }

    return .testPassed
}

protocol Task8Protocol1 {
    var placeName: String { get set }
    var longitude: String { get set }
    var state: String { get set }
    var stateAbbreviation: String { get set }
    var latitude: String { get set }
}
extension Task8Protocol1 {
    func checkTestData() -> Bool {
        return placeName == "Rexburg" &&
        longitude == "-111.691" &&
        state == "Idaho" &&
        stateAbbreviation == "ID" &&
        latitude == "43.7761"
    }
}
protocol Task8Protocol2 {
    var postCode: String { get set }
    var country: String { get set }
    var countryAbbreviation: String { get set }
    var placeArray: [Place]  { get set }
}
extension Task8Protocol2 {
    func checkTestData() -> Bool {
        return postCode == "83460" &&
        country == "United States" &&
        countryAbbreviation == "US"
    }
}
private func test8(testNum: Int) -> TestResults {

    let JSONdata = #"{"post code": "83460", "country": "United States", "country abbreviation": "US", "places": [{"place name": "Rexburg", "longitude": "-111.691", "state": "Idaho", "state abbreviation": "ID", "latitude": "43.7761"}]}"#.data(using: .utf8) ?? Data()
// We use Any to allow it to compile while the as? tests fail before task8() is completed
    guard let returnValue: Any = task8(JSONdata: JSONdata) else { return .testNotImplemented }
    guard let returnProtocol = returnValue as? Task8Protocol2 else {
        return fail(testNum, "Expected GeoData tp conmform to Task8Protocol2")
    }
    let returnArray: Any = returnProtocol.placeArray
    guard let returnPlaceArray = returnArray as? [Task8Protocol1] else {
        return fail(testNum, "Expected Place tp conmform to Task8Protocol1")
    }
    let wantReturnedString = #"GeoData(postCode: "83460", country: "United States", countryAbbreviation: "US", placeArray: [Week5Completed.Place(placeName: "Rexburg", longitude: "-111.691", state: "Idaho", stateAbbreviation: "ID", latitude: "43.7761")])"#
    guard returnProtocol.checkTestData() else {
       return fail(testNum, "Returned value\n\t\(returnProtocol)\ndoes not match\n\t\(wantReturnedString)")
    }
    guard returnPlaceArray.count == 1 else {
       return fail(testNum, "Expected placeArry to have one place, but it has \(returnPlaceArray.count) places")
    }
    guard returnPlaceArray[0].checkTestData() else {
       return fail(testNum, "Returned value\n\t\(returnProtocol)\ndoes not match expected\n\t\(wantReturnedString)")
    }

    return .testPassed
}

private func test9(testNum: Int) -> TestResults {

    guard let returnValue: Any = task9(countryCode: "US", postalCode: "95066") else { return .testNotImplemented }

    let returnedString = String(describing: returnValue)
    let wantReturnedString = #"GeoData(postCode: "95066", country: "United States", countryAbbreviation: "US", placeArray: [Week5Completed.Place(placeName: "Scotts Valley", longitude: "-122.0152", state: "California", stateAbbreviation: "CA", latitude: "37.0597")])"#
    guard returnedString == wantReturnedString else {
       return fail(testNum, "Returned \n\t\(returnedString)\ndoes not match expected \n\t\(wantReturnedString)")
    }

    return .testPassed
}
