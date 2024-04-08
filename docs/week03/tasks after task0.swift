//
//  Tasks.swift
//  Week 3 Tasks
//
//  You need to write code to complete the functions below to complete each task.
//  You can develop and test each function individually.
//  As long as a function returns nil, it is assumed to not be implemented.
//
//  You would usually use the print() function to write to the console and the
//  readline() function to read user input from the console. However, for this class,
//  please instead use testPrint() and testReadline(). Those will behave the same way,
//  but allow the test code to see what you print and what is input from the user.
//
//  Due to the tests we need to perform, lines in main.swift may generate
//  warning errors. If you get an unexplained warning error from main.swift, please
//  check if there is a comment near that line saying to ignore warning errors.
//

import Foundation

//  Task 0
//  This week the project will not compile without errors until you complete task 0.
//  Please add classes and structs as defined in the UML document in the assignment
//  web page. After you have correctly completed task 0 the project should successfully
//  compile and acknowledge that task 0 passed. Pay attention to the types of the
//  properties in the diagram. You will get protocol errors later if you make something
//  an Int that should be a Double or make something a Double that should be an Int.
//
//  Hint: when writing initializers for child classes, list the parent parameters first.
//  That is not a Swift requirement, but allows the test software to call the
//  initializers with parameters in the correct order.
//
//  As mentioned in the reading, the parent Type MedicationContainer includes generic
//  properties and methods. We also store all medications as MedicationContainers allowing
//  both child Types in the same array. But it is not meaningful to create an object
//  of the parent Type MedicationContainer, only of the child Types. We cannot prevent this
//  entirely, but as best practice you should put the keyword fileprivate before the init
//  for MedicationContainer which will at least prevent any code from another file in the
//  project accidentally trying to directly create a MedicationContainer.
//
//  Make sure you reread the section in the reading titled "UUID and Unique Objects".
//  That give you the exact syntax to use to define the id property for the Medication Container
//  along with an explaination why you should use that code exactly. When you later write moblie code
//  using Swift you will often need to have unique identifiers for your objects and this is one way to
//  make that happen. Also, since id has a default value, you do not include it as a parameer in the
//  init() functions.
//
//  Add the classes and structs here:
/* NOTE TO EDITOR: Delete this struct and these classes when creating tasks.swift. */
struct PharmaceuticalStockTracker: TrackerProtocol {
    var inStockMedications: [MedicationContainer] = []

}
class MedicationContainer {
    let id = UUID().uuidString
    let name: String
    let expirationDate: Date

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
/* NOTE TO EDITOR: This is the end of section to delete for tasks.swift. */

//  Do not edit the following date utilities. You are welcome to use them.
//  In particular, you will almost definitely want to use futureDate as a way
//  to generate something of type Date rather than spend your time learning the
//  details of how dates work in Swift at this point. And anytime you are asked
//  to print something of type Date, please use dateToString() to convert the
//  date to a String and print the String. Otherwise the test code may not
//  recognize that you have correctly printed the date.
//
//  If you want to experiment with different date formats, you can edit the line
//  in dateToString() with "MM/dd/yyyy" such as putting in "ddMMMyyyy" instead.

func daysToSeconds(_ numDays: Int) -> Double {
    let msPerDay: Double = 60 * 60 * 24
    return Double(numDays) * msPerDay
}
//  This function takes an Int parameter that specifies a number of days in the future
//  or the past (if you pass a negative integer) or today (if you pass 0). It returns
//  an object of Type Date with the appropriate date value. You can use it to create
//  Dates to put into variables or to compare to other Dates.
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
//  other tasks, but task0() is already set up to make sure you created the correct
//  class and struct Types above.
var aStockTracker = PharmaceuticalStockTracker()
func task0() -> (MedicationContainer, MedicationContainer) {
    // Print some sample dates
    print("Yesterday: \(dateToString(futureDate(daysFromNow: -1)))")
    print("Today: \(dateToString(Date()))")
    print("Tomorrow: \(dateToString(futureDate(daysFromNow: 1)))")

    // initialize a test variable of both child classes
    let aLiquidContainer = LiquidMedicationContainer(name: "med1", expirationDate: futureDate(daysFromNow: 120),
                                                     volume: 4.5, concentration: 2, concentrationUnits: "ml")
    let aTabletContainer = TabletMedicationContainer(name: "med2", expirationDate: futureDate(daysFromNow: 90),
                                                     pillCount: 90, potency: 2.3, potencyUnits: "mg")
   return (aLiquidContainer, aTabletContainer)
}

//  Task 1
//  Tasks 1 and 2 ask you to add functionality to the Types you created in Task 0.
//  For those Tasks, just edit the Type definitions above. Later you will be asked to add
//  functionality using extensions, but for now, just edit the original definitions.
//
//  Add a computed property to MedicationContainer called "isExpired: Bool" that
//  returns true if and only if the container has expired.
//
//  Apply protocols TrackerProtocol, ContainerProtocol, LiquidContainerProtocol, TabletContainerProtocol
//  to the corresponding struct and classes as explained in last week's reading.
//  You do not need to create the protocols. They already exist in main.swift. Just use them.
//  After you add the protocols to the four Types, if the compiler generates errors, you may want to
//  search for the protocols in main.swift and try to figure out what those are looking for that you
//  did differently and need to correct.
//
//  Using the code in Task0() that creates aLiquidContainer and aTabletContainer as an example,
//  create an object of each of the two child class Types and then return them from the task
//  in the tuple instead of nil values. You are welcome to just copy lines 142-146 above and use them
//  to replace the line "return (nil, nil) in task1(). But try to understand what those lines are doing
//  and why they work to create and return a sample of each MedicationContainer child Type.
//
//  Note that the test code will report this function as not implemented as long as either of the two
//  values returned in the tuple is nil. So when you have added the new property, applied the protocols
//  and created the objects, change both returned values to be those containers. That will signal the
//  test code to run the tests.
func task1() -> (LiquidMedicationContainer?, TabletMedicationContainer?) {
    return (nil, nil)
}

//  Task 2
//  Add a method to PharmaceuticalStockTracker like this:
//      mutating func addContainer(_ container: MedicationContainer) -> Bool {
//  Your method should add the container parameter to the inStockMedications
//  Array, but only if that exact container is not already in the array.
//  Return true if we successfully added it to the array. Remember that
//  the MedicationContainer parameter could actually be a
//  LiquidMedicationContainer or a tabletMedicationContainer.
//  Note that having the same name does not mean it is the same MedicationContainer,
//  but if you correctly set up the id field, it will be unique for a MedicationContainer.
//  Struct methods are generally assumed to not modify the struct itself
//  which is why the mutating keyword is needed to indicate it is a struct method that
//  modifies the struct itself.
//
//  Add another method to PharmaceuticalStockTracker like this:
//      func count(of name: String) -> Int
//  This will count the number of items in MedicationContainers that have a
//  name that exactly matches the parameter passed in. Note that it will be called
//  like this:
//      let aCount = aTracker.count(of: "Asprin")
//  but inside your method ou will refer to the parameter as "name".

//  Add TrackerProtocol2 to the PharmaceuticalStockTracker. This will
//  confirm that you have added the correct methods. You do not need
//  to create the protocol. It already exists in main.swift.

//  Then change task2() to return true rather than nil
//
func task2() -> Bool? {
    return nil
}

//  Task 3
//  We are going to step away from MedicationContainers for a moment to
//  work with Types including using "is" to find out the Type of an object.
//  We will also demonstrate how Protocols allow us to have similar built-in
//  behaviors from different Types as long as they comply with a Protocol.
//  For example, in Tasks 3 and 4 we use the fact that Arrays and Ranges
//  both comply with a Protocol that allows us to sequence through values
//  so we can use an Array to simulate a Range.

//  A Range counts up from the first value to or almost to the last value.
//  A Closed Range counts to the last value. An Open Range stops just before.
//  However, a range cannot step backwards. Sometimes we want to count down
//  and the default Range Types cannot do that.
//  An Array can act like a sequence and be used many places that a Range
//  can be used. Let's create a function that generates a either a Range
//  or, if a Range cannot be used, generates an Array that provides the
//  same ability to sequence through values. In generateRange() below,
//  if the int1 <= int2, return the matching Range. Otherwise return an
//  Array that has values counting from int1 down to and including int2.
//  That array can be used most places that a range could be used.
//
//  Note: most tasks ask you to edit a function called taskN(), but we gave
//  the function for Task 3 a more meaningful name since you will call it
//  later. So instead of editing Task3() you are asked to edit generateRange().func generateRange(_ int1: Int, _ int2: Int) -> Any? {
    return nil
}

