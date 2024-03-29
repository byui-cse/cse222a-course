//
//  model.swift
//  week03_task_1
//
//
import Foundation

enum EmployeeType {
    case programmer
    case devLead
}

enum AssignmentError {
    case none
    case violatedAddManageCriteria
    case tooFewManagees
    case noExperiecedManagee
    case noManagers
}

/// A base-class that models all employees at our company.
class Employee {
    var name: String
    let hireDate: Date
    var yearsExperience: UInt8
    let id = UUID().uuidString
    let type: EmployeeType

    /// Used to instantiate an instance of the Employee clas
    /// - Parameters:
    ///   - name: the employee's name
    ///   - hireDate: the date they began working for our company
    ///   - type: a selection from the EmployeeType enumeration
    ///   - yearsExperience: the number of years the employee has been functioning in this role in the industry
    /// - Complexity: O(1)
    init(name: String, hireDate: Date, yearsExperience: UInt8, type: EmployeeType) {
        self.name = name
        self.hireDate = hireDate
        self.yearsExperience = yearsExperience
        self.type = type
    }
}

/// A class used to represent a manager and their managees.
class Manager: Employee {
    /*
     * These are examples of Swift stored properties.
     */
    var managees: [Employee] = []

    /*
     * This is an example of an init function that initializes instances of both this class and the super class.
     */
    /// Used to instantiate an instance of the Manager class.
    /// - Parameters:
    ///   - name: the employee's name
    ///   - hireDate: the date they began working for our company
    ///   - type: a selection from the EmployeeType enumeration
    ///   - yearsExperience: the number of years the employee has been functioning in this role in the industry
    /// - Complexity: O(1)
    init(name: String, hireDate: Date, type: EmployeeType, yearsExperience: UInt8) {
        super.init(name: name, hireDate: hireDate, yearsExperience: yearsExperience, type: type)
    }
}
