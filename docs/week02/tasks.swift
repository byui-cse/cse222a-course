//
//  Tasks.swift
//  Week 2 Tasks
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
//  but allow the test code to see what you print and what is input from the user.
//

import Foundation

// This is used for Task 0 and task 1. Please do not change this enum.
enum GuardedErrors {
    case success
    // used by Task 0:
    case aBoolFalse
    case int1_less_than_0
    case int1_less_than_or_equal_int1
    case aString_not_4_chars
    // used by Task 1:
    case string_is_nil
    case testReadLine_is_nil
    case input_does_not_match
    // computed value to make it easy to print the name of an enum case for debugging
    var value: String { return String(describing: self)}
}

//  Task 0
//  One common use of guard is to validate parameters passed to functions.
//  Add code to this function using multiple guard statements to validate that
//  the parameters comply with the following rules:
//      aBool must be true
//      int1 must be greater than or equal to 0
//      int2 must be greater than int1
//      aString must be exactly 4 characters long
//  In the else clause of each guard statement, use testPrint() to print an error
//  message that includes the name of the value in GuardedErrors enum that applies
//  to the situation, then return that value from GuardedErrors.
//  If all guards pass, then use testPrint to print the product of int1 and int2
//  and return .success
//
//  Hints:
//  1) Use String Interpolation as described in this link to testPrint "Error <error>".
//  https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html#ID292
//  If <error> represents the name of a  case in GuardedErrors, then you can write
//  something like this:
//      testPrint("Error: \(GuardedErrors.aBoolFalse.value)")
//  2) When refering to a specific enum <error> in GuardedErrors, you can always write
//      GuardedErrors.<error>
//  but if context already defines the enum Type, you can just write .<error> for example:
//      return .aBoolFalse
//` since he compiler knows that the return value Type is GuardedErrors
//  3) Some languages use .len or .size to give the size of a string. In Swift,
//  the number of elements in a collection like an array and the number of characters in
//  a string are both given by ".count".
//
func task0(aBool: Bool, int1: Int, int2: Int, aString: String) -> GuardedErrors? {
    return nil
}

//  Task 1
//  Another use of guard is to help you unpack optionals. If you have an optional called
//  myOptional then you can write a guard statement like this:
//      guard let myValue = myOptional else { ...some code including return, break or continue... }
//  myValue can then be used in the remainder of the function or loop.
//
//  Add code that uses "guard let" to test that the optionalString is not nil.
//  Then use String Interpolation and testPrint to ask the user to Type that string into
//  the console. Then use "guard let" to confirm that the input is not nil and that the value
//  matches the optionalString. If any guards fail return the appropriate error from GuardedErrors.
//  If successful testPrint("Success!") and return .success. Note that the test will call
//  task1 with nil, then call task1 repeatedly with a string until it testPrints "Success!"
//  and returns .success.
//
//  Hints:
//  1) Note the use of "_" to indicate a parameter name is not used when calling the function.
//  2) readLine() and testReadLine() return a String? which is an optional, a value that can
//  either be nil or a String. There are three typical ways to "unwrap" an optional:
//      1) Use the ?? operator to unwrap it providing a default if the optional is nil
//      2) Use "if let" to create an unwrapped version of the optional that can be
//         used within the true clause of the if
//      3) Use "guard let" to create an unwrapped version of the optional that
//         can be used in the remainder of the function or loop following the else clause
//      Use "guard let" in this task. "??" does not allow you to report if it was optional.
//  Remember to never use "!" to force unwrap an optional in this class.
//
func task1(_ optionalString: String?) -> GuardedErrors? {
    return nil
 }

//  Task 2
//  Add code that has a "while true" loop and inside that loop, ask the user for to
//  input their name using testPrint(). Then receive input using testReadLine().
//  If the input is "done" break from the loop. Otherwise print a message to the user
//  that says "Hello <name>!" where name is the string you receive from testReadLine().
//  Use String Interpolation as described in Task 0.
//  If testReadLine() returns nil or an empty string, simply repeat the loop and do not
//  testPrint anything. The function should return a count of the number of times the user
//  entered a name before selecting "done".
//
//  Hint:
//  Not needed for this task, but if you want to be able to modify the value where you
//  are storing an unwrapped variable, you can say "guard var" instead of "guard let"
//  and "if var" instead of "if let". You may want to use "if let" in this task.
//  Remember to never use "!" to force unwrap an optional in this class.
//
func task2() -> Int? {
    return nil
}

