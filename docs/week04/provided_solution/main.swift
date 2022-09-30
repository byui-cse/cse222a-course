//
//  main.swift
//  week04_task1
//
//

/*
 * Please remember that this is NOT the code you will have written. It is one way of
 * accomplishing the task. This example is available for you to learn from, not to compare
 * against your solution to see if you 'got it right.'
 *
 * You will probably see some things you haven't read about or seen. Take a few of them as
 * things you can learn more about.
 */

import Foundation

let daysToSeconds: Double = 24 * 60 * 60

/*
 * Here are some integration tests. These are NOT unit tests.
 */

/*
 * These tests are not a complete set. They are examples of how to exercise
 * code. An industrial grade set would include other tests of the interctions
 * between the functions as well as detailed tests of the functions without
 * dependencies on the other functions (unit tests).
 */

/*
 * Testing add function in prepraration for testing the other functions.
 */
print("TESTING ADD FUNCTION.")
var testingSet = Set<TabletMedicationContainer>()

/*
 * Make sure the 'happy path' works correctly.
 */
print("\tTesting Happy Path")
for dayOffset in 0 ..< 30 {
    testingSet.insert(
        TabletMedicationContainer(ndcPackageCode: "12345-678-90", name: "Cures-All", expirationDate: Date(timeIntervalSinceNow: (100.0 + Double(dayOffset)) * daysToSeconds), pillCount: 500, potency: 3.5, potencyUnits: "mg")
    )
}

var (succeeded, message) = add(expectedNdcPackageCode: "12345-678-90", containersToAdd: testingSet)

if succeeded != true || message != StockingMessage.success {
    print("\t\tFAILED: Expected (true,success). Got (\(succeeded),\(message)).")
} else {
    print("\t\tPassed")
}

print("\tTesting Add Empty Set")
(succeeded, message) = add(expectedNdcPackageCode: "12345-678-90", containersToAdd: Set<MedicationContainer>())

if succeeded != false || message != StockingMessage.emptyContainerSet {
    print("\t\tFAILED: Expected (false,emptyContainerSet). Got (\(succeeded),\(message)).")
} else {
    print("\t\tPassed")
}

print("\tTesting Mixed Package Codes")
testingSet.removeAll()

testingSet.insert(
    TabletMedicationContainer(ndcPackageCode: "12345-678-90", name: "Cures-All", expirationDate: Date(timeIntervalSinceNow: 100 * daysToSeconds), pillCount: 500, potency: 3.5, potencyUnits: "mg")
)
testingSet.insert(
    TabletMedicationContainer(ndcPackageCode: "12333-333-99", name: "Stuff", expirationDate: Date(timeIntervalSinceNow: 10 * daysToSeconds), pillCount: 500, potency: 0.5, potencyUnits: "mg")
)

(succeeded, message) = add(expectedNdcPackageCode: "12345-678-90", containersToAdd: testingSet)

if succeeded != false || message != StockingMessage.mixedNdcCodes {
    print("\t\tFAILED: Expected (false,mixedNdcCodes). Got (\(succeeded),\(message)).")
} else {
    print("\t\tPassed")
}

print("\tTesting Bad Declared NDC Code")

testingSet.removeAll()

testingSet.insert(
    TabletMedicationContainer(ndcPackageCode: "12345-678-90", name: "Cures-All", expirationDate: Date(timeIntervalSinceNow: 100 * daysToSeconds), pillCount: 500, potency: 3.5, potencyUnits: "mg")
)

(succeeded, message) = add(expectedNdcPackageCode: "123", containersToAdd: testingSet)

if succeeded != false || message != StockingMessage.poorlyFormattedNdcCode {
    print("\t\tFAILED: Expected (false,poorlyFormattedNdcCode). Got (\(succeeded),\(message)).")
} else {
    print("\t\tPassed")
}

var setupComplete = 0

/*
 * This test is done in conjunction with the add function.
 */
print("TESTING CURRENTSTOCKOF FUNCTION")
var stuffs = Set<TabletMedicationContainer>()
// setup so there are several different types of meds in the
for dayOffset in 0 ..< 30 {
    stuffs.insert(
        TabletMedicationContainer(ndcPackageCode: "12333-333-99", name: "Stuff", expirationDate: Date(timeIntervalSinceNow: Double(10 + dayOffset) * daysToSeconds), pillCount: 500, potency: 0.5, potencyUnits: "mg")
    )
}

(succeeded, message) = add(expectedNdcPackageCode: "12333-333-99", containersToAdd: stuffs)
if succeeded {
    setupComplete += 1
}

var others = Set<LiquidMedicationContainer>()
for dayOffset in 0 ..< 17 {
    others.insert(
        LiquidMedicationContainer(ndcPackageCode: "12333-344-19", name: "Other", expirationDate: Date(timeIntervalSinceNow: Double(5 + dayOffset) * daysToSeconds), volume: 500, concentration: 5, concentrationUnits: "mg/dl")
    )
}

