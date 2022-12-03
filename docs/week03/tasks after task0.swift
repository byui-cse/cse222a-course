//  Tasks.swift
//  Week 3 Tasks
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

//  Task 0
//  This week the project will not compile without errors until you complete task 0.
//  Please add classes and structs as defined in the UML document in the assignment
//  web page. After you have correctly completed task 0 the project should successsfully
//  compile and acknowledge that task 0 passed.
//
//  Hint: when writing initializers for child classes, list the parent parameters first.
//  That is not a Swift requirement, but allows
//
//  As mentioned in the reading, the parent type MedicationContainer includes generic
//  properties and methods. We also store medications as MedicationContainers alowing
//  both child types in the same array. But it is not meanintful to create an object
//  of type MedicationContainer, only of the child types. We cannot prevent this entirely,
//  but best practice would be to put the keyword fileprivate before the init for
//  MedicationContainer which will at least prevent any code from another file in the
//  project accidentally trying to directly create a MedicationContainer.
//
//  Add the classes and structs here:
struct PharmaceuticalStockTracker: TrackerProtocol, TrackerProtocol2 {
    var inStockMedications: [MedicationContainer] = []

    mutating func addContainer(_ container: MedicationContainer) -> Bool {
        for aContainer in inStockMedications {
            if aContainer.id == container.id { return false }
        }
        inStockMedications.append(container)
        return true
    }
    func count(of name: String) -> Int {
        return inStockMedications.reduce(0,
            { if $1.name == name { return $0+1 } else { return $0 }})
    }
}
class MedicationContainer: ContainerProtocol {
    let id = UUID().uuidString
    let name: String
    let expirationDate: Date
    var isExpired: Bool  { get { return Date() >= expirationDate } }

    fileprivate init(name: String, expirationDate: Date) {
        self.name = name
        self.expirationDate = expirationDate
    }
}
class LiquidMedicationContainer: MedicationContainer, LiquidContainerProtocol {
    let volume: Double
    let concentration: Int
    let concentrationUnits: String
    
    init(name: String, expirationDate: Date, volume: Double, concentration: Int, concentrationUnits: String) {
        self.volume = volume
        self.concentration = concentration
        self.concentrationUnits = concentrationUnits
        super .init(name: name, expirationDate: expirationDate)
    }
}
class TabletMedicationContainer: MedicationContainer, TabletContainerProtocol {
    let pillCount: Int
    let potency: Double
    let potencyUnits: String
    