//  Task 4
//  task4() is called with two Int parameters. Inside task4() call
//  generateRange() with the two parameters.
//  Return 1 if the value returned from generateRange() is Type ClosedRange<Int>.
//  Return 2 if the value returned from generateRange() is Type Array<Int>.
//  Otherwise return 0 (this case should not happen if generateRange() is
//  correct). Hint: you can use "is" or "as?" to check the Type of an object.
func task4(_ int1: Int, _ int2: Int) -> Int? {
    return nil
}

//  Task 5
//  This function receives an array that might have Any values in it
//      including nil. Each element of a [Any?] Array can contain
//      any value. You can think of Any as a wrapper that allows objects
//      of different types to be in the same Array. But each element
//      still remembers its original Type.
//  The "is" operator returns true if the left operand has the underlying
//      native type specified as the right operand. If the Array were [Any]
//      it could have Any value except nil. But since the Type is [Any?] it
//      can also contain nil values. Conveniently, the Swift compiler
//      implementers made "is" able to reach through the Optional wrapper
//      to tell us if the native type of the element inside both the
//      Optional wrapper and the Any Wrapper has that native Type.
//  compactMap() works like map except it operates on an Array of Optional
//      values. It expects its closure to return an Optional value each time
//      the closure is called and then compactMap() will strip out all of the
//      nil values and unpack any non-nil values so the resulting Array does
//      not contain any nil values and is not Optional. For example, if you
//      had an Array of Type [Double?] then using compactMap{$0} would return
//      an Array type [Double] with all non-nil values unpacked and nil values
//      removed.
//
//  Use compactMap() to process the passed Array as follows:
//      if the value received is an Int, put 1 in the Array
//      if the value received is a Double, put 2 in the Array
//      if the value received is a String, put 3 in the Array
//      otherwise put nil in the array and let compactMap remove it
//  Then return that new array.
func task5(_ anyArray: [Any?]) -> [Int]? {
    return nil
}

