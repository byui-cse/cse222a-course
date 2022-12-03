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
//  Week 5 Tasks
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
//
//  Finally change the constant in first line of task3() to return true rather than
//  nil to indicated you have completed this task and it is ready to be tested.
//
func task0() -> Bool? {
    return nil
}

//  Task 1 Assignment
//
//  Finally change the constant in first line of task3() to return true rather than
//  nil to indicated you have completed this task and it is ready to be tested.
//
func task1() -> Bool? {
    return nil
}

//  Task 2 Assignment
//
//  Finally change the constant in first line of task3() to return true rather than
//  nil to indicated you have completed this task and it is ready to be tested.
//
func task2() -> Bool? {
    return nil
}

//  Task 3 Assignment
//  One thing you will do a lot in almost any programming career is to understand code
//  written by other people. So first, as practice at reading code, review the code below
//  that implements randomWalk and try to understand it. We usually try to set a good
//  example by documenting our code carefully, but for this we deliberately did not.
//
//  randomWalk(start:count:maxMove:) produces an array of enumeration values wih a
//  series of moves in a random walk in 2 dimensional space. The first parameter
//  is the starting point, the second is the count of moves desired and the third
//  is the maximum move forward or backward in a single move. Some of the enumeration
//  values have associated values.
//
//  The code in task3() repeatedly calls randomWalk() and then calls printWalk(). Your
//  task is to put code in printWalk that interprets the array it receives and uses
//  testPrint to print the result in a single line as follows:
//      put a single space between each of the following items
//      testPrint "S#,#" replacing the # characters with the starting position numbers
//      testPrint "F#" and "B#" for forward and backward replacing # with the distance
//      testPrint "R#" and "L#" for turnRight and turnLeft with # as diirection (see below)
//      testPrint "E#,#" at the end to indicate where we wound up
//  The directions are as follows:
//      0 moving to right, x incrementing, we start facing this direction
//      1 moving up, y incrementing
//      2 moving left, x decrementing
//      3 moving down, y incrementing
//  Note that we are using cartesian coordinates where increasing y goes up. Most of
//  the time you will program in screen coordinates where increasing y goes down.
//  Think about why the early software designers may have decided to have increasing
//  y go down on the screen instead of up like had been the tradition in mathematics.
//
//  Finally change the constant in first line of task3() to return true rather than
//  nil to indicated you have completed this task and it is ready to be tested. If
//  you are not sure if you are producing the right result you can change it to true
//  and the test system will tell you what it expoected to see.
//
extension Range<Int> {
    func randomArray(_ size: Int) -> [Bound] {
        return (0..<size).map { _ in Int.random(in: self) }
    }
}
//  Need to do both Range and ClosedRange since they do not roll up to
//  a partent Type that can be extended this way
extension ClosedRange<Int> {
    func randomArray(_ size: Int) -> [Bound] {
        return (0..<size).map { _ in Int.random(in: self) }
    }
}

enum Steps {
    case start(Int, Int)
    case forward(Int)
    case backward(Int)
    case turnRight
    case turnLeft
    static var count:Int { get { 5 }}
}
func randomWalk(start: (Int, Int), count: Int, maxMove: Int) -> [Steps] {
    return [.start(start.0, start.1)] +
            (1..<Steps.count).randomArray(count).map {
        switch $0 {
        case 1: return Steps.forward(Int.random(in: 1...maxMove))
        case 2: return Steps.backward(Int.random(in: 1...maxMove))
        case 3: return Steps.turnLeft
        case 4: return Steps.turnRight
        default: return Steps.forward(0)
        }
    }
}
func printwalk(theSteps: [Steps]) {
    // put your code here
    //  EDITOR for tasks.swift remove all of the code in this fucntion
    var location = (0, 0)
    var toPrint = ""
    var direction = 0
    let increments = [(1, 0), (0, 1), (-1, 0), (0, -1)]
    for step in theSteps {
        switch step {
        case .start(let h, let v):
            location = (h, v)
            toPrint += "S\(h),\(v)"
           break
        case .forward(let distance):
            location.0 += increments[direction].0
            location.1 += increments[direction].1
            toPrint += " F\(distance)"
            break
        case .backward(let distance):
            location.0 -= increments[direction].0
            location.1 -= increments[direction].1
            toPrint += " B\(distance)"
        case .turnRight:
            direction = (direction + 3) % 4
            toPrint += " R\(direction)"
           break
        case .turnLeft:
            direction = (direction + 1) % 4
            toPrint += " L\(direction)"
            break
       }
    }
    toPrint += " E\(location.0),\(location.1)"
    testPrint(toPrint)
}
func task3() -> Bool? {
    //  Do not edit anyting inside task3 except to change the last line
    //  from return nil to return true to start testing
    for _ in 0..<5 {
        let someSteps = randomWalk(
            start: (Int.random(in:-10...10), Int.random(in:-10...10)),
                               count: Int.random(in:5...15),
                               maxMove: Int.random(in:1...5))
        saveWalk(someSteps) // do not remove this line
        printwalk(theSteps: someSteps)
    }
    //  EDITOR for tasks.swift change this to "return nil" but do
    //  not change anything else inside task3()
    return true // when ready to test, change this to "return true"
}

