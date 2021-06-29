//
//  main.swift
//  week03_task_2
//
//

import Foundation

/*
 * This is the view code for the code driver app
 */

//generating the data to drive the classes created and the generateNeededHires function
let (managerData,unassignedProgrammers) = generateData(numManagersNeeded: 53, numProgrammersNeeded: 123)

let numManagees = managerData.reduce(0){(accumulator,aManager) in
    accumulator + aManager.managees.count
}

let needs = generateNeededHires(devLeads: managerData)

print("\n\nResults:")
print("\tProgramers Not Yet Assigned: \(unassignedProgrammers.count)")
print("\tNeeded Assignments: \(needs)")






