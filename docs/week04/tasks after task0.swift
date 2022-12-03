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
//  Below are the classes from last week (except we changed
//  PharmaceuticalStockTracker to be a class). Please modify
//  them to partially match the UML diagram. There are three changes
//  to be done in task0:
//
//      1) Insert a constant String called ndcPackageCode as the first property of
//          the MedicationContainer type. We will explain it later. You will need to
//          adjust the initializers for all three container types.
//
//      2) Change inStockMedications from an array of MedicationContainers to a
//          dictionary with a String for the key and a value that is an array
//          of MedicationContainers. The string will be the ndcPackageCode of
//          the containers in the value array.
//
//      3) Change the addContainer() method so it works correctly for the new
//          type of inStockMedications. It will need to check if there is already
//          a dictionary entry matching the ndcPackageCode. If yes, make sure the
//          container parameter is not already in the value array associated with
//          that key, then append the container parameter to that array. If there
//          is not a matching dictionary entry, create one the correct key and
//          a value that is an array containing only the container.
//
//  We will not make the final change in the UML to use a Set during Task 0.
//  After you correctly complete this task, the project should compile and
//  task0() should be shown as passing.

class PharmaceuticalStockTracker: CustomStringConvertible, TrackerProtocol {

    var inStockMedications: [String : [MedicationContainer]] = [:]

    func addContainer(_ container: MedicationContainer) -> Bool {
        let aCode: String = container.ndcPackageCode
        if let inStockArray = inStockMedications[aCode] {
            // if it already has an array for that ndcPackageCode, check to
            // make sure that the array does not already include this object
            for aContainer in inStockArray {
                if aContainer.id == container.id { return false }
            }
            inStockMedications[aCode]?.append(container)
        } else {
            inStockMedications[aCode] = [container]
        }
        return true
    }

    // We define count to be the number of of MedicatonContainers inside
    // Arrays or Sets inside Dictionaries.
    // The default description when printing an object of this class is just
    // "Week4Tasks.PharmaceuticalStockTracker" so we provide a more
    // informative description. Note that the new description is only active
    // if we also make PharmaceuticalStockTracker conform to CustomStringConvertible.
    // These two methods are provided to help you get started.
    // You should not need to modify either of these methods.
    var count: Int { get
        {
            var returnValue = 0;
            for medsArray in inStockMedications.values {
                returnValue += medsArray.count
            }
            return returnValue
        }
    }
    var description: String {
        return "StockTracker holding \(self.count) MedicationContainers"
    }

}
class MedicationContainer: ContainerProtocol {
    let ndcPackageCode: String
    let id = UUID().uuidString
    let name: String
    let expirationDate: Date
    var isExpired: Bool  { get { return Date() >= expirationDate } }
    
    init(ndcPackageCode: String, name: String, expirationDate: Date) {
        self.ndcPackageCode = ndcPackageCode
        self.name = name
        self.expirationDate = expirationDate
    }
}
class LiquidMedicationContainer: MedicationContainer, LiquidContainerProtocol {
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
class TabletMedicationContainer: MedicationContainer, TabletContainerProtocol {
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

//  Do not edit the following date utilities that you are selcome to use.
//  You are welcome to edit the line with "ddMMMyyyy" to try different date formats
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

func task0() -> (MedicationContainer, MedicationContainer, MedicationContainer) {
    // Print some sample dates

    let aCode: String = "12345-123-12"
    // initiailize a test variable of each class
    let aContainer = MedicationContainer(ndcPackageCode: aCode, name: "med1", expirationDate: futureDate(daysFromNow: 180))
    let aLiquidContainer = LiquidMedicationContainer(ndcPackageCode: aCode, name: "med2", expirationDate: futureDate(daysFromNow: 120),
        volume: 4.5, concentration: 2, concentrationUnits: "ml")
    let aTabletContainer = TabletMedicationContainer(ndcPackageCode: aCode, name: "med3", expirationDate: futureDate(daysFromNow: 90),
        pillCount: 90, potency: 2.3, potencyUnits: "mg")
   return (aContainer, aLiquidContainer, aTabletContainer)
}

//  Task 1
//  In later tasks, you will need to sort an array of MedicationContainers.
//  They should be sorted by expirationDate. We could explicitly do that comparison
//  every time we do a sort, but if we want to us a simplified sort operation like
//  "anArray.sort(>)" then we need to address the fact that MedicationContainers
//  Do not have a built-in defintion for the "<" or ">" operation. To do that we
//  can make MedicationContainer comply with the Comparable protocol. In the
//  extension below, we have set up functions to specify the "<" and "==" operators
//  fill in the functions (replacing "return false") and then in the first line of
//  the extension after "MedicationContainer" insert ": Equatable, Comparable" to mark
//  it compliant. Note that while "<" or ">" are based on the expirationDate property
//  the "==" operator should be based on the id property since that uniquely identifies
//  a MedicationContainer.
//
//  Below that extension and above task1() we have defined a postfix
//  operator <||> and an infix operator with AdditionPrecedence <-||.
//
//  Create an extension to PharmaceuticalStockTracker. In that extension, define a method
//  for <||> that counts the total number of containers in the tracker. It will be
//  more complicated than the example in the reading since we now have a dictionary with
//  multiple arrays. You are welcome to call the count() computed property to
//  implement it. The <-|| operator should take a PharmaceuticalStockTracker as the left
//  parameter and a MedicationContainer as the right parameter and add the container to
//  the tracker. You are welcome to use the addContainer() function to implement it.
//
//  Then add the TrackerProtocol3 to the extension.
//
//  Finally change "return nil" in task1() to "return ({$0<||>}, {$0<-||$1})".
//  Be sure to copy the return value inside the quotes exaxtly. Returning those two
//  closures allows the test software to know your code is ready to test and allow
//  the test code to access your new operators.
//
// EDITOR remove ": Equatable, Comparable" to produce tasks.swift
extension MedicationContainer {
    
