// *************************
//  Do not modify this file!
// *************************
//  You are welcome to read this file and to try to understand it, but it may include
//  elements of Swift that have not yet been taught in the course at this point.
//  Your assignment is to edit tasks.swift and then run this file and tasks.swift in a project.
//  The code in this file will test your task functions and indicate which task functions pass.
//  It will also provide diagnostic information if a task function fails. You should definitely
//  not try to just copy code from a test here to your task, but instead, understand how to
//  correctly create a task that meets the needs of the test.
//
//  main.swift
//  Week 3 Tasks
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
 •    Create class
 •    Create two child classes
 •    Create struct
 •    Example of function returning tuples
 Task 1
 •    computed (read-only) property
 •    Apply protocol to class and ensure property compliance
 •    Apply protocol to struct and ensure property compliance
 •    Construct objects of class and struct types
 •    Use a tuple to return multiple values from a function
 Task 2
 •    Add methods to a struct
 •    Add items to array only if not already added
        (helps prepare them for Dictionary next week)
 •    mutating keyword for some struct methods
 •    Apply an additional protocol to ensure method compliance
 Task 3
 •    Work with ranges
 •    Use an array to simulate a decreasing range
 •    Use Any to return two different Types of values
 Task 4
 •    Call a previous task function from another task function
 •    Use "is" to determine what has been returned
 Task 5
 •    Arrays of Any?
 •    Use compactMap to unpack values inside an array removing nil values
 •    Use "is" to determine the type of values in an Array
 •    Show "is" works correctly on optional values
 Task 6
 •    Arrays of Any?
 •    Use compactMap to unpack values inside an array removing nil values
 •    Use "is" to determine the type of values in an Array
 •    Use "as?" to extract underlying values
 •    Demonstrate converting types from Int and String to Double
        after first extracting underlying values
 •    Use built in values of basic types (Double.infinity)
Task 7
 •    Using an extension to add a computed property to a class
 •    Conforming with CustomStringConvertible using the
        computed "description" property
 •    Formatting properties into a String for printing
 •    String interpolation
 •    using is and as? to determine whether an object is a
        member of the parent or child class and to access
        properties from the child class as needed
Task 8
 •    Use an existing extension to override an operator
 •    Conform to the Equatable protocol
 •    Have a function return a closure to facilitate testing)
 Task 9
 •    Create an new extension to override an operator
 •    Conform to the Comparable protocol
 •    Have a function return a closure (to facilitate testing)
 Task 10
 •    Example of custom infix operator and setting precedence
 •    Use an extension to create a new custom operator
 •    Use filter() to identify expired and non-expired MedicationContainers
 •    Use sorted() (rather than sort())
 •    Have a function return a closure (to facilitate testing)
 */

//  ========= Tests =========

// To reorder tasks, just change the numbers in the names of the task function stub, the test function
// and the call of the task function in the test function. All else should cleanly adjust.

private func test0(testNum: Int) -> TestResults {

    let (container1, container2): (Any, Any) = task0()
    //  The first item should contain a LiquidMedicationContainer stored in a variable of Type MedicationContainer
    //  The second item should contain a TabletMedicationContainer stored in a variable of Type MedicationContainer
    //  Make them all Any so we don't get warning errors about some of the following tests
    //  being always true

    //  Check that aStockTracker is still a PharmaceuticalStockTracker
    //  To avoid warning errors we copy it to an Any object and then do
    //  the test.
    let tracker: Any = aStockTracker
    guard tracker is PharmaceuticalStockTracker else {
        return fail(testNum, "aStockTracker should be a PharmaceuticalStockTracker")
    }
    //  Make sure aStockTracker (and PharmaceuticalStockTracker) is a struct, not a class
    guard Mirror(reflecting:aStockTracker).displayStyle == .struct else {
        return fail(testNum, "aStockTracker should be a struct, but it is a class")
    }
 
    //  make sure container1 is a LiquidMedicationContainer and container3 is a TabletMedicationContainer
    guard container1 is LiquidMedicationContainer else {
        if container1 is TabletMedicationContainer  {
            return fail(testNum, "Second returned value should be a LiquidMedicationContainer, but it is a TabletMedicationContainer")
        } else {
            return fail(testNum, "Second returned value should be a LiquidMedicationContainer, but it is a MedicationContainer")
        }
    }
    guard container2 is TabletMedicationContainer else {
        if container2 is LiquidMedicationContainer {
            return fail(testNum, "Third returned value should be a TabletMedicationContainer, but it is a LiquidMedicationContainer")
        } else {
            return fail(testNum, "Third returned value should be a TabletMedicationContainer, but it is a MedicationContainer")
        }
    }

    return .testPassed
}