//  Task 4 Assignment
//  This task is to simulate the implementation of a function or utility that
//  sometimes throws an an error condition to the caller. The Task4() function
//  will be called repeatedly with Arrays of optional Ints. If none of the values
//  are nil then just return the sum of the Array. But if any values are nil then
//  throw an error using .nilValueAt with the index of the first nil value in the
//  array.
//
//  By changing the return value of task4(0) from nil to the sum you are
//  indicating that the test code should start testing this task.
//
enum task4ErrorType: Error {
    case nilValueAt(Int)
}
func task4(_ someInts: [Int?]) throws -> Int? {
//    return nil
//  EDITOR for tasks.swift remove all of the remaining code in this function
//  and just leave "return nil"
    var returnValue = 0
    for index in 0..<someInts.count {
        guard let anInt = someInts[index] else {
            throw task4ErrorType.nilValueAt(index)
        }
        returnValue += anInt
    }
    return returnValue
}

//  Task 5 Assignment
//  Sometimes you will call a function in a module that you do not control.
//  And sometimes those functions will indicate that they can throw errors.
//  Task5 will be called with an array of Ints and a function. Add code to
//  Task5 that loops through the array and passes the values one by one to
//  the function. That function can throw an error of Type task5ErrorType.
//  Implement Do-Try-Catch inside your loop so that you can catch and recover
//  from a thrown error and continue processing the array. When an error is
//  caught, testPrint "Error:", the name of the error and the associated value
//  if there is one like "Error: errorWithInt 7", then continue the loop.
//  If a generic error is caught that does not match a value in task5ErrorType
//  then your generic catch handler should not testPrint anything, just
//  "throw error" to throw the unknown error up the chain.
//
//  Finally change the return from task5 to return the sum of returned values
//  (from the calls that did not throw any errors).
//
enum task5ErrorType: Error {
    case someError
    case errorWithInt(Int)
    case errorWithString(String)
    case errorWithDouble(Double)
}
typealias throwingFunction = (Int) throws -> Int
// EDITOR use this commented out version of task5() for tasks.swift
// func task5(intArray: [Int], canThrow: throwingFunction) -> Int? {
//    return nil
// }
func task5(intArray: [Int], canThrow: throwingFunction) throws -> Int? {
    var sum = 0
    for anInt in intArray {
        do {
            sum += try canThrow(anInt)
        } catch task5ErrorType.someError {
            testPrint("Error: someError")
        } catch task5ErrorType.errorWithInt(let errorInt) {
            testPrint("Error: errorWithInt \(errorInt)")
        } catch task5ErrorType.errorWithString(let errorString) {
            testPrint("Error: errorWithString \(errorString)")
        } catch task5ErrorType.errorWithDouble(let errorDouble) {
            testPrint("Error: errorWithDouble \(errorDouble)")
        } catch {
            throw error
        }
    }
    return sum
}

