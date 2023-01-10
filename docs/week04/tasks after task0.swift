//
//  Tasks.swift
//  Week 4 Tasks
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
//  Due to the tests we need to perform, some lines in main.swift may generate
//  warning errors. If you get an unexplained warning error from main.swift, please
//  check if there is a comment near that line saying to ignore warning errors.
//
import Foundation

//  Task 0 Assignment
//  This week the project will not compile without errors until you complete task 0.
//  We have included the classes from last week as we left them except for a few changes,
//  mostly to match the new UML diagram:
//
//      1) PharmaceuticalStockTracker is now a class
//
//      2) MedicationContainer has a new property ndcPackageCode that identifies
//      the specific type of medication container (more about that later in task 2).
//
//      3) Changed "inStockMedications" from an Array of MedicationContainers to
//      a Dictionary. The key is a String (actually an ndcPackageCode) and
//      the value is a Set of MedicationContainers each of which have an
//      ndcPackageCode attribute that matches the key.
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
//      total count of all MedicationContainers with any ndcPackageCode
//      stored in inStockMedications.
//
//      2) Change count(of:) to correctly count how many containers of a
//      specific ndcPackageCode are stored in inStockMedications.
//
//      3) Change addContainer() to work correctly for the new data model
//      using the ndcPackageCode inside the MedicationContainer parameter
//      as the key. Be sure to address both the case where we are adding
//      this ndcPackageCode for the first time and the case where one or
//      more MedicationContainers with the same ndcPackageCode have
//      already been added.
//
//      4) As explained in the reading, Elements of a set must conform to
//      the Hashable protocol. Mark the MedicationContainer class as
//      conforming to Hashable. Then make it actually conform to Hashable.
//      Note that since Equatable is a parent of Hashable, we must also
//      conform to Equatable. Fortunately, we already did that last week,
//      so part of the work to conform is already done.
//      Hint: The combine() approach to conforming to Hashable works even
//      if you are only "combining" one property,
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
    //  You should not need to edit this method. However, for it to work
    //  correctly it requires the new computed property "count" that you
    //  were asked to implement.
    var description: String {
        return "StockTracker holding \(self.count) MedicationContainers"
    }
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
}
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
        // replace the following with your code for a real comparator operator
        // EDITOR replace the following line with "return false"
        return lhs.expirationDate < rhs.expirationDate
    }
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
//  However, you can edit the "ddMMMyyyy" to try different date formats.
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
//  other tasks, but task0() is already set up to make sure you created the correct
//  class and struct types above.
var aStockTracker = PharmaceuticalStockTracker()

func task0() -> (MedicationContainer, MedicationContainer) {
    // Print some sample dates

    let aCode: String = "12345-123-12"
    // initialize a test variable of both classes
    let aLiquidContainer = LiquidMedicationContainer(ndcPackageCode: aCode, name: "med1", expirationDate: futureDate(daysFromNow: 120),
        volume: 4.5, concentration: 2, concentrationUnits: "ml")
    let aTabletContainer = TabletMedicationContainer(ndcPackageCode: aCode, name: "med2", expirationDate: futureDate(daysFromNow: 90),
        pillCount: 90, potency: 2.3, potencyUnits: "mg")
   return (aLiquidContainer, aTabletContainer)
}

//  Task 1
//  In the last assignment last week you created an operator that
//  cleaned any expired medication from a PharmaceuticalStockTracker.
//  Use the extension below to re-implement that functionality (as a
//  method this time) for the new model. It should remove any expired
//  containers from the PharmaceuticalStockTracker and return an array
//  of any containers that were removed. The array of expired containers
//  should be sorted with the oldest expiration dates first. And let's
//  keep things tidy: if you remove all the containers in a Dictionary
//  entry, go ahead and remove the Dictionary entry also.
//
//  When you have completed and tested the code for removeExpired(),
//  change task1() to return true rather than nil
//
extension PharmaceuticalStockTracker {
    func removeExpired() -> [MedicationContainer] {
        // Replace the following line with your code
        return []
    }
}
func task1() -> Bool? {
    return nil
}

//  Task 2
//  The ndcPackageCode that tells what medication is in a container
//  follows the code pattern in the NDC database:
//      https://www.accessdata.fda.gov/scripts/cder/ndc/dsp_searchresult.cfm
//  Using regular expression pattern matching, add code to the isFormattedAsNDCCode()
//  function to return true if and only if the code is in a valid pattern for those
//  codes: [5 digits]-[3 digits]-[2 digits]. When testing your code you may use
//  real codes from the database along with real information, or you may make them up.
//  The only thing that matters for this exercise is matching the pattern, not
//  whether it is an actual code from the web site. Your code should test for a
//  match on the entire property and not report a match if only a substring of
//  the property matches.
//
//  When you have completed and tested the code for isFormattedAsNDCCode(),
//  change task2() to return true rather than nil

func isFormattedAsNDCCode(code: String) -> Bool {
    // Replace the following line with your code
    return false
}
func task2() -> Bool? {
    return nil
}