protocol TrackerProtocol {
    var inStockMedications: [MedicationContainer] { get set }
}
protocol ContainerProtocol {
    var id: String { get }
    var name: String { get }
    var expirationDate: Date { get }
    var isExpired: Bool { get }
}
protocol LiquidContainerProtocol {
    var volume: Double  { get }
    var concentration: Int  { get }
    var concentrationUnits: String  { get }
}
protocol TabletContainerProtocol {
    var pillCount: Int { get }
    var potency: Double { get }
    var potencyUnits: String { get }
}

struct testItem {
    let name: String
    let expDays: Int
    let volume: Double?
    let concentration: Int?
    let concentrationUnits: String?
    let pillCount: Int?
    let potency: Double?
    let potencyUnits: String?
    let wantResult: Bool // different tests can interpret this differently

    //  Possibly setting a bad example, override the initializer to allow
    //  very short or missing parameter names. This is a fixed table
    //  that may be very long and we don't want to clutter it
    //  so abbreviate the first two and last two, let the others be unnamed
    //  and let the second use a default if we are not doing things with dates
    init(n name: String, d expDays: Int = 180, _ volume: Double?, _ concentration: Int?, _ concentrationUnits: String?, _ pillCount: Int?, _ potency: Double?, _ potencyUnits: String?, want wantResult: Bool = true) {
        self.name = name
        self.expDays = expDays
        self.volume = volume
        self.concentration = concentration
        self.concentrationUnits = concentrationUnits
        self.pillCount = pillCount
        self.potency = potency
        self.potencyUnits = potencyUnits
        self.wantResult = wantResult
    }
}
func testContainer(_ t: testItem) -> MedicationContainer? {
    if let volume = t.volume { // specified volume so want liquid container
        let concentration = t.concentration ?? 1
        let concentrationUnits = t.concentrationUnits ?? "ml"
        return LiquidMedicationContainer(name: t.name, expirationDate: futureDate(daysFromNow: t.expDays), volume: volume, concentration: concentration, concentrationUnits: concentrationUnits)
    } else if let pillCount = t.pillCount { // specified pillCount so want tablet container
        let potency = t.potency ?? 1
        let potencyUnits = t.potencyUnits ?? "mg"
        return TabletMedicationContainer(name: t.name, expirationDate: futureDate(daysFromNow: t.expDays), pillCount: pillCount, potency: potency, potencyUnits: potencyUnits)
    } else {
        return nil // cannot instantiate the parent class type
    }
}

