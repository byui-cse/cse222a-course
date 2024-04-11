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
//  Week 4 Tasks
//

import Foundation

enum TestResults {
    case testNotImplemented
    case testPassed
    case testFailed
}

// This must list the tests in order: test0, test1... so they can be called with their test number and
// not need to hard code the Task name into the test except when calling the task function
var tests: [(Int) -> TestResults] = [test0, test1, test2, test3, test4, test5, test6, test7]
var taskResults: [TestResults] = Array(repeating: .testNotImplemented, count: tests.count)
var savedInput: [String?] = []
var savedPrint: [String?] = []
var currentTest = 0

#if false
    print("savedInput:")
    print(savedInput)
    print("savedPrint:")
    print(savedPrint)
#endif

//  ========= Utility functions =========

//  This prints the a list of the tasks that match a particular status
private func printResults(message: String, message2: String, result: TestResults) {
    // count the tasks in that status
    let resultCount = taskResults.filter { $0 == result }.count
    var toPrint = String(describing: resultCount)
    toPrint += " " + message
    print(toPrint)
    // List the numbers of the tasks that match that status
    if resultCount > 0 {
        toPrint = "    Task numbers \(message2):"
        var first = true // the first one does not need a comma in front of it
        for testNum in 0 ..< tests.count {
            if taskResults[testNum] == result {
                if first { first = false }
                else { toPrint += "," }
                toPrint += " " + String(describing: testNum)
            }
        }
        print(toPrint)
    }
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
 •    Modifying a class: adjust properties and methods
 •    Change computed properties and methods to work with
        inStockMedications now being a Dictionary of Sets
 •    Research how to conform to Hashable and implement
 Task 1
 •    Use an extension to define a new method
 •    Use filter() to identify expired and non-expired MedicationContainers
 •    Use sorted() (not sort())
 Task 2
 •    Work with Dictionaries and Sets
 •    Work with Tuple return values and error codes
 •    Work with enums
 •    Work with Extensions
 •    Add the NDC format checking function to existing Class method
        for adding a MedicationContainer
 •    Use an extension to add a new method that adds a Set of
        MedicationContainers rather just one like the existing method
 Task 3
 •    Work with Dictionaries and Sets
 •    Work with Tuple return values and error codes
 •    Work with enums
 •    Work with Extensions
 •    Convert Set to Array
 •    Use an extension to add a new method that provides the
        stock of a particular type of medication using the NFC Code
 •    Work with sort() and closures
Task 4
 •    Work with Dictionaries and Sets
 •    Work with Tuple return values and error codes
 •    Work with enums
 •    Work with Extensions
 •    Convert Set to Array
 •    Use an extension to add a new method that sells stock of a
        particular type of medication using the NFC Code
 •    Work with sort() and closures
 •    Delete an Array of elements from a set
 •    Delete a Dictionary entry
 Task 5
 •    Extract tuples to set individual variables
 •    Add a struct method
 •    This is an easy task to set up the next tasks
 •    Tasks 7-9 are a set
 Task 6
 •    Use extension to extend a struct Type
 •    Conform to the Sequence protocol
 •    Work with dates in the past and future
 •    Use struct method to generate a sequence of dates
 •    Handle a sequence that goes up or down in time
 Task 7
 •    Work with tuple parameters
 •    Create an object of the date sequencer Type from Tasks 7 and 8
 •    Create an array of dates returned from the sequencer
  */

//  ========= Tests =========

// To reorder tasks, just change the numbers in the names of the task function stub, the test function
// and the call of the task function in the test function. All else should cleanly adjust.

struct testItem {
    let ndcPackageCode: String
    let name: String
    let volume: Double?
    let concentration: Int?
    let concentrationUnits: String?
    let pillCount: Int?
    let potency: Double?
    let potencyUnits: String?
    let expDays: Int
    let wantResult: Bool // different tests can interpret this differently

    init(med: MedSpec, expDays: Int = 180, wantResult: Bool = true) {
        self.ndcPackageCode = med.ndcPackageCode
        self.name = med.name
        self.volume = med.volume
        self.concentration = med.concentration
        self.concentrationUnits = med.concentrationUnits
        self.pillCount = med.pillCount
        self.potency = med.potency
        self.potencyUnits = med.potencyUnits
        self.expDays = expDays
        self.wantResult = wantResult
    }
}

func testContainer(_ t: testItem) -> MedicationContainer? {
    if let volume = t.volume { // specified volume so want liquid container
        let concentration = t.concentration ?? 1
        let concentrationUnits = t.concentrationUnits ?? "ml"
        return LiquidMedicationContainer(ndcPackageCode: t.ndcPackageCode, name: t.name, expirationDate: futureDate(daysFromNow: t.expDays), volume: volume, concentration: concentration, concentrationUnits: concentrationUnits)
    } else if let pillCount = t.pillCount { // specified pillCount so want tablet container
        let potency = t.potency ?? 1
        let potencyUnits = t.potencyUnits ?? "mg"
        return TabletMedicationContainer(ndcPackageCode: t.ndcPackageCode, name: t.name, expirationDate: futureDate(daysFromNow: t.expDays), pillCount: pillCount, potency: potency, potencyUnits: potencyUnits)
    } else {
        return nil // cannot instantiate the parent class type
    }
}

struct MedSpec {
    let ndcPackageCode: String
    let name: String
    let volume: Double?
    let concentration: Int?
    let concentrationUnits: String?
    let pillCount: Int?
    let potency: Double?
    let potencyUnits: String?
}

func setupGlobals() -> Bool {
    let pseudoMed = MedSpec(ndcPackageCode: "12345-678-90", name: "Med", volume: nil, concentration: nil, concentrationUnits: nil, pillCount: 90, potency: 30, potencyUnits: "MEQ")
    let tylenol = MedSpec(ndcPackageCode: "50580-692-02", name: "TYLENOL", volume: nil, concentration: nil, concentrationUnits: nil, pillCount: 100, potency: 500, potencyUnits: "mg")
    let childrensTylenol = MedSpec(ndcPackageCode: "50580-170-01", name: "Children's TYLENOL", volume: 120, concentration: 160, concentrationUnits: "mg/5ml", pillCount: nil, potency: nil, potencyUnits: nil)
    
    let testContainerSpecifications: [testItem] = [
        testItem(med: pseudoMed, expDays: -90), // One MedicationContainer
        testItem(med: childrensTylenol, expDays: 120), // Two LiquidMedicationContainers
        testItem(med: childrensTylenol, expDays: 90),
        testItem(med: tylenol, expDays: 90), // Three LiquidMedicationContainers
        testItem(med: tylenol, expDays: -180),
        testItem(med: tylenol, expDays: -360),
    ]
    
    // set up some containers
    for spec in testContainerSpecifications {
        guard let aContainer = testContainer(spec) else {
            print("Internal testing error. Test tried to instantiate an object of the parent class type")
            continue
        }
        testContainers.append(aContainer)
    }
    //  We can use this to preload preloaded inStockMedications with
    //  six containers in 3 sets
    loadedSets = [
        [testContainers[0]],
        [testContainers[1], testContainers[2]],
        [testContainers[3], testContainers[4], testContainers[5]]
    ]
    preloadedMedications = [
        testContainers[0].ndcPackageCode : loadedSets[0],
        testContainers[1].ndcPackageCode : loadedSets[1],
        testContainers[3].ndcPackageCode : loadedSets[2]
    ]
    
    return true
}
private func test0(testNum: Int) -> TestResults {

    let (container1, container2): (Any, Any) = task0()
    //  The first item should contain a LiquidMedicationContainer stored in a variable of Type MedicationContainer
    //  The second item should contain a TabletMedicationContainer stored in a variable of Type MedicationContainer
    //  Make them Any so we don't get warning errors about some of the following tests
    //  being always true

    //  make sure container1 is a LiquidMedicationContainer and container2 is a TabletMedicationContainer
    guard container1 is LiquidMedicationContainer else {
        if container1 is TabletMedicationContainer  {
            return fail(testNum, "First returned value should be a LiquidMedicationContainer, but it is a TabletMedicationContainer")
        } else {
            return fail(testNum, "First returned value should be a LiquidMedicationContainer, but it is a generic MedicationContainer")
        }
    }
    guard container2 is TabletMedicationContainer else {
        if container2 is LiquidMedicationContainer {
            return fail(testNum, "Second returned value should be a TabletMedicationContainer, but it is a LiquidMedicationContainer")
        } else {
            return fail(testNum, "Second returned value should be a TabletMedicationContainer, but it is a generic MedicationContainer")
        }
    }

    // Make sure the testContainers are set up
    guard testContainers.count == 6 else {
        return fail(testNum, "Internal testing error. testContainers.count should be 6, but it is \(testContainers.count)")
    }

    // Test the functionality of addContainer() and count()
    // Add one container and check the count
     guard aStockTracker.addContainer(testContainers[0]) else {
        return fail(testNum, "addContainer() returned false when adding first MedicationContainer object")
    }
    guard aStockTracker.count == 1 else {
        return fail(testNum, "Expected aStockTracker.count to be 1 after adding first MedicationContainer object, but it was \(aStockTracker.count)")
    }
    
    // Try to add the same container and check the count
    guard !aStockTracker.addContainer(testContainers[0]) else {
        return fail(testNum, "addContainer() returned true when trying to add the same  MedicationContainer a second time")
    }
    guard aStockTracker.count == 1 else {
        return fail(testNum, "After trying to add the same MedicationContainer object twice, expected aStockTracker.count to be 1, but it was \(aStockTracker.count)")
    }

    // Add two Liquid containers and check the count
    guard aStockTracker.addContainer(testContainers[1]) else {
        return fail(testNum, "addContainer() returned false when adding second MedicationContainer object (which was actually a LiquidMedicationContainer")
    }
    guard aStockTracker.addContainer(testContainers[2]) else {
        return fail(testNum, "addContainer() returned false when adding third MedicationContainer object (which was actually a LiquidMedicationContainer")
    }
    guard aStockTracker.count == 3 else {
        return fail(testNum, "Expected aStockTracker.count to be 3 after adding three MedicationContainer objects, but it was \(aStockTracker.count)")
    }

    // Try to add the same liquid container and check the count
    guard !aStockTracker.addContainer(testContainers[1]) else {
        return fail(testNum, "addContainer() returned true when trying to add the same  LiquidMedicationContainer a second time")
    }
    guard aStockTracker.count == 3 else {
        return fail(testNum, "After adding 3, then trying to add the same LiquidMedicationContainer object again, expected aStockTracker.count to still be 3, but it was \(aStockTracker.count)")
    }

    // Add three tablet containers and check the count
    guard aStockTracker.addContainer(testContainers[3]) else {
        return fail(testNum, "addContainer() returned false when adding fourth MedicationContainer object (which was actually a TabletMedicationContainer")
    }
    guard aStockTracker.addContainer(testContainers[4]) else {
        return fail(testNum, "addContainer() returned false when adding fifth MedicationContainer object (which was actually a TabletMedicationContainer")
    }
    guard aStockTracker.addContainer(testContainers[5]) else {
        return fail(testNum, "addContainer() returned false when adding sixth MedicationContainer object (which was actually a TabletMedicationContainer")
    }
    guard aStockTracker.count == 6 else {
        return fail(testNum, "Expected aStockTracker.count to be 6 after adding six MedicationContainer objects, but it was \(aStockTracker.count)")
    }
  
    // Try to add the same tablet container and check the count
    guard !aStockTracker.addContainer(testContainers[3]) else {
        return fail(testNum, "addContainer() returned true when trying to add the same  TabletMedicationContainer a second time")
    }
    guard aStockTracker.count == 6 else {
        return fail(testNum, "After adding 6, then trying to add the same LiquidMedicationContainer object again, expected aStockTracker.count to still be 6, but it was \(aStockTracker.count)")
    }

    // Test the functionality of count(of:)
    let code1 = testContainers[0].ndcPackageCode
    guard aStockTracker.count(of: code1) == 1 else {
        return fail(testNum, "Added only one container with ndcPackageCode = \(code1) so calling .count(of: \"\(code1)\") should return 1, but it returned \(aStockTracker.count(of: code1))")
    }
    let code2 = testContainers[1].ndcPackageCode
    guard aStockTracker.count(of: code2) == 2 else {
        return fail(testNum, "Added two containers with ndcPackageCode = \(code2) so calling .count(of: \"\(code2)\") should return 2, but it returned \(aStockTracker.count(of: code2))")
    }
    let code3 = testContainers[3].ndcPackageCode
    guard aStockTracker.count(of: code3) == 3 else {
        return fail(testNum, "Added three containers with ndcPackageCode = \(code3) so calling .count(of: \"\(code3)\") should return 3, but it returned \(aStockTracker.count(of: code3))")
    }
    let code4 = "00000-000-00"
    guard aStockTracker.count(of: code4) == 0 else {
        return fail(testNum, "Added no containers with ndcPackageCode = \(code4) so calling .count(of: \"\(code4)\") should return 0, but it returned \(aStockTracker.count(of: code4))")
    }
   return .testPassed
}

private func describeContainerArray(_ containers: [MedicationContainer]) -> String {
    var returnString = "[\n\t"
    var first = true
    for container in containers {
        if first {
            first = false
        } else {
            returnString += ", \n\t"
        }
        returnString += "\(container)"
    }
    return returnString + "]"
}
private func describeContainerDictionary(_ aDict: [String: Set<MedicationContainer>]) -> String {
    var returnString = "[\n\t"
    var first = true
    for (code, containers) in aDict {
        if first {
            first = false
        } else {
            returnString += ", \n\t"
        }
        returnString += "\(code):\(describeContainerArray(Array(containers)))"
    }
    return returnString + "]"
}
private func compareContainerDictionaries(_ lhs: [String: Set<MedicationContainer>], _ rhs: [String: Set<MedicationContainer>]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (code, containers) in lhs {
        guard rhs[code] == containers else {
            return false
        }
    }
    return true
}
private func test1(testNum: Int) -> TestResults {
    guard let returnValue = task1() else { return .testNotImplemented }
    if returnValue != true {
        return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
    }
 
    // Set it up with some containers
    let testTracker = PharmaceuticalStockTracker()
    testTracker.inStockMedications = preloadedMedications
    // testContainers 0, 4 and 5 are expired with dates -90, -180, -360 respectively
    
    let deletedContainers = testTracker.removeExpired()
    // Make sure they deleted the right containers
    let wantRemoved = [testContainers[5], testContainers[4], testContainers[0]]
    guard deletedContainers == wantRemoved else {
        print("Applied removeExpired() to a PharmaceuticalStockTracker with inStockMedications = \(describeContainerDictionary(preloadedMedications))")
        print("Expected returned array of deleted containers to be \(describeContainerArray(wantRemoved))")
        return fail(testNum, "Actual returned array of deleted containers was \(describeContainerArray(deletedContainers))")
    }
    //Set up what the result should look like
    var wantedRetained = preloadedMedications
    wantedRetained[testContainers[0].ndcPackageCode] = nil // remove dictionary entry for the first container
    wantedRetained[testContainers[3].ndcPackageCode] = Set([testContainers[3]])
    // Make sure they kept the right containers
    guard compareContainerDictionaries(testTracker.inStockMedications, wantedRetained) else {
        print("Applied removeExpired() to a PharmaceuticalStockTracker with inStockMedications = \(describeContainerDictionary(preloadedMedications))")
        print("Expected containers retained in inStockMedications to be \(describeContainerDictionary(wantedRetained))")
        return fail(testNum, "Actual containers retained in inStockMedications are \(describeContainerDictionary(testTracker.inStockMedications))")
    }

    // What happens if there are no expired medications
    let saveStock = testTracker.inStockMedications
    let moreDeleted = testTracker.removeExpired()
    guard moreDeleted.count == 0 else {
        print("Applied removeExpired() to a PharmaceuticalStockTracker with no expired medications =  \(describeContainerDictionary(saveStock))")
        return fail(testNum, "Should have returned an empty array, but instead returned \(describeContainerArray(moreDeleted))")
    }
    guard compareContainerDictionaries(testTracker.inStockMedications, saveStock) else {
        print("Applied removeExpired() to a PharmaceuticalStockTracker with no expired medications =  \(describeContainerDictionary(saveStock))")
       return fail(testNum, "Should not have modified the PharmaceuticalStockTracker, but it was modified to be \(describeContainerDictionary(testTracker.inStockMedications))")
    }

    return .testPassed
}

private func test2(testNum: Int) -> TestResults {
    guard let returnValue = task2() else { return .testNotImplemented }
    if returnValue != true {
        return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
    }

    // Test the added functionality of addContainer()

    // Empty the the tracker
    aStockTracker.inStockMedications = [:]

    // Test the functionality of addContainers()
    guard aStockTracker.addContainer(testContainers[0]) else {
        return fail(testNum, "Expected addContainer() of a valid container to return (true, .success) but it returned false")
    }

    // Empty the the tracker
    aStockTracker.inStockMedications = [:]

    // add a set of 3 good containers
    let goodSet: Set = [testContainers[3], testContainers[4], testContainers[5]]
    var (returnBool, returnMessage) = aStockTracker.addContainers(expectedNdcPackageCode: testContainers[3].ndcPackageCode, containersToAdd: goodSet)
    guard returnBool && returnMessage == .success else {
        return fail(testNum, "Expected add of a valid set of 3 containers to return (true, .success) but it returned (\(returnBool), \(returnMessage))")
    }
    guard aStockTracker.count == 3 else {
        return fail(testNum, "Expected add of a valid set of 3 containers to result in .count == 3, but instead .count == \(aStockTracker.count)")
    }

    // Try with an empty set of containers
    let emptySet: Set<MedicationContainer> = []
    (returnBool, returnMessage) = aStockTracker.addContainers(expectedNdcPackageCode: testContainers[3].ndcPackageCode, containersToAdd: emptySet)
    guard returnBool == false && returnMessage == .emptySetOfContainers else {
        return fail(testNum, "Expected add of an empty Set to return (false, .emptySetOfContainers) but it returned (\(returnBool), \(returnMessage))")
    }
    guard aStockTracker.count == 3 else {
        return fail(testNum, "Expected add of an empty Set to not change .count which was 3, but instead .count == \(aStockTracker.count)")
    }

    // Try with a good set of containers, but a different expectedNdcPackageCode
    (returnBool, returnMessage) = aStockTracker.addContainers(expectedNdcPackageCode: testContainers[1].ndcPackageCode, containersToAdd: goodSet)
    guard returnBool == false && returnMessage == .mixedNDCCodes else {
        return fail(testNum, "Expected add of a set of containers with a non-matching expectedNdcPackageCode to return (false, .mixedNDCCodes) but it returned (\(returnBool), \(returnMessage))")
    }
    guard aStockTracker.count == 3 else {
        return fail(testNum, "Expected add of a set of containers with a non-matching expectedNdcPackageCode to not change .count which was 3, but instead .count == \(aStockTracker.count)")
    }

    // Try with a mixed set of containers
    let mixedSet: Set = [testContainers[3], testContainers[4], testContainers[1]]
    (returnBool, returnMessage) = aStockTracker.addContainers(expectedNdcPackageCode: testContainers[3].ndcPackageCode, containersToAdd: mixedSet)
    guard returnBool == false && returnMessage == .mixedNDCCodes else {
        return fail(testNum, "Expected add of a mixed set of containers to return (false, .mixedNDCCodes) but it returned (\(returnBool), \(returnMessage))")
    }
    guard aStockTracker.count == 3 else {
        return fail(testNum, "Expected add of a mixed set of containers to not change .count which was 3, but instead .count == \(aStockTracker.count)")
    }

    return .testPassed
}

private func test3(testNum: Int) -> TestResults {
    guard let returnValue = task3() else { return .testNotImplemented }
    if returnValue != true {
        return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
    }
    
    // Test the functionality of currentStock(of:)
    
    // Preload aStockTracker with containers
    aStockTracker.inStockMedications = preloadedMedications
        
    // Try a code with no inventory
    var (returnBool2, returnMessage2, returnContainers) = aStockTracker.currentStock(of: "98765-432-10")
    guard returnBool2 == false && returnMessage2 == .noInventory && returnContainers == nil else {
        return fail(testNum, "Expected currentStock(of:) with an NDCCode that has no inventory to return (false, .noInventory, nil) but it returned (\(returnBool2), \(returnMessage2), \(String(describing: returnContainers))")
    }
    
    // Try the first valid set
    (returnBool2, returnMessage2, returnContainers) = aStockTracker.currentStock(of: testContainers[0].ndcPackageCode)
    guard returnBool2, returnMessage2 == .success, let container1 = returnContainers else {
        return fail(testNum, "Expected currentStock(of:) with an NDCCode with current inventory to return (true, .success, containerArray) with with the matching MedicationPackages in containerArray, but it returned (\(returnBool2), \(returnMessage2), \(String(describing: returnContainers))")
    }
    let want1 = loadedSets[0].sorted(by: {$0.expirationDate < $1.expirationDate})
    guard container1 == want1 else {
        return fail(testNum, "Expected currentStock(of:\(testContainers[0].ndcPackageCode)) to return \(want1), but it returned  \(container1)")
    }

    // Try the second valid set
    (returnBool2, returnMessage2, returnContainers) = aStockTracker.currentStock(of: testContainers[1].ndcPackageCode)
    guard returnBool2, returnMessage2 == .success, let container2 = returnContainers else {
        return fail(testNum, "Expected currentStock(of:) with an NDCCode with current inventory to return (true, .success, containerArray) with the matching MedicationPackages in containerArray, but it returned (\(returnBool2), \(returnMessage2), \(String(describing: returnContainers))")
    }
    let want2 = loadedSets[1].sorted(by: {$0.expirationDate < $1.expirationDate})
    guard container2 == want2 else {
        return fail(testNum, "Expected currentStock(of:\(testContainers[0].ndcPackageCode)) to return \(want2), but it returned  \(container2)")
    }
 
    return .testPassed
}

private func test4(testNum: Int) -> TestResults {
    guard let returnValue = task4() else { return .testNotImplemented }
    if returnValue != true {
        return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
    }
    
    // Test the functionality of sellContainers(of:)
    
    // Preload aStockTracker with containers
    aStockTracker.inStockMedications = preloadedMedications

    // Make sure it preloaded correctly
    guard aStockTracker.count == 6 else {
        return fail(testNum, "Expected aStockTracker.count to be 6 after preloading \(aStockTracker.count)")
    }

    // Try a count == 0
    var (returnBool2, returnMessage2, returnContainers) = aStockTracker.sellContainers(count: 0, of: testContainers[0].ndcPackageCode)
    guard returnBool2 == false && returnMessage2 == .invalidCount && returnContainers == nil else {
        return fail(testNum, "Expected sellContainers(count:of:) with count == 0 to return (false, .invalidCount, nil) but it returned (\(returnBool2), \(returnMessage2), \(String(describing: returnContainers))")
    }
    
    // Try a count < 0
    (returnBool2, returnMessage2, returnContainers) = aStockTracker.sellContainers(count: -7, of: testContainers[0].ndcPackageCode)
    guard returnBool2 == false && returnMessage2 == .invalidCount && returnContainers == nil else {
        return fail(testNum, "Expected aStockTracker.sellContainers(count:of:) with count < 0 to return (false, .invalidCount, nil) but it returned (\(returnBool2), \(returnMessage2), \(String(describing: returnContainers))")
    }
    
    // Try a code with no inventory
    (returnBool2, returnMessage2, returnContainers) = aStockTracker.sellContainers(count: 1, of: "98765-432-10")
    guard returnBool2 == false && returnMessage2 == .noInventory && returnContainers == nil else {
        return fail(testNum, "Expected sellContainers(of:) with an NDCCode that has no inventory to return (false, .noInventory, nil) but it returned (\(returnBool2), \(returnMessage2), \(String(describing: returnContainers))")
    }
    
    // Try a code with not enough inventory
    (returnBool2, returnMessage2, returnContainers) = aStockTracker.sellContainers(count: 2, of: testContainers[0].ndcPackageCode)
    guard returnBool2 == false && returnMessage2 == .notEnoughInventory && returnContainers == nil else {
        return fail(testNum, "Expected sellContainers(count:of:) with count higher than current inventory to return (false, .notEnoughInventory, nil) but it returned (\(returnBool2), \(returnMessage2), \(String(describing: returnContainers))")
    }
    
    // Try selling first valid set
    (returnBool2, returnMessage2, returnContainers) = aStockTracker.sellContainers(count: 1, of: testContainers[0].ndcPackageCode)
    guard returnBool2, returnMessage2 == .success, let container1 = returnContainers else {
        return fail(testNum, "Expected sellContainers(count 1, of:\(testContainers[0].ndcPackageCode) to return (true, .success, containerArray) with the matching MedicationPackages in containerArray, but it returned (\(returnBool2), \(returnMessage2), \(String(describing: returnContainers))")
    }
    let want1 = loadedSets[0].sorted(by: {$0.expirationDate < $1.expirationDate})
    guard container1 == want1 else {
        return fail(testNum, "Expected sellContainers(count: 1, of:\(testContainers[0].ndcPackageCode)) to return \(want1), but it returned  \(container1)")
    }
    
    // Make sure the side effects are correct
    guard aStockTracker.count == 5 else {
        return fail(testNum, "Expected aStockTracker.count to be 5 after selling 1 of 6 , but it was \(aStockTracker.count)")
    }
    guard aStockTracker.inStockMedications[testContainers[0].ndcPackageCode] == nil else {
        return fail(testNum, "After selling all of \(testContainers[0].ndcPackageCode), that Dictionary key should have been removed from aStockTracker.inStockMedications")
    }
    
    // Try selling one of two in the second valid set
    (returnBool2, returnMessage2, returnContainers) = aStockTracker.sellContainers(count: 1, of: testContainers[1].ndcPackageCode)
    guard returnBool2, returnMessage2 == .success, let container1 = returnContainers else {
        return fail(testNum, "Expected sellContainers(count 1, of:\(testContainers[1].ndcPackageCode) to return (true, .success, containerArray) with the matching MedicationPackages in containerArray, but it returned (\(returnBool2), \(returnMessage2), \(String(describing: returnContainers))")
    }
    var want2 = loadedSets[1].sorted(by: {$0.expirationDate < $1.expirationDate})
    want2.removeLast()
    guard container1 == want2 else {
        return fail(testNum, "Expected sellContainers(count: 1, of:\(testContainers[1].ndcPackageCode)) to return \(want2), but it returned  \(container1)")
    }
    
    // Make sure the side effects are correct
    guard aStockTracker.count == 4 else {
        return fail(testNum, "Expected aStockTracker.count to be 4 after selling 2 of 6 , but it was \(aStockTracker.count)")
    }
    
    // Try selling all 3 of the third valid set
    (returnBool2, returnMessage2, returnContainers) = aStockTracker.sellContainers(count: 3, of: testContainers[3].ndcPackageCode)
    guard returnBool2, returnMessage2 == .success, let container1 = returnContainers else {
        return fail(testNum, "Expected sellContainers(count 3, of:\(testContainers[3].ndcPackageCode) to return (true, .success, containerArray) with the matching MedicationPackages in containerArray, but it returned (\(returnBool2), \(returnMessage2), \(String(describing: returnContainers))")
    }
    let want3 = loadedSets[2].sorted(by: {$0.expirationDate < $1.expirationDate})
    guard container1 == want3 else {
        return fail(testNum, "Expected sellContainers(3, of:\(testContainers[3].ndcPackageCode)) to return \(want3), but it returned  \(container1)")
    }
    
    // Make sure the side effects are correct
    guard aStockTracker.count == 1 else {
        return fail(testNum, "Expected aStockTracker.count to be 1 after selling 5 of 6 , but it was \(aStockTracker.count)")
    }
    guard aStockTracker.inStockMedications[testContainers[3].ndcPackageCode] == nil else {
        return fail(testNum, "After selling all of \(testContainers[3].ndcPackageCode), that Dictionary key should have been removed from aStockTracker.inStockMedications")
    }

    return .testPassed
}

protocol DateSequencerProtocol {
    var currentDaysOut: Int { get set }
    var lastDaysOut: Int  { get set }
    
    mutating func setDates(daysTuple: (Int, Int))
}
private func test5(testNum: Int) -> TestResults {
    guard let returnValue = task5() else { return .testNotImplemented }
    if returnValue != true {
        return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
    }

    // Make sure DateSequencer conforms to DateSequencerProtocol
    // Use "Any" to avoid warning message
    let testProtocol: Any = DateSequencer()
    guard var testSequencer = testProtocol as? DateSequencerProtocol else {
        return fail(testNum, "DateSequencer needs to conform to DateSequencerProtocol")
    }
    
    // Do 5 random tests of setDates()
    for _ in 0..<5 {
        let aTuple = (Int.random(in: -10...10), Int.random(in: -10...10))
        testSequencer.setDates(daysTuple: aTuple)
        guard testSequencer.currentDaysOut == aTuple.0 else {
            return fail(testNum, "After call of .setDates(\(aTuple)) expected currentDaysOut to be \(aTuple.0) but it was \(testSequencer.currentDaysOut)")
        }
        guard testSequencer.lastDaysOut == aTuple.1 else {
            return fail(testNum, "After call of .setDates(\(aTuple)) expected lastDaysOut to be \(aTuple.1) but it was \(testSequencer.lastDaysOut)")
        }
    }

    return .testPassed
}

protocol DateSequencerProtocol2: DateSequencerProtocol {

    mutating func setDates(daysTuple: (Int, Int))
    
    mutating func next() -> Date?
}
private func test6(testNum: Int) -> TestResults {
    
    guard let returnValue = task6() else { return .testNotImplemented }
    if returnValue != true {
        return fail(testNum, "Expected task\(testNum) to return nil or true, but it returned \(returnValue)")
    }

    // Make sure DateSequencer conforms to DateSequencerProtocol2
    // Use "Any" to avoid warning message
    let testProtocol: Any = DateSequencer()
    guard var testSequencer = testProtocol as? DateSequencerProtocol2 else {
        return fail(testNum, "DateSequencer extension needs to conform to DateSequencerProtocol2")
    }
    // Also make sure DateSequencer conforms to Sequence protocol and IteratorProtocol
    // Note the use of "any" (not "Any") which lets us test membership in a generic protocol
#if swift(>=5.7)
   guard testProtocol is any Sequence else {
        return fail(testNum, "DateSequencer extension needs to conform to the Sequence protocol")
    }
    guard testProtocol is any IteratorProtocol else {
        return fail(testNum, "DateSequencer extension needs to conform to the Sequence protocol")
    }
#endif

    // Do 5 random tests of DateSequencer()
    for _ in 0..<5 {
        let aTuple = (Int.random(in: -10...10), Int.random(in: -10...10))
        testSequencer.setDates(daysTuple: aTuple)
        // We do not use testSequencer as a Sequence in a for loop since
        // that is the next task for the user
        // Set up an array of the offsets of dates that should be returned
        var testArray = [Int]()
        if aTuple.0 < aTuple.1 {
            testArray = Array(aTuple.0..<aTuple.1)
        } else if aTuple.0 > aTuple.1 {
            // Swift does not do decreasing ranges so built it forward then reverse it
            testArray = Array(aTuple.1 + 1...aTuple.0)
            testArray.reverse()
        } else {
            testArray = []
        }
        for testIndex in 0..<testArray.count {
            // we do not just use "for aDays in testArray" because we
            // need testIndex for the error messages
            let aDays = testArray[testIndex]
            let expectedDate = dateToString(futureDate(daysFromNow: aDays))
            guard let nextDate = testSequencer.next() else {
                return fail(testNum, "After calling .setDates(\(aTuple)) calls to .next() should produce \(testArray.count) dates, but it returned nil on call number \(testIndex + 1)")
            }
            let returnedDate = dateToString(nextDate)
            guard returnedDate == expectedDate else {
                return fail(testNum, "After calling .setDates(\(aTuple)), expected call number \(testIndex + 1) to return \(expectedDate), but it returned \(returnedDate) \n testArray")
            }
        }
        if let aDate = testSequencer.next() {
            return fail(testNum, "After calling .setDates(\(aTuple)), expected call number \(testArray.count + 1) to return nil but it returned \(dateToString(aDate)) \n testArray")
        }
    }

    return .testPassed
}

private func test7(testNum: Int) -> TestResults {
 
    // Do 5 random tests of DateSequencer()
    for _ in 0..<5 {
        let aTuple = (Int.random(in: -10...10), Int.random(in: -10...10))
        guard let returnArray = task7(aTuple) else {
            return .testNotImplemented
        }
        // Print the results to make sure the students can see the results
        var printString = "For Task \(testNum), DateSequencer with \(aTuple) generated:\n\t["
        var isFirst = true
        for aDate in returnArray {
            if isFirst { isFirst = false }
            else { printString += ", " }
            printString += dateToString(aDate)
        }
        print(printString + "]")
       // Set up an array of the expected days in the future or past
        var daysArray = [Int]()
        if aTuple.0 < aTuple.1 {
            daysArray = Array(aTuple.0..<aTuple.1)
        } else if aTuple.0 > aTuple.1 {
            // Swift does not do decreasing ranges so built it forward then reverse it
            daysArray = Array(aTuple.1 + 1...aTuple.0)
            daysArray.reverse()
        } else {
            daysArray = []
        }
        // Set up an array with the expected dates using the expected days in the future
        var datesArray = [Date]()
        for aDays in daysArray {
            datesArray.append(futureDate(daysFromNow: aDays))
        }

        // Compare size of returned value to size of expected value
        guard returnArray.count == datesArray.count else {
            return fail(testNum, "Called task\(testNum)(\(aTuple)) and expected an Array of size \(datesArray.count) but it returned an Array of size \(returnArray.count)")
        }

        // compare each element in the returned array to the wanted array
        for dateIndex in 0..<datesArray.count {
            // we do not just use "for aDate in dateArray" because we
            // need testIndex for the error messages
            let expectedDate = dateToString(datesArray[dateIndex])
            let returnedDate = dateToString(returnArray[dateIndex])
            guard returnedDate == expectedDate else {
                return fail(testNum, "Called task\(testNum)(\(aTuple)) and expected returnValue[\(dateIndex)] to be \(expectedDate) but it was \(returnedDate)")
            }
        }
        print(">>> That is the correct result!")
    }
    
    return .testPassed
}

//  We use this to generate some sample PharmaceuticalStockTrackers
//  to help testing Task9
func generateTracker(_ containerCount: Int) -> PharmaceuticalStockTracker {
    // Preload it with six items
    let myStockTracker = PharmaceuticalStockTracker()
    aStockTracker.inStockMedications = preloadedMedications
    myStockTracker.inStockMedications = aStockTracker.inStockMedications

    // containerCount == 6 keeps all 6 preloaded MedicationContainers. The other values
    // keep only the Dictionary entry that matches that count of MedicationContainers.
    if containerCount == 6 || (containerCount >= 1 && containerCount <= 3) {
        // Now remove the objects that are not part of this count
        // If count is not 1 nor 6, remove the one container set
        if containerCount != 1 && containerCount != 6 {
            myStockTracker.inStockMedications[testContainers[0].ndcPackageCode] = nil
        }
        // If count is not 2 nor 6, remove the two container set
        if containerCount != 2 && containerCount != 6 {
            myStockTracker.inStockMedications[testContainers[1].ndcPackageCode] = nil
        }
         // If count is not 3 nor 6, remove the three container set
        if containerCount != 3 && containerCount != 6 {
            myStockTracker.inStockMedications[testContainers[3].ndcPackageCode] = nil
        }
    }
    return myStockTracker
}
//  Replace the content of any phrase like Set(...) with Set(count)
//  where count is the number of characters inside the ()
//  We use this to validate the results without needing to worry about the order of
//  the elements of the set since the order is undefined and may not be the same
//  every time.
func simplifySets(_ aString: String) -> String {
    var returnValue = ""
    var last4chars = ""
    var setCount = 0
    for char in aString {
        if setCount > 0 {
            if char == ")" {
                returnValue += String(setCount - 1)
                setCount = 0
            } else {
                setCount += 1
                continue
            }
        }
        returnValue.append(char)
        last4chars.append(char)
        while last4chars.count > 4 { last4chars.removeFirst() }
        if last4chars == "Set(" {
            setCount = 1
        }
    }
    return returnValue
}
//  Replace the content of any phrase like [...:...] with Dictionary[count]
//  where count is the number of characters inside the [].
//  We use this to validate the results without needing to worry about the order of
//  the elements of the Dictionary since the order is undefined and may not be the same
//  every time.
func simplifyDictionaries(_ aString: String) -> String {
    var returnValue = ""
    var sinceLastOpenBracket = 0
    var dictCount = 0
    for char in aString {
        if dictCount > 0 {
            if char == "]" {
                returnValue += "Dictionary[\(dictCount - 1)"
                dictCount = 0
            } else {
                dictCount += 1
                continue
            }
        }
        returnValue.append(char)
        if char == "[" {
            sinceLastOpenBracket = 0
        } else {
            sinceLastOpenBracket += 1
        }
        if char == ":" {
            dictCount = 1
            // back up to last "["
            for _ in 0..<sinceLastOpenBracket {
                returnValue.removeLast()
                dictCount += 1
            }
        }
    }
    return returnValue
}
//  When we compare what was printed, we need to allow for Set and Dictionary
//  contents to be printed in any order
func compareAdjustSetsAndDictionaries(_ lhs: String, _ rhs: String) -> Bool {

    return simplifyDictionaries(simplifySets(lhs)) == simplifyDictionaries(simplifySets(rhs))
}
//  This is used to compare the sets of containers inside a PharmaceuticalStockTracker.
//  If we did not do this, the text we would need to compare would be very long and the results
//  would be hard for the students to parse through to find their errors.
//  Instead this returns the ndcPackageCode and the count of MedicationContainers with that code.
func summarizeSetsOfMedicationContainers(_ arrayOfSets: [Set<MedicationContainer>]) -> String {
    if arrayOfSets.isEmpty { return "Empty Array of Sets" }
    var returnValue = "["
    for aSet in arrayOfSets {
        guard let code = aSet.first?.ndcPackageCode else {
            returnValue += "Empty Set of MedicationContainers, "
            continue
        }
        if aSet.count == 1 {
            returnValue += "Set of 1 MedicationContainer with ndcPackageCode: \(code), "
        } else {
            returnValue += "Set of \(aSet.count) MedicationContainers with ndcPackageCode: \(code), "
        }
    }
    // take off the last ", "
    returnValue.removeLast()
    returnValue.removeLast()
    return returnValue + "]"
}

//  ========= Start of main body of code =========

//  The 4 lines with the testContainers, loadedSets and preloadedMedications
//  global variable and the call to setupGlobals are the only lines that differ
//  from week 2 in the first part of this file up to the line with "Concepts taught
//  or reinforced in each task".
var testContainers: [MedicationContainer] = []
var badCodeContainers: [MedicationContainer] = []
var loadedSets: [Set<MedicationContainer>] = []
var preloadedMedications: [String: Set<MedicationContainer>] = [:]
guard setupGlobals() else {
    exit(1)
}

for testNum in 0 ..< tests.count {
    setupReadLineAndPrint(testNum: testNum)
    taskResults[testNum] = tests[testNum](testNum)
}

print()
print("===== Task Status =====")
printResults(message: "Tasks Passed.", message2: "Passing", result: .testPassed)
printResults(message: "Tasks Failed.", message2: "Failing", result: .testFailed)
printResults(message: "Tasks Not Implemented.", message2: "Not Implemented", result: .testNotImplemented)
print()

//  ========= End of main body of code =========