    static func == (lhs: MedicationContainer, rhs: MedicationContainer) -> Bool {
        // replace the following with your code for a real comparitor operator
        return false
    }
    static func < (lhs: MedicationContainer, rhs: MedicationContainer) -> Bool {
        // replace the following with your code for a real comparitor operator
        return false
    }
    
}
postfix operator <||>
infix operator <-||: AdditionPrecedence
//  Put the extension to PharmaceuticalStockTracker here

func task1() -> ((PharmaceuticalStockTracker) -> Int, (PharmaceuticalStockTracker, MedicationContainer) -> Bool)? {
    return nil
}

//  Task 2
//  To get the project to compile, we needed to pretend we conform to the Hashable
//  protocol using the extension below. Please research how to make MedicationContainer
//  actually comply with Hashable. You do not need to compare all fields nor hash
//  all properties since the id property uniquely identifies a MedicationContainer
//  object. So you can just hash and compare on the id property. But you do need to
//  correctly fill in the contents of the hash functions or none of the following
//  tasks will work. We already added the required commpliance with the Equitable
//  protocol in an earlier task
//

//  Then change the constant in first line of task32 to return true rather than
//  nil. This indicates you have completed this task and it is ready to be tested.
//  That will cause task2() to create and return a MedicationContainer object from
//  the task instead of nil.
//
//  Hint:
//  The "hasher.combine" approach to producing a hash function works even if
//  there is only one class property to "combine."
//
extension MedicationContainer: Hashable {

    // conformance to the Hashable protocol
    func hash(into hasher: inout Hasher) {
        // Put your code here to create a real Hasher function
    }
}
func task2() -> MedicationContainer? {
    let readyToTest = false // change to true when ready to test task2
    guard readyToTest else { return nil }
    
    // Please ignore the "will never be executed" warning
    let aCode: String = "12345-123-12"
    let aContainer = MedicationContainer(ndcPackageCode: aCode, name: "med1", expirationDate: futureDate(daysFromNow: 180))
   return aContainer
}

//  Task 3
//  Each time we add a MedicationContainer object to inStockMedications we
//  need to search through all existing containers in that the array for
//  that ndcPackageCode to make sure that it is not already there so we avoid
//  accidentally adding two container objects in in the system's inventory
//  that actually refer to the same object in the "real world."
//  One way to avoid having more than one copy of an object in a Swift
//  collection is to use a Set insrtead of an Array.
//
//  In the Dictionary property called inStockMedications change the type of
//  Dictionary value from an Array, to a Set replacing:
//      [MedicationContainer]
//  with this:
//      Set<MedicationContainer>
//  Elements of a Set and Keys of a Dictionary must conform to the
//  Hashable protocol which we did task 1 so this change to a Set should
//  be allowed.
//
//  Then edit the addContainer() method to realize the benefit that this is
//  a set. You will still need to check if there is a Dictionary entry
//  for that ndcPackageCode so you know whether to add a new entry or
//  add the package to the existing Set. But if the Dictionary entry
//  already exists, you do not need to search through every container
//  to make sure it is not already added. If we tried to add the same
//  object a second time, it would just ignore the action. But since
//  addContainer() returns a Boolean telling us we actually inserted
//  the container, we can use .contains() to see if it was already there.
//
//  Change PharmaceuticalStockTracker from complying with TrackerProtocol to instead
//  comply with TrackerProtocol2.
//
//  Now uncomment the single line in the preloadAStockTracker. We need it for later
//  testing, but it requires inStockMedications to be a Dictionary of Sets. So
//  it would not compile until you completed this task.
//
//  Finally change the constant in first line of task3() to return true rather than
//  nil to indicated you have completed this task and it is ready to be tested.

func preloadAStockTracker() {
//    aStockTracker.inStockMedications = preloadedMedications
}
func task3() -> Bool? {
    let readyToTest = false // change to true when ready to test task3
    guard readyToTest else { return nil }
    
    // Please ignore the "will never be executed" warning
    return true
}

//  Task 4
//  The ndcPackageCode that tells what type of medication is in a container
//  follows the code pattern in the NDC database:
//      https://www.accessdata.fda.gov/scripts/cder/ndc/dsp_searchresult.cfm
//  Using regular expression pattern matching, add code to the isFormattedAsNDCCode()
//  function to return true if and only if the code is in a valid pattern for those
//  codes: [5 digits]-[3 digits]-[2 digits]. When testing your code you may use
//  real codes from the database along with real information, or you may make them up.
//
//  When you have completed and tested the code for isFormattedAsNDCCode(), change the
//  constant in first line of task4() to true to indicate that it is ready to be tested.

func isFormattedAsNDCCode(code: String) -> Bool {
    // Replace the following line with your code
    return false
}
func task4() -> Bool? {
    let readyToTest = false // change to true when ready to test task4
    guard readyToTest else { return nil }
    
    // Please ignore the "will never be executed" warning
    return true
}

//  Task 5
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
//  in first line of task5() to true to indicate that it is ready to be tested.

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
        return (true, .success)
    }
}