//  One challenge with these functions was to find a way to let the files compile
//  and then have the student add functionality which can be tested.
//  The solution taken is to have the student add a protocol to each class or struct
//  after they do their work that will confirm they added the correct properties
//  and methods. But in Swift we can use protocols as pseudo types so once we have
//  confirmed that they added protocol conformance, we can create an object of the
//  protocol type and use that to access properties or methods that did not exist
//  when the code was initially compiling as they worked on earlier tasks. Note that
//  this is not needed for task 0 since we allow the files to not compile until they
//  implement task 0.
private func test1(testNum: Int) -> TestResults {
    // Call the task function and report "testNotImplemented if it returns nil
    let (container1, container2) = task1()
    let tracker: Any = aStockTracker
    guard let container1: Any = container1 else { return .testNotImplemented }
    guard let container2: Any = container2 else { return .testNotImplemented }

    // Make sure each type conforms to its  protocol
    guard tracker is TrackerProtocol else {
        return fail(testNum, "PharmaceuticalStockTracker needs to conform to TrackerProtocol")
    }
    guard container1 is LiquidContainerProtocol else {
        return fail(testNum, "LiquidMedicationContainer needs to conform to LiquidContainerProtocol")
    }
    guard container2 is TabletContainerProtocol else {
        return fail(testNum, "TabletMedicationContainer needs to conform to TabletContainerProtocol")
    }

    // Test the functionality of .isExpired
    let tests: [testItem] = [
        testItem(n: "med", d: 50, 2.0,1,"ml", nil,nil,nil, want: false), // 50 days in past
        testItem(n: "med", d: 1, 2.0,1,"ml", nil,nil,nil, want: false), // 1 day in future
        testItem(n: "med", d: -1, 2.0,1,"ml", nil,nil,nil, want: true), // 1 day in past
        testItem(n: "med", d: -30, 2.0,1,"ml", nil,nil,nil, want: true), // 30 days in the past
    ]
    // create a temporary MedicationContainer, convert it to ContainerProtocol and return .isExpired

    for test in tests {
        guard let aContainer: Any = testContainer(test) else {
            return fail(testNum, "Internal testing error. Test tried to instantiate an object of the parent class type")
        }
        guard let protocolItem = aContainer as? ContainerProtocol else {
            return fail(testNum, "MedicationContainer does not conform to ContainerProtocol")
        }
        guard protocolItem.isExpired == test.wantResult else {
            switch test.wantResult {
                case false: return fail(testNum, "MedicationContainer.isExpired should be false for an expiration date \(test.expDays) day(s) from now")
                case true: return fail(testNum, "MedicationContainer.isExpired should be false for an expiration date \(test.expDays) day(s) from now")
            }
        }
    }

    return .testPassed
}

protocol TrackerProtocol2 {
    var inStockMedications: [MedicationContainer] { get set }
    
