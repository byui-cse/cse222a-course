//
//  control.swift
//  week03_task_3
//
//

import Foundation

/// a variable used to make computation in the functions below more readable
let oneYear:Double = 365*24*60*60

/// This function evaluates a managee and a manager to make sure that
/// there is no conflict that would keep the managee from being assigned
/// to the manager. If there is not conflict, the managee becomes part of the
/// managees for the manager. If there is a conflict the assignment is not made.
/// - Parameters:
///   - managee: the Employee to assign to the Manager
///   - aManager: the Manager to which the employee is to be assigned.
/// - Returns: (true,AssignmentError.none) if the assignment occured. (false,AssignmentError.errorDescription) if the assignement could not be made.
/// - Complexity: O(n)
func add(managee:Employee, to aManager:Manager) -> (AssignmentError, Manager) {
    var mutableManager = aManager
    if aManager.managees.count > 15 {
        return (.violatedAddManageCriteria, aManager)
    }
    //No need to worry about leap years and such. This is close enough to meet the business' criteria.
    let fiveYears:Double = 5*365*24*60*60
    let oneYear:Double = 365*24*60*60
    
    //set the initial values for the return values
    var shouldAppendManagee = true
    var message = AssignmentError.none
    
    let experiencedManagees = mutableManager.managees.filter{
        return Date().timeIntervalSince($0.hireDate) >= oneYear && $0.yearsExperience > 5
    }
    
    //apply rules from problem description
    if Date().timeIntervalSince(managee.hireDate) < fiveYears &&
        experiencedManagees.count == 0 {
        
        if mutableManager.managees.count == 2 {
            shouldAppendManagee = false
            message = .noExperiecedManagee
        }
        else{
        }
    }
    if shouldAppendManagee {
        mutableManager.managees.append(managee)
    }
    
    return (message, mutableManager)
}


/// Generates a list of hires that need to be made to meet the
/// criteria indicated by human resources.
/// - Parameter devLeads: a list of current Managers. Each manager has
/// a list of programmers they are currently managing.
/// - Returns: a list of programmer types and count required to meet the HR criteria
/// - Complexity: O(n)
func generateNeededHires(devLeads:[Manager])->[(String,Int)]{
    
    
    let numDevLeads = devLeads.count
    
    //produces a list of all employees that are assigned as managees of some manager
    let managees = devLeads.reduce([Employee]()){(programmerAccumulator, manager) in
        var mutableVersion = programmerAccumulator
        mutableVersion.append(contentsOf: manager.managees)
        return mutableVersion
    }
    
    //produces two lists, experienced and novice, of programmers from the full list of managees.
    let (experiencedEmployees,noviceEmployees) = managees.reduce(([Employee](),[Employee]())){(programmerTuple,employee) in
        //mutable versions of the lists passed in to the closure
        var mutableExperienceds = programmerTuple.0
        var mutableNovices = programmerTuple.1
        if employee.yearsExperience > 5 && Date().timeIntervalSince(employee.hireDate) >= oneYear {
            mutableExperienceds.append(employee)
        }
        else{
            mutableNovices.append(employee)
        }
        return (mutableExperienceds,mutableNovices)
    }
    //calculate the needed programmers by type
    let numExperiencedNeeded = numDevLeads - experiencedEmployees.count
    let numRemainingProgrammersNeeded = numDevLeads*3 - experiencedEmployees.count - noviceEmployees.count
    
    return [("Experienced",numExperiencedNeeded),("Novice",numRemainingProgrammersNeeded)]
}