//  Task 3
//  Built in functions like map, filter, reduce and sort take a parameter that is a closure or
//  anonymous functions like anArray.filter({$0==1}). If the closure is the last parameter, we
//  often move the {} outside the () and if it is the only parameter, we don't need the () at all,
//  so we could write that anArray.filter{$0==1}.
//
//  Inside this function is an array of closures that each take two Int parameters. Complete each
//  closure according to the list below, then change "return nil" to "return closureArray".
//
//  Closure 0: return the sum of the two parameters
//  Closure 1: return the product of the two parameters
//  Closure 2: return -1 if the first paramater is less than the second parameter,
//              return 0 if they are equal
//              return 1 if the first parameter is greater than the second parameter
//  Closure 3: return -1 if the first paramter is < 0
//              return -2 if the first parammater is >= test3Array.count
//              return 0 if test3Array[first_parameter] != second_parameter
//              return 1 if test3Array[first_parameter] == second_parameter
//  Closure 4: return -1 if both paramneters are odd
//              return 1 if both parameters are even
//              return 0 if one parameter is odd and the other is even
//
//  Hints
//  1) Some closures are set up with names for the two parameters so use them. The syntax for that
//  is to list the parameter names in ( ) inside the { } followed by the keyword "in".
//  2) If names are not set up for the parameters, use $0 and $1 to refer to the two parameters.
//  3) FYI, parameter names lhs and rhs stand for "left hand side" and "right hand side" and are
//  used, for example, for the names of the default parameter names for a closure for sort
//  4) If a closure is specified as having two parameters, for example, and you do not set up
//  names for them, then $0 and $1 must be used in the closure or the compiler will generate
//  an error. To avoid that error until you are ready to work on Task3(), we just put a
//  statement in those closure templates taht says return $0-$1. You will replace that with
//  the appropriate return statement.
//
let test3Array = [5, 4, 3, 2, 1, 0] // Do not  // Do not modeify this array modeify this array
typealias task3Func = (Int, Int) -> Int
func task3() -> [task3Func]? {
    let closureArray: Array<task3Func> = [
        { // Closure 0:
            (first_parameter, second_parameter) in
            // your code goes here
            return 0
        },
        { // Closure 1:
            (parm1, parm2) in
            // your code goes here
            return 0
        },
        { // Closure 2:
            (lhs, rhs) in
            // your code goes here
            return 0
        },
        { // Closure 3:
            // your code goes here
            return $0-$1
        },
        { // Closure 4:
            // your code goes here
            return $0-$1
        }
    ]
    return nil
}

//  Task 4
//  Almost everythng other than class objects (that we will learn about later) is passed to
//  functions by value. That means that a an copy is sent to the function that is unmutable
//  (cannot be modified). But what if we wamt tp return twp things from a function such as
//  a boolean and a modified array? YOu can indicate a parameter is mutable by putting "inout"
//  after the colon, but in front of the Type like "myInt: inout Int". Then the calling function
//  must acknowledge that it knows this is a mutable parameter by putting a & in front of the
//  name of the variable being passed into the function.
//
//  Add code to function task4a (not to task4) that uses map() to square each element of the input
//  array. Then use filter() to remove any results that have a "1" in the last digit. When you
//  first try modifying "anArray" inside Task4a, the compiler will complain that it is not
//  mutable. You will need to use the information in the previous paragraph to solve that.
//  You should not modify the main body of task4 except a one-character change on the line
//  where task4a is called
//
//  Hint: This demostrates function scope. Top level functions are usually visible to any other
//  other function in the project, even those in other files. But functions embedded inside
//  another function are only visible to that function. If you put "private" in front of
//  the "func" keyword then a top-level function is only visible inside that file.
//  All but two of the functions inside main.swift are market private?
//
func task4(inArray: [Int]) -> [Int]? {
    var returnArray = inArray
    guard task4a(anArray: returnArray) else { return nil }
    return returnArray
            
    func task4a(anArray: [Int]) -> Bool {
        // insert your use of map and filter here, then change the return value to true
        return false
    }
}

