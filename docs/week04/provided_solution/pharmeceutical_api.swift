//
//  pharmeceutical_api.swift
//  week04_task1
//
//

import Foundation


private var inStockMedications = [String:Set<MedicationContainer>]()


enum StockingMessage {
    case success
    case poorlyFormattedNdcCode
    case noSuchNdcCode
    case emptyContainerSet
    case mixedNdcCodes
    case invalidSaleCount
    case insufficientStock
}

//private funcs are not part of the published API.
private func isFormattedAsNDCCode(code:String)-> Bool{
    return code.range(of: #"\d{5}[-]\d{3}[-]\d{2}"#,
                                       options: .regularExpression) != nil
}

/// Adding liquid or tablet type medication containers requires an NDC package code be used.
/// The package code must be passed to the function as the first parameter to assure that
/// all medications being added are of the correct type. This 'double factor authentication'
/// type of behavior is used to decrease the probability of the wrong medications being sold
/// so as to avoid death or damaged health of those taking the medications sold.
/// - Parameters:
///   - expectedNdcPackageCode: a String formatted as "\[5 digits\]-\[3 digits\]-\[2 digits\] that is the NDC code for the medication
///   - containersToAdd: a set of MedicationContainers, Tablet or Liquid, that each have the same NDC code as the expectedNdcPackageCode parameter.
/// - Returns: (true, StockingMessage.success) when the addition succeeds or (false,StockingMessage) on failure. See StockingMessage for possible failure indicators.
/// - Complexity: O(n)
func add(expectedNdcPackageCode:String, containersToAdd:Set<MedicationContainer>) -> (Bool, StockingMessage) {
    guard let _ = containersToAdd.first?.ndcPackageCode else {
        return (false,.emptyContainerSet)
    }
    guard isFormattedAsNDCCode(code: expectedNdcPackageCode) else {
        return (false,.poorlyFormattedNdcCode)
    }
    let matchingContainers = containersToAdd.filter{
        $0.id == expectedNdcPackageCode
    }
    
    guard matchingContainers.count == containersToAdd.count else {
        return (false,.mixedNdcCodes)
    }
    if let existingMedications = inStockMedications[expectedNdcPackageCode]{
        inStockMedications[expectedNdcPackageCode] = existingMedications.union(containersToAdd)
    }
    else{
        inStockMedications[expectedNdcPackageCode] = containersToAdd
    }
    return (true,.success)
}

/// When medications are sold, the tracking system must be updated. After the sale is confirmed, this function removes the stock from the system.
/// - Parameters:
///   - count: the number of containers sold
///   - ndcPackageCode: a String formatted as "\[5 digits\]-\[3 digits\]-\[2 digits\] that is the NDC code for the medication
/// - Returns: (StockingMessage.success,\[MedicationContainer]) on success, (StockingMessage,nil) otherwise. See StockingMessage for possible failure indicators.
/// - Complexity: O(n)
func sold(count:Int, of ndcPackageCode:String) -> (StockingMessage,[MedicationContainer]?) {
    guard count > 0 else {
        return (.invalidSaleCount,nil)
    }
    guard isFormattedAsNDCCode(code: ndcPackageCode) else {
        return (.poorlyFormattedNdcCode,nil)
    }
    guard let existingMedications = inStockMedications[ndcPackageCode] else {
        return (.noSuchNdcCode,nil)
    }
    guard existingMedications.count >= count else {
        return (.insufficientStock,nil)
    }
    let sortedMedications:Array<MedicationContainer> = existingMedications.sorted{
        $0.expirationDate < $1.expirationDate
    }
    let containersSold = Array(sortedMedications[0..<count])
    inStockMedications[ndcPackageCode]?.subtract(containersSold)
    return (.success, containersSold)
}

/// The current containers of medication for a specific NDC code are returned as a set so as
/// to easily allow set functions to be applied to the results.
/// - Parameter ndcPackageCode: a String formatted as "\[5 digits\]-\[3 digits\]-\[2 digits\] that is the NDC code for the medication
/// - Returns: (StockingMessage.success,\[MedicationContainer\]) on success (StockingMessage,nil) otherwise. See StockingMessage for possible failure indicators.
/// - Complexity: O(n)
func currentStockOf(ndcPackageCode:String) -> (StockingMessage,[MedicationContainer]?) {
    guard isFormattedAsNDCCode(code: ndcPackageCode) else {
        return (.poorlyFormattedNdcCode,nil)
    }
    guard let existingMedications = inStockMedications[ndcPackageCode] else {
        return (.noSuchNdcCode,nil)
    }
    var existingMedsArray = Array<MedicationContainer>(existingMedications)
    existingMedsArray.sort{
        $0.expirationDate < $1.expirationDate
    }
    return (.success,existingMedsArray)
}



