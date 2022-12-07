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
//  Week 4 Tasks
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
//  This week the project will not compile without errors until you complete task 0.
//  Below are the classes from last week except we changed some things, mostly
//  to matcthe new UML diagram:
//
//      1) PharmaceuticalStockTracker is now a class
//
//      2) MedicationContainer has a new property ndcPackageCode that identifies
//      the specific type of medication container (more about that later)
//
//      3) "inStockMedications" changed from an Array of MedicationContainers to
//      a Dictionary where the key is a String (actually an ndcPackageCode) and
//      the value is a Set of MedicationContainers. Each Dictionary entry in
//      inStockMedications will contain the Set of MedicationContainers that
//      have that ndcPackageCode.
//
//      4) Added two new computed properties "description" and "count" and
//      made PharmaceuticalStockTracker conform to the CustomStringConvertible
//      to activate the description property when needed.
//
//      5) Changed the parameter to count(of:) from "name" to "ndcPackageCode".
//
//  Your Task 0 assignment is to get the file to compile by doing the following:
//
//      1) Implement the computed property "count" that should return a
//      count of all MedicationContainers with any ndcPackageCode stored
//      in inStockMedications.
//
//      2) Change count(of:) to correctly count how many containers of a
//      specific ndcPackageCode are stored in inStockMedications.
//
//      3) Change addContainer() to work correctly for the new data model
//      using the ndcPackageCode inside the MedicationContainer parameter
//      as the key. Be sure to address both the case where one or more
//      MedicationContainers with the same ndcPackageCode have already been
//      added.
//
//      4) As explained in the reading, Elements of a set must conform to
//      the Hashable protocol. Mark the MedicationContainer class as
//      conforming to Hashable. Then make it actually conform. Note that
//      we already did some of the work to conform last week by makint it
//      conform to Equatable, a required parent of Hashable.
//      Hint: The combine() approach works even if you are only "combining"
//      one property,
//
//  After you correctly complete this task, the project should compile and
//  task0() should be shown as passing.

class PharmaceuticalStockTracker: CustomStringConvertible {

    var inStockMedications: [String: Set<MedicationContainer>] = [:]

    //  The default description when printing an object of this class is
    //  "Week4Completed.PharmaceuticalStockTracker". To help with debugging
    //  we provide a more informative description. Note that the new
    //  description is only active for printing if we also mark the
    //  PharmaceuticalStockTracker Type as conforming to CustomStringConvertible.
    //  You should do not need to edit this method, but it requires the new
    //  computed property "count" that you need to implement.
    var description: String {
        return "StockTracker holding \(self.count) MedicationContainers"
    }
// EDITOR keep the #if false section and remove the other section for tasks.swift
#if false
    //  Implement this computed property
    var count: Int { get
        {
        }
    }
    //  Correct this method
    func count(of name: String) -> Int {
        return inStockMedications.reduce(0,
            { if $1.name == name { return $0+1 } else { return $0 }})
    }
    //  Correct this method
    func addContainer(_ container: MedicationContainer) -> Bool {
        for aContainer in inStockMedications {
            if aContainer.id == container.id { return false }
        }
        inStockMedications.append(container)
            return true
        }
#else
// EDITOR This is the completed version
    //  Implement this computed property
    var count: Int { get
        {
            var returnValue = 0;
            for medsArray in inStockMedications.values {
                returnValue += medsArray.count
            }
            return returnValue
        }
    }
    //  Correct this method
    func count(of ndcPackageCode: String) -> Int {
        return inStockMedications[ndcPackageCode]?.count ?? 0
    }
    //  Correct this method
    func addContainer(_ container: MedicationContainer) -> Bool {
        // EDITOR keep the #if false section and remove the other section for tasks.swift
        let aCode: String = container.ndcPackageCode
        if let inStockArray = inStockMedications[aCode] {
            // if it already has an array for that ndcPackageCode, check to
            // make sure that the array does not already include this object
            if inStockArray.contains(container) { return false }
            inStockMedications[aCode]?.insert(container)
        } else {
            inStockMedications[aCode] = [container]
        }
        return true
    }
#endif
}
// EDITOR remove Hashable from the next line for tasks.swift
class MedicationContainer: Hashable, Equatable, Comparable, CustomStringConvertible {
    let ndcPackageCode: String
    let id = UUID().uuidString
    let name: String
    let expirationDate: Date
    var isExpired: Bool  { get { return Date() >= expirationDate } }
    