//  Task 5
//  The reduce Built in Function takes two parameters. The first is a starting value. The second
//  is a closure. The closure is called for each element in the array. THe first time the closure
//  receives the starting value in the first parameter and the array element in the second parameter.
//  After that it receives the result of the previous call to closure in the first parameter and the
//  next array element in the second parameter. Here are links to more documentation about reduce()
//  https://developer.apple.com/documentation/swift/array/reduce(_:_:)
//  https://useyourloaf.com/blog/swift-guide-to-map-filter-reduce/
//
//  Add code that uses reduce on the input array to produce a sum of the values in the array and
//  return the result.
//
func task5(inArray: [Int]) -> Int? {
    return nil
}

//  Task 6
//  Add code that uses reducde on the input array to produce the product of the values in the array and
//  return the result.
//
func task6(inArray: [Int]) -> Int? {
    return nil
}

//  Task 7
//  The most used loop in Swift is "for <variable> in <range or collection or sequence>"
//  This assigns to the variable you specify a new value on each loop. The value can come from
//  a range that you specify or if you provide a collection such as an array or a sequence
//  this will assign each element of the collection to the variable for one iteration of the loop.
//  As explained in the reading, ranges can be defined as 1...4 or 0..<4. Both of those produce
//  four values. The first produces 1,2,3,4 and the second produces 0,1,2,3. If you want to skip
//  values or go backwards, you use stride(fron:through:by:) or stride(fron:to:by:). "through"
//  includes the value specified while "to" goes up to, but not inclusive of that value.
//  Note that by: can be negative allowing you to count down rather than up.
//  https://developer.apple.com/documentation/swift/stride(from:to:by:)
//
//  For this task you will append integers to returnArray and then return the Array.
//  Use a for loop and a range to add the numbers from 2 to 7
//  Use a for loop and a stride to add the odd numbers from 1 to 9
//  Use a for loop and a stride to add the numbers from 5 to 0
//  Use a for loop over the input array to add its contents to returnArray
//
//  Hint:
//  There are other, sometimes better ways to acomplish these steps, but
//  the purpose of this exercise is to practice using for loops
//
func task7(inArray: [Int]) -> [Int]? {
    // You will append values to this array, then return it
    var returnArray:[Int] = []
    // Insert your code here
    return nil
}

//  Task 8
//  Add code that creates and returns an Array of Arrays of random Ints.
//  The Int values should be randomly chosen from the range in the "aRange" parameter"
//  The main Array should have "rowCount" Arrays inside it.
//  Each of those inner Arrays should have "columnCount" Int values.
//  This should work for any reasonable values of rowCount, columnCount and aRange.
//  Best practice would be for you to check the parameters to make sure they are reasonable.
//  For the tests you will receive values for rowCount and columnCount between 10 and 30 inclusive.
//  For the tests the bottom of the aRange will be between 0 and 10 and the top between 20 and 30 inclusive.
//
//  Hint:
//  Types like Int and Double have built in functions that can be accessed
//  by adding a dot and a function name to the Type name like Int.function()
//  or else by adding a dot and a function name to the name of a variable
//  of that Type like myInt.function().
//  Search Swift documentation on the web for ways to generate random Ints.
//
func task8(rowCount: Int, columnCount: Int, aRange: ClosedRange<Int>) -> [[Int]]? {
    return nil
}

//  Task 9
//  Add code that accepts an Array of Array of Int values.
//  For each row in the input Array, calculate the minimum, maximum and mean or average of that row.
//  Then store the minimum, maximum and average as doubles in a row of a new Array.
//  Return the new Array with a row of three Doubles for each row in the input Array.
//  The input Array intValues will contain random integers. Your code should work with any size of array.
//  The number of rows and columns in the array will vary between 10 and 30
//
//  Hint:
//  You can use the name of Types like Int and Double as functions that construct an element of that Type.
//  You can research the parameters available, but one option is use Double(anInt) to get a Double that
//  matches the value of anInt. For the calculation of mean, you may need to convert the values to Double
//  before operations like division.
//
func task9(intValues:[[Int]]) -> [[Double]]? {
    return nil
}
