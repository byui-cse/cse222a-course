//
//  model.swift
//  week03_task_3
//
//
import Foundation

enum EmployeeType {
    case programmer
    case devLead
    case unassigned
}

enum AssignmentError {
    case none
    case violatedAddManageCriteria
    case tooFewManagees
    case noExperiecedManagee
    case noManagers
}

protocol EmployeeProtocol {
    var name: String { get set }
    var hireDate: Date  { get set }
    var yearsExperience: UInt8 { get set }
    var id: String { get set }
    var type: EmployeeType { get set }
}
/// A base-class that models all employees at our company.
struct Employee: EmployeeProtocol {
    // set the default values of the properties
    var name: String = ""
    var hireDate: Date = .distantPast
    var yearsExperience: UInt8 = .max
    var id = UUID().uuidString
    var type: EmployeeType = .unassigned

    /// Used to instantiate an instance of the Employee class
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

    /// Used to instantiate an instance of the Employee class with
    /// default paramters.
    init() {}
}

/// A class used to represent a manager and their managees.
struct Manager: EmployeeProtocol {
    /*
     * These are examples of Swift stored properties.
     */
    var name: String = ""
    var hireDate: Date = .distantPast
    var yearsExperience: UInt8 = .max
    var id = UUID().uuidString
    var type: EmployeeType = .unassigned

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
    init(name: String, hireDate: Date, yearsExperience: UInt8, type: EmployeeType) {
        self.name = name
        self.hireDate = hireDate
        self.yearsExperience = yearsExperience
        self.type = type
    }
}