    fileprivate init(ndcPackageCode: String, name: String, expirationDate: Date) {
        self.ndcPackageCode = ndcPackageCode
        self.name = name
        self.expirationDate = expirationDate
    }
    var description: String {
        if let liquidContainer = self as? LiquidMedicationContainer {
            return "Liquid Medication Container with id: \(self.id), ndcPackageCode: \(self.ndcPackageCode), name:  \(self.name), expirationDate: \(dateToString(self.expirationDate)), volume: \(liquidContainer.volume), concentration: \(liquidContainer.concentration), concentrationUnits: \(liquidContainer.concentrationUnits)"
        } else if let tabletContainer = self as? TabletMedicationContainer {
            return "Tablet Medication Container with id: \(self.id), ndcPackageCode: \(self.ndcPackageCode), name:  \(self.name), expirationDate: \(dateToString(self.expirationDate)), pillCount: \(tabletContainer.pillCount), potency: \(tabletContainer.potency), potencyUnits: \(tabletContainer.potencyUnits)"
        } else {
            return "Generic Medication Container with id: \(self.id), ndcPackageCode: \(self.ndcPackageCode), name:  \(self.name), expirationDate: \(dateToString(self.expirationDate)) Note: This object should not exist"
        }
    }
    // conformance to the Equatable protocol which is a parent of Comparable and Hashable
    static func == (lhs: MedicationContainer, rhs: MedicationContainer) -> Bool {
        return lhs.id == rhs.id
    }
    // conformance to the Comparable protocol
    static func < (lhs: MedicationContainer, rhs: MedicationContainer) -> Bool {
        // replace the following with your code for a real comparitor operator
        // EDITOR replace the following line with "return false"
        return lhs.expirationDate < rhs.expirationDate
    }
    // EDITOR remove the following class method for tasks.swift
    // conformance to the Hashable protocol
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
class LiquidMedicationContainer: MedicationContainer {
    let volume: Double
    let concentration: Int
    let concentrationUnits: String
    
    init(ndcPackageCode: String, name: String, expirationDate: Date, volume: Double, concentration: Int, concentrationUnits: String) {
        self.volume = volume
        self.concentration = concentration
        self.concentrationUnits = concentrationUnits
        super .init(ndcPackageCode: ndcPackageCode, name: name, expirationDate: expirationDate)
    }
}
class TabletMedicationContainer: MedicationContainer {
    let pillCount: Int
    let potency: Double
    let potencyUnits: String
    