//  Task 3
//  Edit addContainer() to call isFormattedAsNDCCode() to validate
//  that the ndcPackageCode in the container to be added has a valid
//  NDCCode format. If not, do not add the container and return false.
//
//  Now fill out the method addContainers() below. This accepts as parameters
//  an expectedNdcPackageCode and a Set of MedicationContainers to be added to
//  the Stock Tracker. Since this system is supposed to be dealing with medications
//  there are extra layers of checking. All of the containers in the Set passed
//  to addContainers() should have the same ndcPackageCode and that code should
//  match the expectedNdcPackageCode parameter.
//
//  The function returns a tuple with a Bool and an enum of Type AddMessage.
//  As you complete the method, parts of your code should return each of the
//  values in AddMessage except possibly .otherAddFailure. The others all
//  represent error (or success) conditions that you should detect as you
//  implement addContainers(). One  error you should detect would be found
//  by calling the function isFormattedAsNDCCode() to verify the format
//  of the NdcPackageCode used.
//
//  Hint: Remember to deal with both the case where there are currently no
//  containers matching the ndcPackageCode and the case where there are
//  already some containers matching the ndcPackageCode.
//
//  When you have completed and tested the code for addContainers(),
//  change task3() to return true rather than nil

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

func task3() -> Bool? {
    return nil
}

//  Task 4
//  Implement the method currentStock(of:) below. This accepts as its parameter an
//  ndcPackageCode. It returns a tuple with a Bool, an enum of Type StockMessage
//  and an optional array of MedicationContainers. Validate the ndcPackageCode format,
//  check if there are any containers of that type and if there are, return them in an
//  array. Since we should use up medications with the oldest expiration date first,
//  sort the array by expiration date before returning it so the older expiration
//  dates come first.
//
//  When you have completed and tested the code for currentStock(of:),
//  change task4() to return true rather than nil

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
func task4() -> Bool? {
    return nil
}

//  Task 5
//  Fill out the method sellContainers(count:of) below. This accepts as parameters a
//  count of containers to sell, and an ndcPackageCode.
//  It returns a Bool, a SellMessage and an optional array of MedicationContainers.
//  Like usual, this should validate the format of the ndcPackageCode, then find out
//  if there is any inventory of the ndcPackageCode. If so, confirm that there is
//  enough. If not, return a tuple of (false, .notEnoughInventory, nil). If there
//  is enough of inventory of the requested ndcPackageCode, be sure to sell those
//  with the earliest dates first. Return a sorted array of the containers sold.
//  If the sale results in the Set being emptied out, remove that dictionary entry.
//
//  When you have completed and tested the code for sellContainers(),
//  change task5() to return true rather than nil

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
func task5() -> Bool? {
    return nil
}

//  Task 6
//  Add a mutating method called setDates to the DateSequencer struct below
//  with a parameter called daysTuple. The parameter should be a tuple of Type
//  (Int, Int). The method should use the parameter to set the values (in order)
//  of the two predefined properties: currentDaysOut and lastDaysOut. The purpose
//  of this task is to set things up for the following tasks.
//
//  After you make the change, apply the additional protocol DateSequencerProtocol
//  change task6() to return true rather than nil to will let the tests run.
//
struct DateSequencer  {
    
    var currentDaysOut = 0
    var lastDaysOut = 10
    
    // your code goes here
}
func task6() -> Bool? {
    return nil
}

//  Task 7
//  Add to the extension below to make the DateSequencer conform to the Sequence
//  protocol. In conforming to this protocol, you can either have the object create
//  a separate iterator or you can have the object be its own iterator . For this
//  task, use the option where it is its own iterator  so in addition to conform
//  to Sequence, it needs to explicitly conform to IteratorProtocol. You will
//  need to add both of these protocols to the first line of the extension.
//
//  The next() function you implement to conform should return a date optional.
//      If currentDaysOut == lastDaysOut then it should return nil.
//      Otherwise it should return a Date currentDaysOut in the future.
//  Returning nil is how it indicates that the sequence is complete.
//  It should then increment currentDaysOut "towards" lastDaysOut. That is:
//      if currentDaysOut < lastDaysOut add 1 to currentDaysOut
//      if currentDaysOut > lastDaysOut subtract 1 from currentDaysOut.
//  In implementing this, you are welcome to call either or
//  both of daysToMs() and futureDate() or to borrow code from them.
//
//  The result of your code will be objects that generate a sequence of dates.
//  If you call setDates(x, y) then the struct will behave as a sequence of dates
//  starting x days in the future and continuing up or down the calendar until
//  just before it would output y days into the future.
//
//  When you have completed and tested these changes apply the additional
//  protocol DateSequencerProtocol2 to the extension and change task7() to
//  return true rather than nil.
//

extension DateSequencer  {
    // add your code here
}
func task7() -> Bool? {
    return nil
}

//  Task 8
//  Lets demonstrate how having the DateSequencer object conform to
//  Sequence really adds value. In task8() below, create a DateSequencer
//  object. Call setDates() on your DateSequencer using the parameters passed
//  into task8(). Create an empty array of type [Date]. Then write a for-in
//  loop that loops on your DateSequencer and appends each value produced by
//  the for statement to your array of Dates. The result will be that for-in
//  uses your struct to help you create an array of dates that matches the
//  parameters.
//
//  When you are done with your code, change task8() to return the array produced
//  instead of returning nil.
//
func task8(_ aTuple: (Int, Int)) -> [Date]? {
    return nil
}