//  Task 6 Assignment
//  Using the first sample code from the this weeks Reading that reads data from
//  a web site, add code to task6() to read Read Data from a web site passed
//  into task6() as a block of data. Extract that data to a single String as
//  shown in the reading. Then return a tuple with the raw data and the String
//  instead of return nil as task6() currently does.
//  If you detect errors, we suggest you testPrint information about them
//  and then return nil from the function.
//
//  For what to do "useful" during the while loop, you can use the following
//  code or something else of your choice.
//      testPrint("Reading from internet", terminator: "")
//      while !done {
//          sleep(1)
//          testPrint(">", terminator: "")
//      }
//      testPrint() // close out the continued testPrint line
//
//  Note: the test code compares the string you return to the data the site returned
//  at the time this file was created. If the system says Task 6 fails due to what
//  you are sure is a change in the web site contents, you can submit this as
//  passing provided you also email your instructor so the test in main.swift
//  can be corrected.
//
func task6(aURL: String) -> (Data, String)? {
    // EDITOR change task6() to just return nil to produce tasks.swift
    //    return nil
    
    guard let url = URL(string: aURL) else {
        testPrint("Error in URL Format")
        return nil
    }
    var resultData = Data()
    var resultString = ""
    var hadError = false
    var done = false
    let task = URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        if let anError = error {
            testPrint("Error: \(anError)")
            hadError = true
            done = true
            return
        }
        guard let someData = data else {
            testPrint("Unknown Error")
            hadError = true
            done = true
            return
        }
        guard let aString = String(data: someData, encoding: .utf8) else {
            testPrint("Data did not convert to String")
            hadError = true
            done = true
            return
        }
        resultData = someData
        resultString = aString
        done = true
    }
    
    task.resume()
    
    testPrint("Reading from internet", terminator: "")
    while !done {
        sleep(1)
        testPrint(">", terminator: "")
    }
    testPrint()
    
    if hadError {
        return nil
    }else {
        return (resultData, resultString)
    }
}

//  Task 7 Assignment
//  Use the example from the reading to fillin the Task7Data structure to be able to
//  parse the JSON data in JSONdata below. Then add Task7Protocol to the type Task7Data
//  to confirm it complies with that protocol. Use the exampe from the reading to use a
//  JSONDecoder to decode the data into the structure. Then return the decoded data
//  from the function as a Task7Data object rather than returning nil.
//
struct Task7Data: Codable, Task7Protocol {
    // fill in the members of this Struct
    // EDITOR for tasks.swift delete the contents of this struct and remove
    // reference to Task7Protocol
    var name: String
    var address: String
    var city: String
    var state: String
    var zip: String
    var country: String
}
func task7() -> Task7Data? {
    let JSONdata = #"{"name": "Equardo Jones", "address": "13 Camino do Oro", "city": "Rexburg", "state": "Idaho", "zip": "83460", "country": "United States"}"#.data(using: .utf8) ?? Data()
    // Insert your code here
    // EDITOR remove the rest of the code in this function for tasks.swift except "return nil"
   let decoder = JSONDecoder()
    do {
        let decoded = try decoder.decode(Task7Data.self, from: JSONdata)
        testPrint(decoded)
        return decoded
    } catch {
        testPrint("decoder failed: \(error)")
    }
    return nil
}

//  Task 8 Assignment
//  First testPrint the data that is passed into task8(). This is the data you need to
//  decode. Now use the example from the reading to fill in the GeoData and Place structures
//  to be able to parse the JSON data in JSONdata below. You will need to add CodingKeys to
//  both structures this time. When mapping from a key name with a space, in the matching
//  structure please remove the space and capitalize the first letter of the second work
//  like "some key" becoming "someKey". Please also remap the name of "places" to become
//  "placeArray". Then add Task8Protocol2 to the type Place amd Task8Protocol1 to the
//  type GeoData to confirm they comply with those protocols. Use the exampe from the
//  reading to use a JSONDecoder to decode the data into the structures. Then return
//  the decoded data from the function as a GeoData object rather than returning nil.
//
struct Place: Codable, Task8Protocol1 {
    // fill in the members and codingKeys of this Struct
    // EDITOR for tasks.swift delete the contents of this struct and remove
    // reference to Task8Protocol1
   enum CodingKeys: String, CodingKey {
        case longitude, state, latitude
        // Map the JSON key "url" to the Swift property name "htmlLink"
        case placeName = "place name"
        case stateAbbreviation = "state abbreviation"
    }
    var placeName: String
    var longitude: String
    var state: String
    var stateAbbreviation: String
    var latitude: String
}
struct GeoData: Codable, Task8Protocol2 {
    // fill in the members and codingKeys of this Struct
    // EDITOR for tasks.swift delete the contents of this struct EXCEPT keep
    // placeArray and remove reference to Task8Protocol2
    enum CodingKeys: String, CodingKey {
        case country
        case placeArray = "places"
        case postCode = "post code"
        case countryAbbreviation = "country abbreviation"
    }
    var postCode: String
    var country: String
    var countryAbbreviation: String
    var placeArray: [Place]
}
func task8(JSONdata: Data) -> GeoData? {
    // Insert your code here
    // EDITOR remove the rest of the code in this function for tasks.swift except "return nil"
    let decoder = JSONDecoder()
    do {
        let decoded = try decoder.decode(GeoData.self, from: JSONdata)
        testPrint(decoded)
        return decoded
    } catch {
        testPrint("decoder failed: \(error)")
    }
    return nil
}