    mutating func addContainer(_ container: MedicationContainer) -> Bool
    func count(of name: String) -> Int
}
private func test2(testNum: Int) -> TestResults {
    guard let returnValue = task2() else { return .testNotImplemented }
    if returnValue != true {
        return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
    }
 
    // Test the functionality of addContainer() and count(of:)
    let testContainerSpecifications: [testItem] = [
        testItem(n: "med1", d: 90, 0.01,2,"cc", nil,nil,nil), // One LiquidMedicationContainers
        testItem(n: "med2", d: 90, 2.0,1,"ml", nil,nil,nil), // Two LiquidMedicationContainers
        testItem(n: "med2", d: 90, 2.5,2,"oz", nil,nil,nil),
        testItem(n: "med3", d: 90, nil,nil,nil, 30,4.1,"mg"), // Three TabletMedicationContainers
        testItem(n: "med3", d: 90, nil,nil,nil, 60,1.0,"mg"),
        testItem(n: "med3", d: 90, nil,nil,nil, 90,4.1,"meq"),
    ]
    // set up some containers
    var containers: [MedicationContainer] = []
    for spec in testContainerSpecifications {
        guard let aContainer = testContainer(spec) else {
            return fail(testNum, "Internal testing error. Could not create test container")
        }
        containers.append(aContainer)
    }
    // Add one container and check the count

    let anyTracker: Any = aStockTracker
    guard var tracker = anyTracker as? TrackerProtocol2 else {
        return fail(testNum, "aStockTracker does not conform to TrackerProtocol2")
    }
    guard tracker.addContainer(containers[0]) else {
        return fail(testNum, "addContainer() returned false when adding first MedicationContainer object")
    }
    guard tracker.inStockMedications.count == 1 else {
        return fail(testNum, "Expected inStockMedications.count to be 1 after adding first MedicationContainer object, but it was \(tracker.inStockMedications.count)")
    }
    var aCount = tracker.count(of: "med1")
    guard aCount == 1 else {
        return fail(testNum, "count(of: \"med1\") returned \(aCount) when there was one medicationContainer added with that name")
    }
    aCount = tracker.count(of: "medNone")
    guard aCount == 0 else {
        return fail(testNum, "count(of: \"med1\") returned \(aCount) when there were mo medicationContainers added with name = \"medNone\"")
    }
    
    // Try to add the same container and check the count
    guard !tracker.addContainer(containers[0]) else {
        return fail(testNum, "addContainer() returned true when trying to add the same  MedicationContainer a second time")
    }
    guard tracker.inStockMedications.count == 1 else {
        return fail(testNum, "After trying to add the same MedicationContainer object twice, expected inStockMedications.count to be 1, but it was \(tracker.inStockMedications.count)")
    }

    // Add two Liquid containers and check the count
    guard tracker.addContainer(containers[1]) else {
        return fail(testNum, "addContainer() returned false when adding second MedicationContainer object (which was actually a LiquidMedicationContainer")
    }
    guard tracker.addContainer(containers[2]) else {
        return fail(testNum, "addContainer() returned false when adding third MedicationContainer object (which was actually a LiquidMedicationContainer")
    }
    guard tracker.inStockMedications.count == 3 else {
        return fail(testNum, "Expected inStockMedications.count to be 3 after adding three MedicationContainer objects, but it was \(tracker.inStockMedications.count)")
    }
    aCount = tracker.count(of: "med2")
    guard aCount == 2 else {
        return fail(testNum, "count(of: \"med2\") returned \(aCount) when there were two medicationContainer added with that name")
    }

    // Try to add the same liquid container and check the count
    guard !tracker.addContainer(containers[1]) else {
        return fail(testNum, "addContainer() returned true when trying to add the same  LiquidMedicationContainer a second time")
    }
    guard tracker.inStockMedications.count == 3 else {
        return fail(testNum, "After adding 3, then trying to add the same LiquidMedicationContainer object again, expected inStockMedications.count to still be 3, but it was \(tracker.inStockMedications.count)")
    }

    // Add three tablet containers and check the count
    guard tracker.addContainer(containers[3]) else {
        return fail(testNum, "addContainer() returned false when adding fourth MedicationContainer object (which was actually a TabletMedicationContainer")
    }
    guard tracker.addContainer(containers[4]) else {
        return fail(testNum, "addContainer() returned false when adding fifth MedicationContainer object (which was actually a TabletMedicationContainer")
    }
    guard tracker.addContainer(containers[5]) else {
        return fail(testNum, "addContainer() returned false when adding sixth MedicationContainer object (which was actually a TabletMedicationContainer")
    }
    guard tracker.inStockMedications.count == 6 else {
        return fail(testNum, "Expected inStockMedications.count to be 6 after adding six MedicationContainer objects, but it was \(tracker.inStockMedications.count)")
    }
    aCount = tracker.count(of: "med3")
    guard aCount == 3 else {
        return fail(testNum, "count(of: \"med3\") returned \(aCount) when there were three medicationContainer added with that name")
    }
  
    // Try to add the same tablet container and check the count
    guard !tracker.addContainer(containers[3]) else {
        return fail(testNum, "addContainer() returned true when trying to add the same  TabletMedicationContainer a second time")
    }
    guard tracker.inStockMedications.count == 6 else {
        return fail(testNum, "After adding 6, then trying to add the same LiquidMedicationContainer object again, expected inStockMedications.count to still be 6, but it was \(tracker.inStockMedications.count)")
    }

    return .testPassed
}


private func test3(testNum: Int) -> TestResults {
    // Do 5 random tests of to generate a Range or an Array
    for _ in 0..<5 {
        let aTuple = (Int.random(in: -10...10), Int.random(in: -10...10))
        guard let returnValue = generateRange(aTuple.0, aTuple.1) else { return .testNotImplemented }
        if aTuple.0 <= aTuple.1 { // should return a ClosedRange
            guard let returnRange = returnValue as? ClosedRange<Int> else {
                return fail(testNum, "Called task\(testNum)(\(aTuple.0), \(aTuple.1)), but it did not return a ClosedRange as expected")
            }
            guard returnRange == aTuple.0...aTuple.1 else {
                return fail(testNum, "Called task\(testNum)(\(aTuple.0), \(aTuple.1)) so expected \(aTuple.0...aTuple.1) but returned \(returnRange)")
            }
        } else { // should return an Array
            guard let returnArray = returnValue as? Array<Int> else {
                return fail(testNum, "Called task\(testNum)(\(aTuple.0), \(aTuple.1)), but it did not return an Array as expected")
            }
            guard returnArray.count == aTuple.0 - aTuple.1 + 1 else {
                return fail(testNum, "Called task\(testNum)(\(aTuple.0), \(aTuple.1)) and expected an Array of size \(aTuple.0 - aTuple.1 + 1) but it returned an Array of size \(returnArray.count)")
            }
            var wantedInt = aTuple.0
            for anIndex in 0..<returnArray.count {
                // we do not just use "for aValue in returnArray" because we
                // need testIndex for the error messages
                let aValue = returnArray[anIndex]
                guard aValue == wantedInt else {
                    return fail(testNum, "Called task\(testNum)(\(aTuple.0), \(aTuple.1)) so expected returnedArray[\(anIndex)] to be \(wantedInt) but returned \(aValue)")
                }
                wantedInt -= 1
            }
        }
    }
    return .testPassed
}

