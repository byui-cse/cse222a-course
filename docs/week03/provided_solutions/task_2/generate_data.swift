//
//  generate_data.swift
//  week03_task_2
//
//
// To use this you just need to call generateData(). However, to make it work, you need to define some things in your own files:
// In a model.swift file you need to define
//      enum EmployeeType {
//          case programmer
//          case devLead
//      }
//      class Employee that has data elements used below
//      class Manager that is a child of Employee
// You also need to create this function:
//      func add(managee:Employee, to aManager:Manager) -> (Bool,AssignmentError)
//      It returns a tuple with a Bool to indicate if it was possible to add the employee to that manager under the rules
//      and an enum of class AssignmentError (that you define) indicating the reason for failure if any
// This will only compile if you provide those classes and this function

import Foundation

// These two constants are public so you can use them in your code.
// The only other public item is the generateData() function

// Constants used to make computation in the functions below more readable.
let oneYear: Double = 365 * 24 * 60 * 60
// No need to worry about leap years and such. This is close enough to meet the business' criteria.
let fiveYears: Double = 5 * oneYear

/// This structure represents a sequence of random numbers for a given [triangular distribution](https://www.statology.org/triangular-distribution/ ).
/// The least value, greatest value and the peak value are all required at instantiation. This stream implements the [Stein, Keblis (2009)](https://www.sciencedirect.com/science/article/pii/S0895717708002665) algorithm.
///
/// This struct is module private.
/// By adding the protocols Sequence and IteratorProtocol, we can then use built in functionality including the example below where we use
/// an element of this type in a for .. in ... loop and Swift takes care of everyting else for us
private struct TriangularDistributionSequence: Sequence, IteratorProtocol {
    let leastValue: Double
    let greatestValue: Double
    /// The peak value (x value of the greatest y value) of the distribution.
    let peakValue: Double
    /// This optional value will limit the sequence to a specific number of results, then return Nil after that.
    /// If this is set to Nil, then a for...in loop using this sequence will never automaticlaly terminate.
    var resultCount: Int?

    /// This function gets the next value in the distribution stream. All values are in \[a,b\].
    /// THe function needs the mutating keyword because it is a struct function that modifies a value in the struct (resultCount)
    /// - Returns: a Double that is in the distribution.
    mutating func next() -> Double? {
        // if resultCount is defined, make sure it is still >0 and decrement it
        guard let c = resultCount, c > 0 else {
            return nil
        }
        resultCount = c - 1 // decrement resultCount

        let u = Double.random(in: leastValue ... greatestValue)
        let v = Double.random(in: leastValue ... greatestValue)
        return (1 - peakValue) * Swift.min(u, v) + peakValue * Swift.max(u, v)
    }
}

/// This function generates a simulated set of Manager and Employee (programmer type) instances used to drive the managee assignment and hiring needs code. No management assignments have been made for the programmers.
/// - Returns: a tuple consisting of a list of Manager instances and a list of Employees of type programmer.
///
/// - Complexity: O(n)
func generateData(numManagersNeeded: Int, numProgrammersNeeded: Int) -> ([Manager], [Employee]) {
    // These numbers are indicated in the problem requirements.

    // Generate an Array of managers. Data generation of a specific number of items
    // is one of the few places where the use of for loops is defensible rather than using built-in
    // functions like map, filter and reduce.
    var existingManagers = buildManagers(numManagersNeeded: numManagersNeeded)

    // This value of c guarentees the number of experienced programmers is less than the number of managers
    // as per the problem requirements. This line creates a stream of numbers in a triangular distribution.
    let experienceSequence = TriangularDistributionSequence(leastValue: 0, greatestValue: 1, peakValue: 0.22, resultCount: numProgrammersNeeded)
    // Generate an Array of programmers.
    var programmers = buildProgrammers(experienceSequence)

    // Divide the programmer list into novice and experienced programmers.
    let experiencedProgrammers = programmers.filter {
        Date().timeIntervalSince($0.hireDate) >= oneYear && $0.yearsExperience > 5
    }
    // Remove from programmers rather than filter as an example of using another method available
    // from the Array API.
    programmers.removeAll {
        Date().timeIntervalSince($0.hireDate) >= oneYear && $0.yearsExperience > 5
    }
    print("Generated Testing Data")
    print("\tThis is provided as a service to aid you in debugging your code.\n\tDo NOT use it for calculations.")
    print("\tManagers: \(existingManagers.count)")
    print("\tNovice Programmers: \(programmers.count)")
    print("\tExperienced Programmers: \(experiencedProgrammers.count)")

    // distribute experienced programmers to managers
    existingManagers = assignExperiencedEmployee(employees: experiencedProgrammers, managers: existingManagers)

    var unassignedProgrammers = [Employee]()
    // distrubute novice programmers to managers
    for programmerIndex in 0 ..< programmers.count {
        var (suceeded, message) = (false, AssignmentError.noManagers)
        var managerIndex = 0
        while !suceeded, managerIndex < existingManagers.count {
            // We use manager index to check each manager to see if we can add this programmer
            // By adding it to the programmerIndex and using % we change the order we try the managers
            // and so we spread them across all managers
            (suceeded, message) = add(managee: programmers[programmerIndex], to: existingManagers[Int(programmerIndex + managerIndex) % numManagersNeeded])
            managerIndex += 1
        }
        if !suceeded {
            unassignedProgrammers.append(programmers[programmerIndex])
            print("Couldn't add a novice Programmer \(programmerIndex) to a Manager. Reason: \(message)")
        }
    }
    return (existingManagers, unassignedProgrammers)
}