//  Task 9 Assignment
//  The URL passed to Task6 was "https://api.zippopotam.us/us/83460". This is a structured
//  URL that returns geolocation data including lattitude and longitude. The charcters
//  after the last "/" form a postal or zip code and the previous charsters form a
//  country code. The options for country codes and postal codes are listed at this site:
//      "file:///Users/cm/Downloads/zippopotamus-master/views/index.html"
//
//  First, change the content of buildGeoURL(countryCode:postalCode:) to return
//  a geolocation URL using the parameters it receives.
//
//  Second, using the parameters passed into task9, create a URL and pass it to
//  Task6(). In this case, ignore the String return value, but use the Data return
//  value. The Decoder we built for task8 matches the data coming back from this
//  web site so you can then pass the data from task6() to task8() and you will
//  have an object of type GeoData. Cache a copy of that object so you can return
//  it at the end of the function. If either task6() or task8() retunm nil at this
//  point, testPrint an error message and return nil from task9()
//
//  Now create a while true loop like we did in Task 2 of Week 2 where you querry the
//  user until the user responds with "done". Ask the user to input a country code
//  then ask the user to input a postal or zip code. Pass those to buildURL, then to task6(),
//  then to task8() and testPrint the returned value. For this part of task 9 you can format
//  the printing to make it easier for the user to read the information. Remember to
//  allow for placeArray to have more than one member which it will if you happen to
//  have parts of two cities or towns sharing a postal code.
//
//  You are now interactively pulling data from a web site. When the loop ends, return
//  the first value you received from calling task8().
//
func buildGeoURL(countryCode: String, postalCode: String) -> String {
    // fill in the members and codingKeys of this Struct
    // EDITOR for tasks.swift delete the contents of this struct and just
    // leave 'return ""'
    return "https://api.zippopotam.us/\(countryCode)/\(postalCode)"
    //    return ""
}
func task9(countryCode: String, postalCode: String) -> GeoData? {
    // Insert your code here
    // EDITOR remove the rest of the code in this function jsut keep "return nil"
    let firstURL = buildGeoURL(countryCode: countryCode, postalCode: postalCode)
    guard let (firstData,_) = task6(aURL: firstURL) else {
        testPrint("Could not access data from \(firstURL)")
        return nil
    }
    guard let firstObject = task8(JSONdata: firstData) else {
        testPrint("Could not convert data from \(firstURL)")
        return nil
    }
    
    while true {
        testPrint("Please enter a country code or 'done' to stop")
        guard let countryCode = testReadLine() else { continue }
        if countryCode == "done" { break }
        if countryCode == "" { continue }
        testPrint("Please enter a postal or zip code")
        guard let postalCode = testReadLine() else { continue }
        if postalCode == "done" { break }
        if postalCode == "" { continue }
        let aURL = buildGeoURL(countryCode: countryCode, postalCode: postalCode)
        guard let (geoData,_) = task6(aURL: aURL) else {
            testPrint("Could not access data from \(aURL)")
            continue
        }
        guard let anObject = task8(JSONdata: geoData) else {
            testPrint("Could not convert data from \(aURL)")
            continue
        }
        testPrint("Postal Code: \(anObject.postCode)")
        testPrint("Country: \(anObject.country)")
        testPrint("Country Abbreviation: \(anObject.countryAbbreviation)")
        testPrint("\(anObject.placeArray.count) places")
        for place in anObject.placeArray {
            testPrint("Place Name: \(place.placeName)")
            testPrint("\tLongitude: \(place.longitude)")
            testPrint("\tState: \(place.state)")
            testPrint("\tState Abbreviation: \(place.stateAbbreviation)")
            testPrint("\tLatitude: \(place.latitude)")
        }
    }

    return firstObject
//    return nil
}