private func test4(testNum: Int) -> TestResults {
    // Do 5 random tests of to generate a Range or an Array
    for _ in 0..<5 {
        let aTuple = (Int.random(in: -10...10), Int.random(in: -10...10))
        guard let returnValue = task4(aTuple.0, aTuple.1) else { return .testNotImplemented }
        switch returnValue {
        case 1:
            if aTuple.0 <= aTuple.1 { break }
            else { return fail(testNum, "Called task\(testNum)(\(aTuple.0), \(aTuple.1)) and expected return of 2, but returned 1")
            }
        case 2:
            if aTuple.0 > aTuple.1 { break }
            else { return fail(testNum, "Called task\(testNum)(\(aTuple.0), \(aTuple.1)) and expected return of 2, but returned 1")
            }
        default:
            return fail(testNum, "Called task\(testNum)(\(aTuple.0), \(aTuple.1)) and returned \(returnValue) which should not happen if task\(testNum) is called and is correct")
        }
    }
    return .testPassed
}


// This lets us print an Optional array without the clutter of (optional) in front of all the
// non-nil values
private func optionalArrayToString(_ anyArray: [Any?]) -> String {
    var returnValue = ""
    var didFirst = false
    for aValue in anyArray {
        // code to put comma and space before all values except the first
        if didFirst { returnValue += ", "}
        else { didFirst = true }
        // is the value not nil
        if let aValue = aValue {
            // if it is a String, leave it as a String including quotes
            if let stringValue = aValue as? String {
                returnValue += "\"" + stringValue + "\""
            } else {
            // Otherwise turn it into a string value
                returnValue += String(describing: aValue)
            }
        } else {
            returnValue += "nil"
        }
    }
    return returnValue
}

private func test5(testNum: Int) -> TestResults {
    let testAnyArray: [Any?] = [12, nil, 3.5, "2.9", true, nil, "word", "two", -10, 0, nil, 0.0, "42", "last"]
    let want5: [Int] = [
        1, 2, 3, 3, 3, 1, 1, 2, 3, 3
    ]

    guard let returnValue = task5(testAnyArray) else { return .testNotImplemented }

    // Print the input and output values to help the student debug
    print(">> Task\(testNum) called with: \(optionalArrayToString(testAnyArray))")
    print(">> Returned: \(returnValue)")

    // Make sure returned array is the correct size
    guard returnValue.count == want5.count else {
        return fail(testNum, "Expected returnValue to have \(want5.count) elements, but it had \(returnValue.count) elements")
    }

    // Compare one by one so we can tell them the first element that is wrong
    // rather than giving them the entire correct answer all at once
    for index in 0..<want5.count {
        guard returnValue[index] == want5[index] else {
            return fail(testNum, "Expected returnValue[\(index)] to be \(want5[index]) but it was \(returnValue[index])")
        }
    }

    return .testPassed
}