//  Task 9
//  Now that we have seen how conformance to the simple Sequence protocol unlocked
//  somewhat surprising power, let's experiment with how a simple use of a
//  generic method extension combined with a simple protocol can have far reaching
//  effects on a wide range of different types of collections of objects.
//
//  Suppose we want to sort the objects in a Collection by size (using the "count"
//  property already built into most objects). We could write a special sort method
//  for one particular type of collection such as an Array of Strings. But we could
//  also create a generic method that would work for any collections where the
//  elements inside the collection implement the count property.
//
//  First, to identify which object Types can use this method, we have defined a
//  Protocol that just confirms the Type has a "count" property. In most cases,
//  including our PharmaceuticalStockTracker class, the count property is computed.
//  All our Protocol cares about is that the property exists, not whether it is
//  a stored or computed property. Here where we define the Protocol:

protocol Countable {
    var count: Int { get }
}

//  Swift does not implicitly recognize compliance with a protocol. Even though
//  many Types have a count property and would comply with this property, we
//  must explicitly state that compliance, for example with an extension like
//  we do here for many common Types. Note that we are able to apply this to
//  generic Types. Applying it to Set means it works for any Set no matter
//  what contents it has. Likewise for Array, Dictionary and String. We
//  can also apply it to our PharmaceuticalStockTracker since it has an Int
//  property called count.

extension Array: Countable {}
extension Set: Countable {}
extension Dictionary: Countable {}
extension String: Countable {}
extension PharmaceuticalStockTracker: Countable {}

//  Now we can define a generic method that applies to any
//  Collection where the Elements are of a Countable Type.
//  Element is a predefined placeholder that represents the type
//  of object that is collected in a Collection. We can require in
//  the extension below that it apply to any Collection where
//  Element (representing the Type of objects in the Collection) is
//  Countable.
//
//  Your assignment is to replace "return []" in sortedBySize()
//  below with code that sorts the top level elements of
//  the Collection by size using the "count" property. Sort them
//  increasing or decreasing according to the parameter. You
//  are welcome to call the Built-In sort() Function to help you
//  implement sortedBySize().
//
//  Once you write the method it will automatically apply to any
//  Type that is a child of Collection that has Elements that comply
//  with Countable. Suppose you came across another type of Collection
//  called SpecialCollection. All you need to add is one line:
//      extension SpecialCollection: Countable {}
//  and you can apply sortedBySize() to Collections of that Type as well.
//  In this way, this extension can easily be applied to types that do
//  not even exist yet.
//
//  When you have implemented sortedBySize() comment out the "return nil"
//  line at the start task9. This will allow a test and demonstration of
//  some of the many different combinations types that now can be sorted
//  by size using this single generic method.


extension Collection where Element: Countable {
    func sortedBySize(increasing: Bool = true) -> Array<Element> {
        // replace "return []" with your code to implement the sort
        return []
    }
}

func task9() -> Bool? {
    return nil // comment out this line when you are ready to test Task 9

    // Please ignore a possible "will never be executed" warning
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

    //  generateTracker(_ containerCount: Int) is implemented in
    //  main.swift. It generates a sample PharmaceuticalStockTracker
    //  with containerCount MedicationContainers in it. It is only
    //  implemented for containerCounts in 1, 2, 3 and 6.
    
    //  This first example is sorting PharmaceuticalStockTrackers to see which location or
    //  warehouse represented by a PharmaceuticalStockTrackers have the most or least inventory.
    let arrayOfPharmaceuticalStockTrackers: [PharmaceuticalStockTracker] = [generateTracker(1), generateTracker(2), generateTracker(3)]
    testPrint("arrayOfPharmaceuticalStockTrackers.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(arrayOfPharmaceuticalStockTrackers.sortedBySize())")
    testPrint("<  \(arrayOfPharmaceuticalStockTrackers.sortedBySize(increasing: false))")

    //  Here we use sortedBySize() to produce a sorted array of all of the inventory in
    //  a PharmaceuticalStockTracker, sorted by which ndcPackageCodes have the most or least
    //  inventory associated with them.
    //
    //  Note: to make the results more meaningful we print the results using a function provided
    //  in main.swift called summarizeSetsOfMedicationContainers(). That function prints a summary
    //  of each Dictionary or Set. Otherwise, the following lines would print the full detailed contents
    //  of each MedicationContainer in inventory which would be a lot more detailed content to read
    //  through to validate that the function is working correctly..
    let aStockTracker = generateTracker(6)
    testPrint("aStockTracker.inStockMedications.sortedBySize() increasing, then decreasing:")
    testPrint(">  \(summarizeSetsOfMedicationContainers(aStockTracker.inStockMedications.values.sortedBySize()))")
    testPrint("<  \(summarizeSetsOfMedicationContainers(aStockTracker.inStockMedications.values.sortedBySize(increasing: false)))")
    
    return true
}
