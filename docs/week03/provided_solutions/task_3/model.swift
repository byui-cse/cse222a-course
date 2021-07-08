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
}


/// A base-class that models all employees at our company.
struct Employee {
    //set the default values of the properties
    var name:String = ""
    var hireDate:Date = Date.distantPast
    var yearsExperience:UInt8 = UInt8.max
    let id = UUID().uuidString
    var type:EmployeeType = EmployeeType.unassigned
    
    /// Used to instantiate an instance of the Employee class
    /// - Parameters:
    ///   - name: the employee's name
    ///   - hireDate: the date they began working for our company
    ///   - type: a selection from the EmployeeType enumeration
    ///   - yearsExperience: the number of years the employee has been functioning in this role in the industry
    /// - Complexity: O(1)
    init(name:String, hireDate:Date, yearsExperience:UInt8, type:EmployeeType) {
        self.name = name
        self.hireDate = hireDate
        self.yearsExperience = yearsExperience
        self.type = type
    }
    
    /// Used to instantiate an instance of the Employee class with
    /// default paramters.
    init(){}
}

/// A class used to represent a manager and their managees.
struct Manager{
    /*
     * These are examples of Swift stored properties.
     */
    var employeeData:Employee = Employee()
    var managees:[Employee] = []
    
    /*
     * This is an example of an init function that initializes instances of both this class and the super class.
     */
    /// Used to instantiate an instance of the Manager class.
    /// - Parameters:
    ///   - name: the employee's name
    ///   - hireDate: the date they began working for our company
    ///   - type: a selection from the EmployeeType enumeration
    ///   - yearsExperience: the number of years the employee has been functioning in this role in the industry
    ///     can add additional managees based on the rules from HR.
    /// - Complexity: O(1)
    init(name:String, hireDate:Date,type:EmployeeType, yearsExperience:UInt8) {
        
        employeeData.name = name
        employeeData.hireDate = hireDate
        employeeData.yearsExperience = yearsExperience
        employeeData.type = type
    }
}
