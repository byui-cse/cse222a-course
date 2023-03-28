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
//      the specific type of medication container.
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
//  Use the extension below to implement functionality as a method that
//  cleans up any expired medication from a PharmaceuticalStockTracker.
//  It should remove any expired containers from the
//  PharmaceuticalStockTracker and return an array of any containers
//  that were removed. The array of expired containers should be sorted
//  with the oldest expiration dates first. You can use sorted(). And let's
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
//  implement addContainers().
//
//  Hint: Remember to deal with both the case where there are currently no
//  containers matching the ndcPackageCode and the case where there are
//  already some containers matching the ndcPackageCode.
//
//  When you have completed and tested the code for addContainers(),
//  change task2() to return true rather than nil

enum AddMessage: String {
    case success
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

func task2() -> Bool? {
    return nil
}

//  Task 3
//  Implement the method currentStock(of:) below. This accepts as its parameter an
//  ndcPackageCode. It returns a tuple with a Bool, an enum of Type StockMessage
//  and an optional array of MedicationContainers.
//  Check if there are any containers of that type and if there are, return them in an
//  array. Since we should use up medications with the oldest expiration date first,
//  sort the array by expiration date before returning it so the older expiration
//  dates come first.
//
//  When you have completed and tested the code for currentStock(of:),
//  change task3() to return true rather than nil

enum StockMessage: String {
    case success
    case noInventory
}
extension PharmaceuticalStockTracker {
    func currentStock(of ndcPackageCode: String) -> (Bool, StockMessage, [MedicationContainer]?) {
        var returnValue: [MedicationContainer]? = nil
        // Your code goes here
        
        return (true, .success, returnValue)
    }
}
func task3() -> Bool? {
    return nil
}

//  Task 4
//  Fill out the method sellContainers(count:of) below. This accepts as parameters a
//  count of containers to sell, and an ndcPackageCode.
//  It returns a Bool, a SellMessage and an optional array of MedicationContainers.
//  This should find out if there is any inventory of the ndcPackageCode. If so,
//  confirm that there is enough inventory to fill the request.
//  If not, return a tuple of (false, .notEnoughInventory, nil). If there
//  is enough of inventory of the requested ndcPackageCode, be sure to sell those
//  with the earliest dates first. Return a sorted array of the containers sold.
//  If the sale results in the Set being emptied out, remove that dictionary entry.
//
//  When you have completed and tested the code for sellContainers(),
//  change task4() to return true rather than nil

enum SellMessage: String {
    case success
    case invalidCount // count must be >0
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
func task4() -> Bool? {
    return nil
}

//  Task 5
//  Add a mutating method called setDates to the DateSequencer struct below
//  with a parameter called daysTuple. The parameter should be a tuple of Type
//  (Int, Int). The method should use the parameter to set the values (in order)
//  of the two predefined properties: currentDaysOut and lastDaysOut. The purpose
//  of this task is to set things up for the following tasks.
//
//  After you make the change, apply the additional protocol DateSequencerProtocol
//  change task5() to return true rather than nil to will let the tests run.
//
struct DateSequencer  {
    
    var currentDaysOut = 0
    var lastDaysOut = 10
    
    // your code goes here
}
func task5() -> Bool? {
    return nil
}
//  Task 6
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
//  protocol DateSequencerProtocol2 to the extension and change task6() to
//  return true rather than nil.
//

extension DateSequencer  {
    // add your code here
}
func task6() -> Bool? {
    return nil
}

//  Task 7
//  Lets demonstrate how having the DateSequencer object conform to
//  Sequence really adds value. In task8() below, create a DateSequencer
//  object. Call setDates() on your DateSequencer using the parameters passed
//  into task8(). Create an empty array of type [Date]. Then write a for-in
//  loop that loops on your DateSequencer and appends each value produced by
//  the for statement to your array of Dates. The result will be that for-in
//  uses your struct to help you create an array of dates that matches the
//  parameters.
//
//  When you are done with your code, change task7() to return the array produced
//  instead of returning nil.
//
func task7(_ aTuple: (Int, Int)) -> [Date]? {
    return nil
}