    init(ndcPackageCode: String, name: String, expirationDate: Date, pillCount: Int, potency: Double, potencyUnits: String) {
        self.pillCount = pillCount
        self.potency = potency
        self.potencyUnits = potencyUnits
        super .init(ndcPackageCode: ndcPackageCode, name: name, expirationDate: expirationDate)
    }
}

//  Do not edit the following date utilities that you are welcome to use.
//  You can edit the line with "ddMMMyyyy" to try different date formats
func daysToSeconds(_ numDays: Int) -> Double {
    let msPerDay: Double = 60 * 60 * 24
    return Double(numDays) * msPerDay
}
func futureDate(daysFromNow: Int) -> Date {
    Date(timeIntervalSinceNow: daysToSeconds(daysFromNow))
}

func dateToString(_ aDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "ddMMMyyyy"
//    dateFormatter.dateFormat = "MM/dd/yyyy" // sample of alternate format
    return dateFormatter.string(from: aDate)
}

//  aStockTracker is a global variable used by several tasks and the test code.
//  Do not edit aStockTracker, nor any code in task0(). You will edit code in all
//  other tasks, but task0() is already set up to make sure you create the correct
//  class and struct types above.
var aStockTracker = PharmaceuticalStockTracker()

func task0() -> (MedicationContainer, MedicationContainer) {
    // Print some sample dates

    let aCode: String = "12345-123-12"
    // initiailize a test variable of both classes
    let aLiquidContainer = LiquidMedicationContainer(ndcPackageCode: aCode, name: "med1", expirationDate: futureDate(daysFromNow: 120),
        volume: 4.5, concentration: 2, concentrationUnits: "ml")
    let aTabletContainer = TabletMedicationContainer(ndcPackageCode: aCode, name: "med2", expirationDate: futureDate(daysFromNow: 90),
        pillCount: 90, potency: 2.3, potencyUnits: "mg")
   return (aLiquidContainer, aTabletContainer)
}

//  Task 1
//  The ndcPackageCode that tells what type of medication is in a container
//  follows the code pattern in the NDC database:
//      https://www.accessdata.fda.gov/scripts/cder/ndc/dsp_searchresult.cfm
//  Using regular expression pattern matching, add code to the isFormattedAsNDCCode()
//  function to return true if and only if the code is in a valid pattern for those
//  codes: [5 digits]-[3 digits]-[2 digits]. When testing your code you may use
//  real codes from the database along with real information, or you may make them up.
//
//  When you have completed and tested the code for isFormattedAsNDCCode(), change the
//  constant in first line of task1() to true to indicate that it is ready to be tested.

func isFormattedAsNDCCode(code: String) -> Bool {
    // Replace the following line with your code
    // EDITOR replace the following line with "return false" for tasks.swift
    return code.range(of: #"^\d{5}[-]\d{3}[-]\d{2}$"#, options: .regularExpression) != nil
}
func task1() -> Bool? {
    let readyToTest = true // change to true when ready to test task1
    guard readyToTest else { return nil }
    
    // Please ignore the "will never be executed" warning
    return true
}

//  Task 2
//  Edit addContainer() to call isFormattedAsNDCCode to validate that the ndcPackageCode
//  in the container to be added has a valid NDCCode format. If not, do not add the
//  container and return false.
//
//  Now fill out the method addContainers() below. This accepts as parameters of
//  an expectedNdcPackageCode and a collection of containers to be added to the
//  Stock Tracker. Since this system is supposed to be dealing with medications
//  there are extra layers of checking. All of the containers to add in a call
//  to addContainers() should have the same ndcPackageCode and that code should
//  match the expectedNdcPackageCode. The function returns a tuple with a Bool and an
//  enum of a type specified. Your code should return each of the enum values if it is
//  performing all needed tests including isFormattedAsNDCCode to verify the code format.
//
//  When you have completed and tested the codefor addContainers(), change the constant
//  in first line of task2() to true to indicate that it is ready to be tested.

enum AddMessage: String {
    case success
    case poorlyFormattedNDCCode
    case emptySetOfContainers
    case mixedNDCCodes
    case otherAddFailure // You may not need this one in your code
}
extension PharmaceuticalStockTracker {
    func addContainers(expectedNdcPackageCode: String, containersToAdd: Set<MedicationContainer>) -> (Bool, AddMessage) {
        // Your code goes here

        // The following code is used to validate the test code will be deleted for tasks.swift.
        guard !containersToAdd.isEmpty else {
            return (false, .emptySetOfContainers)
        }
        guard isFormattedAsNDCCode(code: expectedNdcPackageCode) else {
            return (false, .poorlyFormattedNDCCode)
        }
        for container in containersToAdd {
            guard container.ndcPackageCode == expectedNdcPackageCode else {
                return (false, .mixedNDCCodes)
            }
        }
        // We hope the students write a more effecient way to do this, but for testing
        // purposes this is adequate
        for container in containersToAdd {
            guard addContainer(container) else {
                return (false, .otherAddFailure)
            }
        }
        // End of test validation code to delete for tasks.swift.
        
        return (true, .success)
    }
}

func task2() -> Bool? {
    let readyToTest = true // change to true when ready to test task2
    guard readyToTest else { return nil }
    
    // Please ignore the "will never be executed" warning
    return true
}

//  Task 3
//  Fill out the method currentStock(of:) below. This accepts as its parameter an
//   ndcPackageCode. It returns a tuple with a Bool, an enum of a type specifiedanected
//  and an optional array of MedicationContainers. Validate the ndcPackageCode format,
//  check if there are any containers of that type and if there are, return them in an
//  array. Since we should use up medications with the oldest expiration date first,
//  sort the array by expiration date before returning it so the older expiration
//  dates come first.
//
//  When you have completed and tested the code for currentStock(of:), change the constant
//  in first line of task3() to true to indicate that it is ready to be tested.

enum StockMessage: String {
    case success
    case poorlyFormattedNDCCode
    case noInventory
}
extension PharmaceuticalStockTracker {
    func currentStock(of ndcPackageCode: String) -> (Bool, StockMessage, [MedicationContainer]?) {
        var returnValue: [MedicationContainer]? = nil
        // Your code goes here

        // The following code is used to validate the test code will be deleted for tasks.swift.
        guard isFormattedAsNDCCode(code: ndcPackageCode) else {
            return (false, .poorlyFormattedNDCCode, nil)
        }
        guard let containerSet =  inStockMedications[ndcPackageCode] else {
            return (false, .noInventory, nil)
        }
        returnValue = Array(containerSet)
        returnValue?.sort(by:<)
        // End of test validation code to delete for tasks.swift.
        
        return (true, .success, returnValue)
    }
}
func task3() -> Bool? {
    let readyToTest = true // change to true when ready to test task3
    guard readyToTest else { return nil }

    // Please ignore the "will never be executed" warning
    return true
}

//  Task 4
//  Fill out the method sellContainers(count:of) below. This accepts as parameters a
//  count of containers to sell, and an ndcPackageCode.
//  It returns a Bool, a SellMessage and an optional array of MedicationContainers.
//  Like usual, this should validate the format of the ndcPackageCode, then find out
//  if there is any inventory of the ndcPackageCode. If so, confirm that there is
//  enough. If not return a tuple of false, an error and nil. If there is enough of
//  the correct ndcPackageCode return a sorted array of those with the earliest
//  expirationDate first in the array. And be sure to sell those with the earliest
//  dates first. Be sure to subtract anything sold from the Set associated with that
//  NDCCode in inStockMedications. And if the sale results in the Set being empty,
//  you should remove that NDCCode from being a key in the inStockMedications Dictionary.
//
//  When you have completed and tested the code for sellContainers(), change the constant
//  in first line of task4() to true to indicate that it is ready to be tested.

enum SellMessage: String {
    case success
    case invalidCount // count must be >0
    case poorlyFormattedNDCCode
    case noInventory
    case notEnoughInventory
}
extension PharmaceuticalStockTracker {
    func sellContainers(count: Int, of ndcPackageCode: String) -> (Bool, SellMessage, [MedicationContainer]?) {
        var returnValue: [MedicationContainer]? = nil
        // Your code goes here

        // The following code is used to validate the test code will be deleted for tasks.swift.
        guard isFormattedAsNDCCode(code: ndcPackageCode) else {
            return (false, .poorlyFormattedNDCCode, nil)
        }
        // The following code is used to validate the test code will be deleted for tasks.swift.
        guard count > 0 else {
            return (false, .invalidCount, nil)
        }
        guard let containerSet =  inStockMedications[ndcPackageCode] else {
            return (false, .noInventory, nil)
        }
        guard containerSet.count >= count else {
            return (false, .notEnoughInventory, nil)
        }
        
        var trimmedValues = Array(containerSet)
        trimmedValues.sort(by:<)
        trimmedValues = Array(trimmedValues[0...count - 1])
        inStockMedications[ndcPackageCode]?.subtract(trimmedValues)
        if inStockMedications[ndcPackageCode]?.count == 0 {
            // if we emptied a the array, then deleted the dictionary entry
            inStockMedications[ndcPackageCode] = nil
        }
        
        returnValue = trimmedValues
        // End of test validation code to delete for tasks.swift.
        
        return (true, .success, returnValue)
    }
}
func task4() -> Bool? {
    let readyToTest = true // change to true when ready to test task7
    guard readyToTest else { return nil }

    // Please ignore the "will never be executed" warning
    return true
}

//  Task 5
//  Add a mutating method called setDates to DateSequencer with one parameter called
//  daysTuple that is a tuple of two Ints. Use them to set the values (in order)
//  of the two properties.
//
//  Then apply the additional protocol DateSequencerProtocol that will let the tests
//  conform that your solution has the correct functrions implemented
//
//  Then change task5() to return true rather than nil
struct DateSequencer: DateSequencerProtocol  {
    
    var sequenceCurrent = 0
    var sequenceEnd = 10
    
    /* NOTE TO EDITOR: Delete the following method when creating tasks.swift
     so the struct will just have the two private properties above. */
    mutating func setDates(daysTuple: (Int, Int)) {
        (sequenceCurrent, sequenceEnd) = daysTuple
    }
}
func task5() -> Bool? {
//    return nil

    // When creating tasks.swift, change this back to "return nil"
    return true
}

//  Task 6
//  Edit the extension below to make the DateSequencer conform to the Sequence protocol.
//  Use the approach that has it also conforms to the IteratorProtocol.
//  Every time it generates a sequence element it should return a date optional that
//  is sequenceCurrent days in the future and also increment sequenceCurrent towards
//  sequenceEnd. That means if sequenceCurrent < sequenceEnd add one to sequenceCurrent
//  and if sequenceCurrent > sequenceEnd subtract one from sequenceCurrent. If it
//  is asked to generate another sequence element when sequenceCurrent == sequenceEnd
//  return nil. Note that the date returned should be based on the value of sequenceCurrent
//  prior to its being incremented. You are welcome to call daysToMs() or futureDate()
//  or borrow code from them.
//
//  Then apply the additional protocol DateSequencerProtocol2 to the extension that
//  will let the tests conform that your solution has the correct functrion implemented
//
//  Then change task6() to return true rather than nil
//
/* NOTE TO EDITOR: use the following version of the extension that is empty and
 without the list of protocols when creating tasks.swift
 */
// extension DateSequencer {
// }

extension DateSequencer: Sequence, IteratorProtocol, DateSequencerProtocol2  {
    mutating func next() -> Date? {
        if sequenceCurrent < sequenceEnd {
            sequenceCurrent += 1
            return Date(timeIntervalSinceNow: daysToSeconds(sequenceCurrent-1))
        } else if sequenceCurrent > sequenceEnd {
            sequenceCurrent -= 1
            return Date(timeIntervalSinceNow: daysToSeconds(sequenceCurrent+1))
        } else {
            return nil
        }
    }
}
func task6() -> Bool? {
//    return nil

    // When creating tasks.swift, change this back to "return nil"
    return true
}

//  Task 7
//  Add an empty variable of Type [Date] called returnValue.
//  Add code to task7() that creates a local object of type DateSequencer. Use the
//  input paramater with .setDates() to set the properties inside that DateSequencer
//  object. Add "for let aDate in yourObject" to create a loop where
//  "yourObject" is whatever you called your DateSequencer object.
//  Inside that loop, append each date returned by the DateSequencer
//  to the returnValue array. Then return the returnValue array instead of nil.
func task7(_ aTuple: (Int, Int)) -> [Date]? {
    //    return nil

    // The following code used to validate the test code will be deleted for tasks.swift.
    var returnValue: [Date] = []
    var seqObj = DateSequencer()
    seqObj.setDates(daysTuple: aTuple)
    for aDate in seqObj { returnValue.append(aDate) }
    return returnValue
}

//  Task 8
//  Suppose we want to sort the objects in a Collection by size (using the "count"
//  property in those objects). If we have many different configurations of Collections,
//  we would need to write and test many different sort functions. Look in the body of
//  task9() below to see just a few samples of the different configurations that would
//  each need their own function. That would include any object that has a count property
//  including objects from our custom PharmaceuticalStockTracker class. Fortunately,
//  we can write a single generic method to cover all of those cases.
//
//  First, to identify which object Types can use this method, we have defined a protocol
//  that just confirms the Type has a count property. In many cases, including our
//  PharmaceuticalStockTracker class the count proerty is computed, but it does not
//  matter for our purposes whether it is or is not computed. Here is the protocol:

protocol Countable {
    var count: Int { get }
}

//  Swift does not implicitly recognize compliance with a protocol. We need to explicitly
//  state the compliance. One way to do that is in an extension of an existing type. So
//  let's mark some common Types as Countable.

extension Array: Countable {}
extension Set: Countable {}
extension Dictionary: Countable {}
extension String: Countable {}
extension PharmaceuticalStockTracker: Countable {}

//  Now we can define a generic method that applies to any type of
//  Collection where the Elements are of a Countable Type.
//  Elements of the type are Countable. Element is a predefined
//  Associated Type within all Collection Types. Uncomment the
//  two lines defining an empty sortedBySize() function and
//  add functionaity to return an Array with the sorted Elemements
//  of the top level Collection. Sort them according the size
//  or count of each Element, increasing ro decreasing accoring to
//  the parameter to the call. You can call the built-in
//  sort function which is available for all Collections.

extension Collection where Element: Countable {
    func sortedBySize(increasing: Bool = true) -> Array<Element> {
        // replace "return []" with your code to implement the sort
        // Note to EDITOR: to prepare tasks.swift delete the following 6 lines
        // and replace them with "return []"
        return self.sorted(by: { lhs, rhs in
            if increasing {
                return lhs.count < rhs.count
            } else {
                return lhs.count > rhs.count }
        })
    }
}

//  When you have implemented sortedBySize() change the constant in the
// first line of task8() to true.

func task8() -> Bool? {
    // change to true when ready to test task9
    // DO NOT change any other lines in task9()
    let readyToTest = true
    guard readyToTest else { return nil }

    // Please ignore the "will never be executed" warning
    let arrayOfStrings = ["One", "Three", "Five"]
    testPrint("arrayOfStrings.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(arrayOfStrings.sortedBySize())")
    testPrint("<  \(arrayOfStrings.sortedBySize(increasing: false))")
 
    let arrayOfArrays = [[1],[1,2],[1,2,3]]
    testPrint("arrayOfArrays.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(arrayOfArrays.sortedBySize())")
    testPrint("<  \(arrayOfArrays.sortedBySize(increasing: false))")
 
    let arrayOfSets: Array<Set> = [[1],[1,2],[1,2,3]]
    testPrint("arrayOfSets.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(arrayOfSets.sortedBySize())")
    testPrint("<  \(arrayOfSets.sortedBySize(increasing: false))")

    let arrayOfDictionaries = [[1:1],[1:2,2:2],[1:3,2:3,3:3]]
    testPrint("arrayOfDictionaries.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(arrayOfDictionaries.sortedBySize())")
    testPrint("<  \(arrayOfDictionaries.sortedBySize(increasing: false))")

    let setOfStrings: Set = ["One", "Three", "Five"]
    testPrint("setOfStrings.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(setOfStrings.sortedBySize())")
    testPrint("<  \(setOfStrings.sortedBySize(increasing: false))")
 
    let setOfArrays: Set = [[1],[1,2],[1,2,3]]
    testPrint("setOfArrays.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(setOfArrays.sortedBySize())")
    testPrint("<  \(setOfArrays.sortedBySize(increasing: false))")

    let setOfSets: Set<Set> = [[1],[1,2],[1,2,3]]
    testPrint("setOfSets.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(setOfSets.sortedBySize())")
    testPrint("<  \(setOfSets.sortedBySize(increasing: false))")

    let setOfDictionaries: Set<Dictionary> = [[1:1],[1:2,2:2],[1:3,2:3,3:3]]
    testPrint("setOfDictionaries.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(setOfDictionaries.sortedBySize())")
    testPrint("<  \(setOfDictionaries.sortedBySize(increasing: false))")

    let setOfStringKeyDictionaries: Set<Dictionary> = [["one":1],["one":1,"two":2],["one":1,"two":2,"three":3]]
    testPrint("setOfStringKeyDictionaries.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(setOfStringKeyDictionaries.sortedBySize())")
    testPrint("<  \(setOfStringKeyDictionaries.sortedBySize(increasing: false))")

    let dictionaryValuesOfStrings = [1: "One", 3: "Three", 5: "Five"]
    testPrint("dictionaryValuesOfStrings.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(dictionaryValuesOfStrings.values.sortedBySize())")
    testPrint("<  \(dictionaryValuesOfStrings.values.sortedBySize(increasing: false))")

    let dictionaryValuesOfArrays = [1:[1], 2:[1,2], 3:[1,2,3]]
    testPrint("dictionaryValuesOfArrays.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(dictionaryValuesOfArrays.values.sortedBySize())")
    testPrint("<  \(dictionaryValuesOfArrays.values.sortedBySize(increasing: false))")

    let dictionaryValuesOfSets: Dictionary<Int, Set> = [1:[1], 2:[1,2], 3:[1,2,3]]
    testPrint("dictionaryValuesOfSets.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(dictionaryValuesOfSets.values.sortedBySize())")
    testPrint("<  \(dictionaryValuesOfSets.values.sortedBySize(increasing: false))")

    let dictionaryKeysOfStrings = ["One" : 1, "Three": 3, "Five": 5]
    testPrint("dictionaryKeysOfStrings.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(dictionaryKeysOfStrings.keys.sortedBySize())")
    testPrint("<  \(dictionaryKeysOfStrings.keys.sortedBySize(increasing: false))")

    //  generateTracker(_ countainerCount: Int) is implemented in
    //  main.swift. It generates a sample PharmaceuticalStockTracker
    //  with countainerCount MedicationContainers in it. It is only
    //  implemented for containerCounts in 1...3 and 6.
    
    //  This first example is sorting PharmaceuticalStockTrackers to see which location or
    //  warehouse represented by a PharmaceuticalStockTrackers has the most or least inventory.
    let arrayOfPharmaceuticalStockTrackers: [PharmaceuticalStockTracker] = [generateTracker(1), generateTracker(2), generateTracker(3)]
    testPrint("arrayOfPharmaceuticalStockTrackers.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(arrayOfPharmaceuticalStockTrackers.sortedBySize())")
    testPrint("<  \(arrayOfPharmaceuticalStockTrackers.sortedBySize(increasing: false))")

    //  Now let's get a sorted array of all of the inventory in dictionaries inside a
    //  PharmaceuticalStockTracker. We use summarizeSetsOfMedicationContainers to
    //  provide a summary of the Sets. Otherwise this would print the detailed contents
    //  of each MedicationContainer in each Set in the Dictionary.
    let aStockTracker = generateTracker(6)
    testPrint("aStockTracker.inStockMedications.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(summarizeSetsOfMedicationContainers(aStockTracker.inStockMedications.values.sortedBySize()))")
    testPrint("<  \(summarizeSetsOfMedicationContainers(aStockTracker.inStockMedications.values.sortedBySize(increasing: false)))")
    
    return true
}