//  Task 6
//  This task exercises Optional and Any to really stretch your understanding.
//  If it is confusing at first, don’t be discouraged. Ask for help if you need
//  it. This is one of those concepts that can require anyone, no matter how
//  capable, to get several explainations before it clicks and makes sense.
//  But once it does, it is very powerful.
//
//  task6()  receives the same array as Task5(). We will again use compactMap() to
//  remove the optionals. The closure should map each input to a Double?
//  as follows:
//      if the value received is an Int, convert it to a Double and put it in the Array.
//      if the value received is a Double, put it in the Array.
//      if the value received is a String
//          if it can be converted to a Double, put it in the array
//          if not, put nil in the array so compactMap removes this item.
//          Note that if Double() fails to convert a String it conveniently returns nil
//          so you can just return the result of trying to convert the String to a Double.
//      if the value received is nil, put nil in the Array so compactMap removes it
//      if it was none of those, put Double.infinity in the Array.
//  Then return the output from compactMap().
//
//  Hints:
//  Processing the Any? value passed to the closure requires multiple steps. You need to
//  us "is" to figure out what Type it is like in Task 5. But then you need to use "as?" to
//  extract an object of the Type that is hidden in the Any?. Only after you do that and
//  unpack it from being an Optional (since as? always produced an Optional) can you use
//  Double() if needed to try to convert it to Double. If you try to use Double() on an Any?
//  or any Optional, it will generate errors because it does not know what to do with those
//  Types. You need to arrange to pass it a Type that it understands.
//
//  Some students almost get this working, but never handle to the final step so their closure
//  never returns the build-in value Double.infinity for any of the inputs.
func task6(_ anyArray: [Any?]) -> [Double]? {
    return nil
}