func task5() -> Bool? {
    let readyToTest = false // change to true when ready to test task5
    guard readyToTest else { return nil }
    
    // Please ignore the "will never be executed" warning
    return true
}

//  Task6
//  Fill out the method currentStock(of:) below. This accepts as its parameter an
//   ndcPackageCode. It returns a tuple with a Bool, an enum of a type specifiedanected
//  and an optional array of MedicationContainers. Validate the ndcPackageCode format,
//  check if there are any containers of that type and if there are, return them in an
//  array. Since we should use up medications with the oldest expiration date first,
//  sort the array by expiration date before returning it so the older expiration
//  dates come first.
//
//  When you have completed and tested the code for currentStock(of:), change the constant
//  in first line of task6() to true to indicate that it is ready to be tested.

enum StockMessage: String {
    case success
    case poorlyFormattedNDCCode
    case noInventory
}
extension PharmaceuticalStockTracker {
    func currentStock(of ndcPackageCode: String) -> (Bool, StockMessage, [MedicationContainer]?) {
        var returnValue: [MedicationContainer]? = nil
        // Your code goes here
        return (true, .success, returnValue)
    }
}
func task6() -> Bool? {
    let readyToTest = false // change to true when ready to test task6
    guard readyToTest else { return nil }

    // Please ignore the "will never be executed" warning
    return true
}

//  Task 7
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
//  in first line of task7() to true to indicate that it is ready to be tested.

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
        return (true, .success, returnValue)
    }
}
func task7() -> Bool? {
    let readyToTest = false // change to true when ready to test task7
    guard readyToTest else { return nil }

    // Please ignore the "will never be executed" warning
    return true
}

//  Task 8
//  We provided a custom description to use when describing or printing
//  objects of the PharmaceuticalStockTracker Type. But when we print a
//  MecicationContainer, it still just says Week4Tasks.MecicationContainer.
//  Use the empty extension below to fix this. Add the compliance with
//  the CustomStringConvertible protocol using the extension. Add a
//  add a computed property called description of Type String that
//  describes a specific MecicationContainer. Remember that since
//  MedicationContainer is a class with children, the MedicationContainer
//  may actually be a MedicationContainer, a LiquidMedicationContainer
//  or a TabletMedicationContainer. Figure out what it is using "is"
//  or "as?", then return a string with all the relevant data for its type.

//  When you have completed and tested the code, change the constant
//  in first line of task8() to true to indicate that it is ready to be tested.
//  This will cause the test code to print some MecicationContainers to
//  test the new extension.

extension MedicationContainer {
    // put your code here to add a computed description property
}

func task8() -> Bool? {
    let readyToTest = false // change to true when ready to test task8
    guard readyToTest else { return nil }

    return true
}

//  Task 9
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
        return []
    }
}

//  When you have implemented sortedBySize() change the constant in the
// first line of task9() to true.

func task9() -> Bool? {
    // change to true when ready to test task9
    // DO NOT change any other lines in task9()
    let readyToTest = false
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