private func test6(testNum: Int) -> TestResults {
    let testAnyArray: [Any?] = [12, nil, 3.5, "2.9", true, nil, "word", "two", -10, 0, nil, 0.0, "42", "last"]
    let want6: [Double] = [ 12.0, 3.5, 2.9, Double.infinity, -10.0, 0.0, 0.0, 42.0]

    guard let returnValue = task6(testAnyArray) else { return .testNotImplemented }

    // Print the input and output values to help the student debug
    print(">> Task\(testNum) called with: \(optionalArrayToString(testAnyArray))")
    print(">> Returned: \(returnValue)")

    // Make sure returned array is the correct size
    guard returnValue.count == want6.count else {
        return fail(testNum, "Expected returnValue to have \(want6.count) elements, but it had \(returnValue.count) elements")
    }

    // Compare one by one so we can tell them the first element that is wrong
    // rather than giving them the entire correct answer all at once
    for index in 0..<want6.count {
        guard returnValue[index] == want6[index] else {
            return fail(testNum, "Expected returnValue[\(index)] to be \(want6[index]) but it was \(returnValue[index])")
        }
    }

    return .testPassed
}

// Utilities to pull pieces out of dates to match to printing
extension Date {
    func yearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    func monthString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
    func dayOfMonthString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
}
// Check to make sure the last printed line contains some strings and does not contain other strings
private func matchPrint(called: String, matches: [String], notMatches: [String]) -> (String, Bool) {
    // "called" is the string to use to describe what was called that produced the last printed line
    // returns ("", true) if all is good
    // returns (errorString, false) if there is an error
 
    // Make sure we can access the last line printed
    guard savedPrint.count > 0, let lastPrint = savedPrint[savedPrint.count - 1] else {
        return ("Expected \(called)\n\tto print, but it did not", false)
    }
    for s in matches {
        guard lastPrint.lowercased().contains(s.lowercased()) else {
            return ("Expected print from \(called)\n\tto contain \(s), but it did not", false)
        }
    }
    for s in notMatches {
        guard !lastPrint.lowercased().contains(s.lowercased()) else {
            return ("Expected print from \(called)\n\tto not contain \(s), but it did", false)
        }
    }
    return ("", true)
}

private func test7(testNum: Int) -> TestResults {
 
    guard let returnValue1 = task7() else { return .testNotImplemented }
    if returnValue1 != true {
        return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue1)")
    }

    // Set up and test "a" container
    guard let aContainer = testContainer(testItem(n: "Med", d: 90, nil,nil,nil, 90,30,"MEQ")) else { // TabletMedicationContainer
        return fail(testNum, "Internal testing error. Could not create test container.")
    }
    testPrint(aContainer)
    
    // include the year and day of month since those should
    // be there for any date format they choose
    let matches1 = ["Tablet", "Med", "90","30", "MEQ", aContainer.id, aContainer.expirationDate.yearString(), aContainer.expirationDate.dayOfMonthString()]
    let notMatches1 = ["Liquid"]
    var (errorString, matchGood) = matchPrint(called: "task\(testNum)(\n\t\(aContainer))", matches: matches1, notMatches: notMatches1)
    guard matchGood else {
        print()
        return fail(testNum, errorString)
    }
   
    // Set up and test "b" container
    guard let bContainer = testContainer(testItem(n: "Children's TYLENOL", d: 120, 120,160,"mg/5ml", nil,nil,nil)) else { // LiquidMedicationContainer
         return fail(testNum, "Internal testing error. Could not create test container.")
     }
    testPrint(bContainer)

    let matches2 = ["Liquid", "Children's TYLENOL", "120.0", "160", "mg/5ml", bContainer.id, bContainer.expirationDate.yearString(), bContainer.expirationDate.dayOfMonthString()]
    let notMatches2 = ["Tablet"]
    (errorString, matchGood) = matchPrint(called: "task\(testNum)(\n\t\(bContainer))", matches: matches2, notMatches: notMatches2)
    guard matchGood else {
        print()
        return fail(testNum, errorString)
    }

    // Set up and test "c" container
    guard let cContainer = testContainer(testItem(n: "TYLENOL", d: 180, nil,nil,nil, 100,500,"mg")) else { // Another TabletMedicationContainer
        return fail(testNum, "Internal testing error. Could not create test container.")
    }
    testPrint(cContainer)

    let matches3 = ["Tablet", "TYLENOL", "100", "500.0", "mg", cContainer.id, cContainer.expirationDate.yearString(), cContainer.expirationDate.dayOfMonthString()]
    let notMatches3 = ["Liquid"]
    (errorString, matchGood) = matchPrint(called: "task\(testNum)(\n\t\(cContainer))", matches: matches3, notMatches: notMatches3)
    guard matchGood else {
        print()
        return fail(testNum, errorString)
    }

    return .testPassed
}
private func test8(testNum: Int) -> TestResults {
    guard let returnedFunction: ((MedicationContainer, MedicationContainer)->Bool) = task8() else { return .testNotImplemented }
    
    // Set up some containers
    guard let aContainer = testContainer(testItem(n: "med1", d: 90, 0.01,2,"cc", nil,nil,nil)), // LiquidMedicationContainer
          let bContainer = testContainer(testItem(n: "med1", d: 90, 0.01,2,"cc", nil,nil,nil)), // Identical LiquidMedicationContainer
          let cContainer = testContainer(testItem(n: "med2", d: 180, nil,nil,nil, 30,4.1,"mg")) else { // TabletMedicationContainer
        return fail(testNum, "Internal testing error. Could not create test containers.")
    }
    
    //  Set up an "Any" version to avoid warning errors about the "is" test below always returning true
    //  or always returning false.
    let aAnyContainer: Any = aContainer
    // Make sure MedicationContainer conforms to Equatable
#if swift(>=5.7)
    guard aAnyContainer is (any Equatable) else {
        return fail(testNum, "Expected MedicationContainer extension to conform to Equatable protocol")
    }
#endif
    // Make sure different containers are not "=="
    guard !returnedFunction(aContainer, cContainer) else {
        return fail(testNum, "Expected \(aContainer) to not == \(cContainer)")
    }
    guard !returnedFunction(aContainer, bContainer) else {
        return fail(testNum, "Expected \(aContainer) to not == \(bContainer) even though they are identical")
    }
    // Make sure a container is "==" to itself
    guard returnedFunction(aContainer, aContainer) else {
        return fail(testNum, "Expected \(aContainer) to == itself")
    }

    return .testPassed
}