//  Task 7
//  When we print a MecicationContainer, it just outputs
//  "Week3Tasks.MedicationContainer". Among other things, such a generic printout
//  makes it harder to print things to help us track down errors.
//
//  Assignment: use the empty extension below to fix this by adding compliance
//  with the CustomStringConvertible protocol. That will allow more detailed
//  information when printing. In the extension, add a String computed property
//  called "description" that returns a string with details about all the
//  non-computed properties in the MedicationContainer. When you put the
//  expirationDate field into the description string, please use the
//  dateToString() function provided earlier in this file.
//
//  Using Swift professionally, you might use an extension to add functionality to
//  something where you do not even have access to modify the original class
//  or struct. In those cases where you do not have access to even see the code
//  for the original class or struct, you can still add functionality to it.
//
//  Remember that since  MedicationContainer is a class with children, the
//  MedicationContainer may actually be a LiquidMedicationContainer or a
//  TabletMedicationContainer. You can use "is" to figure out if the underlying
//  type of self is really the parent or one of the children. If it is a
//  child you can use "as?" to get a temporary variable or constant of the
//  child type so you can include the properties of the child type in the
//  description string.
//
//  Then use the extension to also indicate that MedicationContainer
//  is compliant with CustomStringConvertible which tells the system to
//  start using the computed description property when printing an object
//  of Type MedicationContainer. You can do that by adding
//  ":CustomStringConvertible" to the first line of the extension.
//
//  When you have completed and tested the code, change task7() to return
//  true instead of nil, causing some test objects to be printed.

extension MedicationContainer {
    // put your code here to add a computed description property
}

func task7() -> Bool? {
    return nil
}

//  Task 8
//  The "==" operator is not automatically defined for classes since there may be many
//  different ways to define equality of class objects. If we want to compare two
//  MedicationContainers using "==" we need to override that operator for
//  MedicationContainers.
//
//  Assignment: Complete the extension below to override "==" and also
//  mark the extension with ": Equatable" to indicate that it is now compliant,
//  meaning that "==" is well defined for that Type.

//  Hint: In some data models we may want "==" to mean objects have the same values, but
//  think about this data model. For example, we might have many containers of the
//  same type of tablets with the same expiration date. But they each represent a separate
//  container of medication and we do not want them to be "==" unless they actually
//  represent the same object, the same bottle of medication. We defined a special property
//  to uniquely identify each unique medication container. That property is what should
//  define whether objects are "==". We should not need any other information to decide that.
//
//  After you are done, change "return nil" in task8() to "return {$0==$1}" to
//  allow Task 8 to be tested.
//
extension MedicationContainer {
    
    static func == (lhs: MedicationContainer, rhs: MedicationContainer) -> Bool {
        // replace the following with your code to define the "==" operator
        return false
    }
}
func task8() -> ((MedicationContainer, MedicationContainer)->Bool)? {
    return nil
}

//  Task 9
//  In the tasks next week, you will need to sort an array of MedicationContainers.
//  They should be sorted by expirationDate. We could explicitly do that comparison
//  every time we do a sort, but if we want to us a simplified sort operation like
//  "anArray.sort()" then we need to address the fact that MedicationContainers
//  do not have a built-in definition for the "<" and ">" operations. To do that we
//  can make MedicationContainer conform to the Comparable protocol. Since Equatable is
//  a parent of the Comparable protocol, we would need to conform to Equatable which
//  we just did. So to conform to Comparable all we need to do is override the "<"
//  operator. Think about why we don't need to override the ">" operator as well.
//
//  Assignment: For this task use another extension to define the "<" operator for
//  MedicationContainers. Be sure to also mark your extension as conforming with Comparable.
//
//  Hint: Think about the data model again. Since we want to sell the oldest medication
//  containers first, we should always sort using the expirationDate property.
//
//  After you are done, change "return nil" in task9() to "return {$0<$1}" to
//  allow Task 9 to be tested.
//
func task9() -> ((MedicationContainer, MedicationContainer)->Bool)? {
    return nil
}
