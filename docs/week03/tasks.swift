//
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

//  Do not edit the following date utilities. You are welcome to use them.
//  You can edit the line with "ddMMMyyyy" to try different date formats.
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
//  can be used. Let's create a function that can generate a Range or a pseudo
//  range. In generateRange() below, if the int1 <= int2 return the matching Range.
//  Otherwise return an Array that has values counting from int1 down to and including
//  int2 which can be used most places a range could be used.
//  Note: most tasks have a function called taskN(), but we gave
//  the function for Task 3 a more meaningful name.
func generateRange(_ int1: Int, _ int2: Int) -> Any? {
    return nil
}

//  Task 4
//  task4() is called with two Ints. Call generateRange() with the parameters received.
//  Return 1 if the value returned from generateRange() is a ClosedRange<Int>.
//  Return 2 if the value returned from generateRange() is an Array<Int>.
//  Otherwise return 0 (this case should not happen if generateRange() is correct)
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
//  This function receives the same array as Task5. This time use compactMap to
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
//  When we print a MecicationContainer, it just says
//  Week3Tasks.MedicationContainer. Among other things, that makes it
//  harder to print things and track down errors.
//
//  Assignment: use the empty extension below to fix this by adding compliance
//  with the CustomStringConvertible protocol. That will allow more detailed
//  information when printing. In the extension, add a String computed property
//  called description that returns a string with details about all the
//  non-computed properties in the MedicationContainer. Remember that since
//  MedicationContainer is a class with children, the MedicationContainer
//  may actually be a LiquidMedicationContainer or a TabletMedicationContainer.
//  Use "is" to figure out what it is and include all the properties of the
//  appropriate type in your description string.
//
//  When you have completed and tested the code task7() to return true
//  instead of nil which will cause some test objects to be printed

extension MedicationContainer {
    // put your code here to add a computed description property
}

func task7() -> Bool? {
    return nil
}

//  Task 8
//  The "==" operator is not automatically defined for classes since there may be many
//  different ways to define equality of objects. If we want to compare two
//  MedicationContainers using "==" we need to override that operator for
//  MedicationContainers.
//
//  Assignment: Complete the extension below to override "==" and also
//  mark the extension with ": Equatable" to indicate that it is now compliant.

//  Hint: In some data models we may want "==" to mean pbjects have the same values, but
//  think about this data model. We might have several containers of the same tablets
//  with the same expiration date and yet not want them to be "==" unless they
//  actually represent the same object. What member uniquely identifies an object?
//
//  After you are done, change "return nil" in task8() to "return {$0==$1}" to
//  allow Task 7 to be tested.
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
//  In tasks next week, you will need to sort an array of MedicationContainers.
//  They should be sorted by expirationDate. We could explicitly do that comparison
//  every time we do a sort, but if we want to us a simplified sort operation like
//  "anArray.sort(>)" then we need to address the fact that MedicationContainers
//  do not have a built-in defintion for the "<" and ">" operations. To do that we
//  can make MedicationContainer conform to the Comparable protocol. Since Equatable is
//  a parent of the the Comparable protocol, we would need to conform to Equatable which
//  we already did. So to conform to Comparable all we need to do is override the "<"
//  operator. Think about why we don't need to override the ">" operator as well.
//  Assignment: For this task use an extension to define the "<" operator for
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

//  Task 10
//  Suppose we add a MedicationContainer to a PharmaceuticalStockTracker a lot in our
//  code and we really want every occurance of that to stand out. We might create a
//  special opeator to use for that to make them more visible in our code.
//
//  As an example have defined a new infix operator "<-||". Since it
//  is an infix operator we needed to indicate it's precedence in expressions.
//  We labeled it ": AdditionPrecedence", giving it the same precdedence in
//  expressions with multiple operators as addition and subtraction, but lower than
//  multiplication and division.
//
//  Your first assignment is to implement "<-||" by replacing the line that says
//  return false inside the definition below with a call to the existing
//  addContainer() method. Now we could can use the <-|| operator like this:
//      guard aStockTracker <-|| aContainer, aStockTracker <-|| bContainer else ...
//      if aStockTracker <-|| aContainer { ... } else { ... }
//  When lookking through code for cases where we add MedicationContainers
//  to a PharmaceuticalStockTracker, those will really stand out now.
//
//  Your second assignment is to create new postfix operator that will clean any expired
//  medication from a PharmaceuticalStockTracker. It should remove any expired containers
//  from the tracker and return an array of any containers that were removed.
//  The array of expired containers should be sorted with the oldest expiration
//  dates first. Deine the characters that make up your operator using any
//  allowed combination of characters as defined here:
//      https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID418
//
//  Suppose your operator were defined as |||. Then it could be used like this:
//      let removedContainers: [MedicationContainer] = aStockTracker|||
//
//  Hint: you may find "filter()" and "sorted()" useful here.
//
//  After you are done, change "return nil" in task10() to "return {$0|||}" but
//  using the operator you define instead of "|||" in the closure.
//
infix operator <-||: AdditionPrecedence
extension PharmaceuticalStockTracker {
    static func <-|| (tracker: inout PharmaceuticalStockTracker, container: MedicationContainer) -> Bool {
        // replace this line with a call to addContainer()
        return false
    }
}
func task10() -> ((inout PharmaceuticalStockTracker)->[MedicationContainer])? {
    return nil
}