(succeeded, message) = add(expectedNdcPackageCode: "12333-344-19", containersToAdd: others)
if succeeded {
    setupComplete += 1
}

var whats = Set<TabletMedicationContainer>()
for dayOffset in 0 ..< 111 {
    whats.insert(
        TabletMedicationContainer(ndcPackageCode: "22222-111-00", name: "What?", expirationDate: Date(timeIntervalSinceNow: Double(45 + dayOffset) * daysToSeconds), pillCount: 500, potency: 0.5, potencyUnits: "mg")
    )
}

(succeeded, message) = add(expectedNdcPackageCode: "22222-111-00", containersToAdd: whats)
if succeeded {
    setupComplete += 1
}

if setupComplete != 3 {
    print("FAILED: setup incomplete.")
}

print("\tTesting happy path")
var passed = true
var (found, medications) = currentStockOf(ndcPackageCode: "22222-111-00")
if let medications = medications {
    let differenceCount = whats.symmetricDifference(medications as! [TabletMedicationContainer]).count
    if found != .success || differenceCount != 0 {
        passed = false
        print("\t\tFAILED: Expected false, differenceCount = 0. Got (\(found),\(String(describing: differenceCount))).")
    }
}

if passed {
    print("\t\tPassed")
}

// reset for next test
passed = true
(found, medications) = currentStockOf(ndcPackageCode: "12333-344-19")
if let medications = medications {
    let differenceCount = others.symmetricDifference(medications as! [LiquidMedicationContainer]).count
    if found != .success || differenceCount != 0 {
        passed = false
        print("\t\tFAILED: Expected false, differenceCount = 0. Got (\(found),\(String(describing: differenceCount))).")
    }
} else {
    print("\t\tPassed")
}

// reset for next test
passed = true
(found, medications) = currentStockOf(ndcPackageCode: "12333-333-99")
if let medications = medications {
    let differenceCount = stuffs.symmetricDifference(medications as! [TabletMedicationContainer]).count
    if found != .success || differenceCount != 0 {
        passed = false
        print("\t\tFAILED: Expected false, differenceCount = 0. Got (\(found),\(String(describing: differenceCount))).")
    }
}

if passed {
    print("\t\tPassed")
}

print("Testing non-existing NDC code")
(found, medications) = currentStockOf(ndcPackageCode: "11111-222-33")
if found != .noSuchNdcCode || medications != nil {
    print("\t\tFAILED: Expected noSuchNdcCode, nil. Got (\(found),\(String(describing: medications?.count))).")
} else {
    print("\t\tpassed")
}

print("TESTING SOLD")

print("\tTesting happy path")

// selling whats
var (soldMessage, soldMedications) = sold(count: 5, of: "22222-111-00")
if soldMessage != .success || soldMedications?.count != 5 || soldMedications == nil ||
    !whats.isSuperset(of: soldMedications as! [TabletMedicationContainer])
{
    print("\t\tFAILED: Expected (success,Set<MedicationContainer>). Got (\(soldMessage),\(String(describing: soldMedications)).")
} else {
    print("\t\tpassed")
}

// selling stuffs
(soldMessage, soldMedications) = sold(count: 1, of: "12333-333-99")
if soldMessage != .success
    || soldMedications?.count != 1
    || soldMedications == nil
    || !stuffs.isSuperset(of: soldMedications as! [TabletMedicationContainer])
{
    print("\t\tFAILED: Expected (success,Set<MedicationContainer>). Got (\(soldMessage),\(String(describing: soldMedications)).")
} else {
    print("\t\tpassed")
}

// selling all of the others
(soldMessage, soldMedications) = sold(count: 17, of: "12333-344-19")
if soldMessage != .success
    || soldMedications?.count != 17
    || soldMedications == nil
    || !others.isSuperset(of: soldMedications as! [LiquidMedicationContainer])
{
    print("\t\tFAILED: Expected (success,Set<MedicationContainer>). Got (\(soldMessage),\(String(describing: soldMedications)).")
} else {
    print("\t\tpassed")
}

print("\tTesting no more left")
// trying to get more others when all have been sold
(soldMessage, soldMedications) = sold(count: 10, of: "12333-344-19")
if soldMessage != .insufficientStock {
    print("\t\tFAILED: Expected (insufficientStock,nil). Got (\(soldMessage),\(String(describing: soldMedications)).")
} else {
    print("\t\tpassed")
}

print("\tTesting bad NDC code")
(soldMessage, soldMedications) = sold(count: 10, of: "00000-111-222")
if soldMessage != .noSuchNdcCode {
    print("\t\tFAILED: Expected (noSuchNdcCode,nil). Got (\(soldMessage),\(String(describing: soldMedications)).")
} else {
    print("\t\tpassed")
}

print("\tTesting incorrectly formated NDC code")
(soldMessage, soldMedications) = sold(count: 10, of: "123")
if soldMessage != .poorlyFormattedNdcCode {
    print("\t\tFAILED: Expected (noSuchNdcCode,nil). Got (\(soldMessage),\(String(describing: soldMedications)).")
} else {
    print("\t\tpassed")
}