private func test9(testNum: Int) -> TestResults {
    guard let returnedFunction: ((MedicationContainer, MedicationContainer)->Bool) = task9() else { return .testNotImplemented }
    
    // Set up some containers
    guard let aContainer = testContainer(testItem(n: "med1", d: 90, 0.01,2,"cc", nil,nil,nil)), // LiquidMedicationContainer
        let bContainer = testContainer(testItem(n: "med1", d: 120, 0.01,2,"cc", nil,nil,nil)), // Another LiquidMedicationContainer, identical except expiration date
        let cContainer = testContainer(testItem(n: "med2", d: 180, nil,nil,nil, 30,4.1," 4")), // TabletMedicationContainer
        let dContainer = testContainer(testItem(n: "med2", d: -10, nil,nil,nil, 30,4.1,"mg")) else { // Another TabletMedicationContainer, expired
        return fail(testNum, "Internal testing error. Could not create test containers.")
    }
    
    //  Set up an "Any" version to avoid warning errors about the "is" test below always returning true
    //  or always returning false.
    let aAnyContainer: Any = aContainer
    // Make sure MedicationContainer conforms to Equatable
#if swift(>=5.7)
    guard aAnyContainer is (any Comparable) else {
        return fail(testNum, "Expected MedicationContainer extension to conform to Comparable protocol")
    }
#endif
    // Make sure "<" compares correctly using expiration date
    guard returnedFunction(bContainer, cContainer) else {
        return fail(testNum, "Expected \(bContainer) < \(cContainer)")
    }
    guard !returnedFunction(cContainer, bContainer) else {
        return fail(testNum, "Expected \(cContainer) > \(bContainer)")
    }

    guard returnedFunction(aContainer, bContainer) else {
        return fail(testNum, "Expected \(aContainer) < \(bContainer)")
    }
    guard !returnedFunction(bContainer, aContainer) else {
        return fail(testNum, "Expected \(bContainer) > \(aContainer)")
    }

    guard returnedFunction(dContainer, aContainer) else {
        return fail(testNum, "Expected \(dContainer) < \(aContainer)")
    }
    guard !returnedFunction(aContainer, dContainer) else {
        return fail(testNum, "Expected \(bContainer) > \(dContainer)")
    }

    return .testPassed
}