    init(name: String, expirationDate: Date, pillCount: Int, potency: Double, potencyUnits: String) {
        self.pillCount = pillCount
        self.potency = potency
        self.potencyUnits = potencyUnits
        super .init(name: name, expirationDate: expirationDate)
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
//    dateFormatter.dateFormat = "ddMMMyyyy"
    dateFormatter.dateFormat = "MM/dd/yyyy" // sample of alternate format
    return dateFormatter.string(from: aDate)
}

//  aStockTracker is a global variable used by several tasks and the test code.
//  Do not edit aStockTracker, nor any code in task0(). You will edit code in all the
//  other tasks, but task0() is already set up to make sure you create the correct
//  class and struct types above.
var aStockTracker = PharmaceuticalStockTracker()
func task0() -> (MedicationContainer, MedicationContainer) {
    // Print some sample dates
    print("Yesterday: \(dateToString(futureDate(daysFromNow: -1)))")
    print("Today: \(dateToString(Date()))")
    print("Tomorrow: \(dateToString(futureDate(daysFromNow: 1)))")

    // initiailize a test variable of each class
    let aLiquidContainer = LiquidMedicationContainer(name: "med1", expirationDate: futureDate(daysFromNow: 120),
                                                     volume: 4.5, concentration: 2, concentrationUnits: "ml")
    let aTabletContainer = TabletMedicationContainer(name: "med2", expirationDate: futureDate(daysFromNow: 90),
                                                     pillCount: 90, potency: 2.3, potencyUnits: "mg")
   return (aLiquidContainer, aTabletContainer)
}

//  Task 1
//  Add a computed property to MedicationContainer "isExpired: Bool" that
//  returns true if and only if the container has expired.
//
//  Apply protocols TrackerProtocol, ContainerProtocol, LiquidContainerProtocol, TabletContainerProtocol
//  to the corresponding struct and classes as explained in last week's reading.
//  You do not need to create the protocols. They already exist in main.swift. Just use them.
//
//  Using the code in Task() as an example, create an object of each of the two child class Types
//  and then return then from the task in the tuple instead of nil values.
//  Note that the test code will report this function as not implemented as long as either of the two
//  values returned in the tuple is nil.
func task1() -> (LiquidMedicationContainer?, TabletMedicationContainer?) {
    return (nil, nil)
}

//  Task 2
//  Add a method to PharmaceuticalStockTracker like this:
//      mutating func addContainer(_ container: MedicationContainer) -> Bool
//  Your method should add the container to the inStockMedications
//  Array, but only if that exact container is not already in the array.
//  Return true if we successfully added it to the array. Remember that
//  the MedicationContainer parameter could actually be a
//  LiquidMedicationContainer or a tabletMedicationContainer.
//  Note that having the same name does not mean it is the same MedicationContainer,
//  but if you correctly set up the id field, it will be unique for a MedicationContainer.
//  Struct methods are generally assumed to not modify the struct itself
//  which is why the mutating keyword is needed to indicate  a struct method that
//  modifies the struct itself.
//
//  Add another method to PharmaceuticalStockTracker like this:
//      func count(of name: String) -> Int
//  This will count the number of items in MedicationContainers that have a
//  name that mathes the parameter passed in. Note that it will be called
//  like this:
//      let aCount = aTracker.count(of: "Asprin")
//  but inside your method ou will refer to the parameter as "name".

//  Add TrackerProtocol2 to the PharmaceuticalStockTracker. This will
//  confirm that you have added the correct methods. You do not need
//  to create the protocol. It already exists in main.swift.

//  Then change task2() to return true rather than nil
func task2() -> Bool? {
    return nil
}

//  Task 3
//  A Range cannot step backwards, but sometimes we want to count down.
//  An Array can act like a sequence and be used many places that a Range
//  can be used. If the int1 <= int2 return the matching Range. Otherwise
//  return an Array that has values counting from int1 down to and including
//  int 2.
func task3(_ int1: Int, _ int2: Int) -> Any? {
    return nil
}

//  Task 4
//  task4() is called with two Ints. Call task3() with the parameters received.
//  Return 1 if the value returned from task3() is a ClosedRange<Int>.
//  Return 2 if the value returned from task3() is an Array<Int>.
//  Otherwise return 0 (this case should not happen if task3() is correct)
func task4(_ int1: Int, _ int2: Int) -> Int? {
    return nil
}

//  Task 5
//  This function receives an array that might have Any values in it
//      including nil.
//  Use compactMap to process it as follows:
//      if the value received is an Int, put 1 in the Array
//      if the value received is a Double, put 2 in the Array
//      if the value received is a String, put 3 in the Array
//      otherwise put nil in the array and let compactMap remove it
//  Then return that new array.
//  Note that "is" correctly matches the underlying value of optionals
func task5(_ anyArray: [Any?]) -> [Int]? {
    return nil
}

//  Task 6
//  Tnis function receives the same array as Task5. This time use compactMap to
//  remove the optionals. Map it to an array of Double that has the following values:
//      if the value received is an Int, convert it to a Double and put it in the Array.
//      if the value received is a Double, put it in the Array.
//      if the value received is a String and it can be converted to a Double, put it
//          in the array, if not, put nil in the array so compactMap removes this item.
//          Note that if Double() fails to convert a String it conveniently returns nil.
//      if the value received is nill, return nil so compactMap removes it
//      if it was none of those, return Double.infinity.
//  Then return that new array.
func task6(_ anyArray: [Any?]) -> [Double]? {
    return nil
}

//  Task 7
//  Add a mutating method called setDates to DateSequencer with one parameter called
//  daysTuple that is a tuple of two Ints. Use them to set the values (in order)
//  of the two properties.
//
//  Then apply the additional protocol DateSequencerProtocol that will let the tests
//  conform that your solution has the correct functrions implemented
//
//  Then change task3() to return true rather than nil
struct DateSequencer  {
    
    var sequenceCurrent = 0
    var sequenceEnd = 10
}
func task7() -> Bool? {
    return nil
}

//  Task 8
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
//  Then change task4() to return true rather than nil
//
extension DateSequencer {
}

func task8() -> Bool? {
    return nil
}

//  Task 9
//  Add an empty variable of Type [Date] called returnValue.
//  Add code to task9() that creates a local object of type DateSequencer. Use the
//  input paramater with .setDates() to set the properties inside that DateSequencer
//  object. Add "for let aDate in yourObject" to create a loop where
//  "yourObject" is whatever you called your DateSequencer object.
//  Inside that loop, append each date returned by the DateSequencer
//  to the returnValue array. Then return the returnValue array instead of nil.
func task9(_ aTuple: (Int, Int)) -> [Date]? {
    return nil
}