/// A module private function that generates the required number of programmers as per the problem statement.
/// - Parameters:
///   - numNoviceProgrammersNeeded: the remaining number of programmers needed.
///   - experienceStream: the triangular distribution used to determine the years of experience for each
///      generated programmer.
/// - Returns: a list of programmer type employees.
/// - Complexity: O(n)
///
/// This function is module private.
private func buildProgrammers(_ experienceSequence: TriangularDistributionSequence) -> [Employee] {
    var returnValue = [Employee]()
    // If the array were very large, we could pass in the number of employees required as a
    // parameter and pre-create the full array using something like this:
    // let blankEmployee = Employee(name: "", hireDate: Date(), yearsExperience: 0, type: .programmer)
    // var returnValue = Array(repeating: blankEmployee, count: numNeeded)
    // Then we would just update array elements instead of appending

    for experience in experienceSequence {
        let aYearsExperience = UInt8(experience * 10)
        let aHireDate = randomHireDate(experience: aYearsExperience)
        returnValue.append(Employee(name: randomName(), hireDate: aHireDate, yearsExperience: aYearsExperience, type: .programmer))
    }
    return returnValue
}

/// This function instantiates a series of Manager instances according to the problem requirement. Each
/// Manager instance has no managees.
/// - Parameter numManagersNeeded: the remaining number of managers that need to be instantiated
/// - Returns: a list of instantiated managers with no managees
/// - Complexity: O(n)
///
/// This function is module private.
private func buildManagers(numManagersNeeded: Int) -> [Manager] {
    if numManagersNeeded == 0 {
        return [Manager]()
    }
    let aManager = Manager(name: randomName(), hireDate: Date(), type: .devLead, yearsExperience: UInt8.random(in: 0 ..< 22))
    return [aManager] + buildManagers(numManagersNeeded: numManagersNeeded - 1)
}

/// In this simulated data there are fewer experienced employees than managers. This is as per
/// the problem description. Therefore this function assignes experienced employees to managers
/// until there are no more experienced employees left to assigned. This implies that there will
/// be some managers that do not have an experienced employee that they are currently assigned to manage.
///
/// This function is module private.
/// - Parameters:
///   - employees: remaining experienced employees that have not been assigned to a manager
///   - managers: remaining managers that don't have an experieced employee assigned to them
/// - Returns: a list of managers with zero or one experienced employee assigned to them
/// - Complexity: O(n)
private func assignExperiencedEmployee(employees: [Employee], managers: [Manager]) -> [Manager] {
    if employees.count == 0 {
        return managers
    }
    var mutableEmployees = employees
    var mutableManagers = managers
    let employeeHead = mutableEmployees.remove(at: 0)
    let managerHead = mutableManagers.remove(at: 0)
    _ = add(managee: employeeHead, to: managerHead)
    return [managerHead] + assignExperiencedEmployee(employees: mutableEmployees, managers: mutableManagers)
}

/// Generates a random string of six characters used as a name.
/// This function is module private.
/// - Returns: a simulated name. The name need not make sense in any language.
private func randomName() -> String {
    let letters = "abcdefghijklmnopqrstuvwxyz"
    return String((0 ..< 7).map { _ in letters.randomElement()! })
}

/// Generates a Date used as a determinator for if an employee is a novice or experienced.
/// This function is module private.
/// - Returns: a simulated hire date in the range 0 to 10 years
/// - Complexity: O(1)
private func randomHireDate(experience: UInt8) -> Date {
    // Make sure years at the company is not greater than  years of experience.
    let maxYears = Swift.min(Int(experience), 10)
    return Date().advanced(by: -oneYear * Double(Int.random(in: 0 ... maxYears)))
}
