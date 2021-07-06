//
//  generate_data.swift
//  week03_task_2
//
//

import Foundation


/// This structure represents a stream of random numbers for a given [triangular distribution](https://www.statology.org/triangular-distribution/ ).
/// The least value is a, the greatest value is b, and the peak value is c. All are required at instantiation. This stream implements the [Stein, Keblis (2009)](https://www.sciencedirect.com/science/article/pii/S0895717708002665) algorithm.
///
/// This struct is module private.
private struct TriangularDistributionStream{
    let a:Double
    let b:Double
    /// The peak value (x value of the greatest y value) of the distribution.
    let c:Double
    
    /// This function gets the next value in the distribution stream. All values are in \[a,b\].
    /// - Returns: a Double that is in the distribution.
    func next() -> Double {
        let u = Double.random(in: a...b)
        let v = Double.random(in: a...b)
        return(1-c)*min(u,v) + c*max(u, v)
    }
}

/// This function generates a simulated set of Manager and Employee (programmer type) instances used to drive the managee assignment and hiring needs code. No management assignments have been made for the programmers.
/// - Returns: a tuple consisting of a list of Manager instances and a list of Employees of type programmer.
///
/// - Complexity: O(n)
func generateData(numManagersNeeded:Int, numProgrammersNeeded:Int) -> ([Manager],[Employee]) {
    //These numbers are indicated in the problem requirements.
    
    
    //Generate an Array of managers. Data generation of a specific number of items
    //is one of the few places where the use of for loops is defensible.
    var existingManagers = buildManagers(numManagersNeeded: numManagersNeeded)
    

    //This value of c guarentees the number of experienced programmers is less than the number of managers
    //as per the problem requirements. This line creates a stream of numbers in a triangular distribution.
    let experienceStream = TriangularDistributionStream(a:0, b:1, c:0.22)
    
    //Generate an Array of programmers.
    var programmers = buildProgrammers(numNoviceProgrammersNeeded: numProgrammersNeeded, experienceStream: experienceStream)
    
    
    //Divide the programmer list into novice and experienced programmers.
    let experiencedProgrammers = programmers.filter{
        Date().timeIntervalSince($0.hireDate) >= oneYear && $0.yearsExperience > 5
    }
    //Remove from programmers rather than filter as an example of using another method available
    //from the Array API.
    programmers.removeAll{
        return Date().timeIntervalSince($0.hireDate) >= oneYear && $0.yearsExperience > 5
    }
    print("Generated Testing Data")
    print("\tThis is provided as a service to aid you in debugging your code.\n\tDo NOT use it for calculations.")
    print("\tManagers: \(existingManagers.count)")
    print("\tNovice Programmers: \(programmers.count)")
    print("\tExperienced Programmers: \(experiencedProgrammers.count)")

    //distribute experienced programmers to managers
    existingManagers = assignExperiencedEmployee(employees: experiencedProgrammers, managers: existingManagers)
   
    var unassignedProgrammers = [Employee]()
    //distrubute novice programmers to managers
    for var index in 0..<programmers.count{
        let programmerIndex = index
        var (suceeded,message) = add(managee: programmers[index], to: existingManagers[index % numManagersNeeded])
        while !suceeded && index < existingManagers.count{
            index += 1
            (suceeded,message) = add(managee: programmers[index], to: existingManagers[index % numManagersNeeded])
        }
        if !suceeded{
            unassignedProgrammers.append(programmers[index])
            print("Couldn't add a novice Programmer \(programmerIndex) to a Manager. Reason: \(message)")
        }
    }
    return (existingManagers,unassignedProgrammers)
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
private func buildProgrammers(numNoviceProgrammersNeeded:Int, experienceStream:TriangularDistributionStream)->[Employee]{
    if numNoviceProgrammersNeeded == 0 {
        return [Employee]()
    }
    let aHireDate = randomHireDate()
    var aYearsExperience = UInt8(experienceStream.next()*10)
    if aYearsExperience > UInt8(aHireDate.distance(to: Date())/oneYear){
        aYearsExperience = UInt8(aHireDate.distance(to: Date())/oneYear)
    }
    return [Employee(name: randomName(), hireDate: aHireDate, yearsExperience: aYearsExperience, type: .programmer)] + buildProgrammers(numNoviceProgrammersNeeded: numNoviceProgrammersNeeded-1, experienceStream: experienceStream)
}

/// This function instantiates a series of Manager instances according to the problem requirement. Each
/// Manager instance has no managees.
/// - Parameter numManagersNeeded: the remaining number of managers that need to be instantiated
/// - Returns: a list of instantiated managers with no managees
/// - Complexity: O(n)
///
/// This function is module private.
private func buildManagers(numManagersNeeded:Int)->[Manager]{
    if numManagersNeeded == 0{
        return [Manager]()
    }
    let aManager = Manager(name: randomName(), hireDate: Date(), type: .devLead, yearsExperience: UInt8.random(in: 0..<22)){ (currentManagees:[Employee])->Bool in
        return currentManagees.count <= 15
    }
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
private func assignExperiencedEmployee(employees:[Employee],managers:[Manager]) -> [Manager] {
    if employees.count == 0 {
        return managers
    }
    var mutableEmployees = employees
    var mutableManagers = managers
    let employeeHead = mutableEmployees.remove(at: 0)
    let managerHead = mutableManagers.remove(at: 0)
    let _ = add(managee: employeeHead, to: managerHead)
    return [managerHead] + assignExperiencedEmployee(employees: mutableEmployees, managers: mutableManagers)
}


/// Generates a random string of six characters used as a name.
/// This function is module private.
/// - Returns: a simulated name. The name need not make sense in any language.
private func randomName() -> String {
  let letters = "abcdefghijklmnopqrstuvwxyz"
  return String((0..<7).map{ _ in letters.randomElement()! })
}


/// Generates a Date used as a determinator for if an employee is a novice or experienced.
/// This function is module private.
/// - Returns: a simulated hire date in the range 0 to 10 years
/// - Complexity: O(1)
private func randomHireDate() -> Date{
    return Date().advanced(by: -oneYear*Double(Int.random(in: 0..<10)))
}
