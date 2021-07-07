//
//  model_elements.swift
//  week04_task1
//
//

import Foundation

//For MedicationContainer to be stored in a set, it must be Hashable
/// A base class for all types of medications tracked in the pharmeceutical model.
///
///Instances of this class have a non-unique name, expiration date and NDC package code. Each instance has a unique identifier.
///
class MedicationContainer:Hashable {
    //a class variable that counts how many instances have been created
    static var counter = 0
    //a String formatted as "\[5 digits\]-\[3 digits\]-\[2 digits\] that is the NDC code for the medication
    let ndcPackageCode:String
    let name:String
    let expirationDate:Date
    //a unique identifier for each instance
    let id:String
    
    init(ndcPackageCode:String, name:String, expirationDate:Date) {
        self.ndcPackageCode = ndcPackageCode
        self.name = name
        self.expirationDate = expirationDate
        //I've added the counter here to make the UUID more unique than the international standard.
        id = UUID().uuidString
    }
    
    //Conformance to the equitable protocol creation of a comparitor operator
    static func == (lhs: MedicationContainer, rhs: MedicationContainer) -> Bool {
        lhs.name == rhs.name && lhs.expirationDate == rhs.expirationDate
    }
    
    //conformance to the Hashable protocol
    //https://medium.com/@amitsingh_14780/hashable-protocol-in-swift-650a7d9d9aeb
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// A liquid medication class that is a medication container
///
///Instances of this class have non-unique volumes, concentrations, and concentration units descriptions.
///
class LiquidMedicationContainer: MedicationContainer {
    let volume:Double
    let concentration:Int
    let concentrationUnits:String
    
    init(ndcPackageCode:String, name: String, expirationDate: Date, volume:Double, concentration:Int, concentrationUnits:String) {
        self.volume = volume
        self.concentration = concentration
        self.concentrationUnits = concentrationUnits
        super.init(ndcPackageCode:ndcPackageCode, name: name, expirationDate: expirationDate)
    }
}

/// A tablet medication class that is a medication container.
///
///Instances of this class have non-unique pill counts, potencies, and potency units.
///
class TabletMedicationContainer: MedicationContainer{
    let pillCount:Int
    let potency:Double
    let potencyUnits:String
    
    init(ndcPackageCode:String,  name: String, expirationDate: Date, pillCount:Int, potency:Double, potencyUnits:String) {
        self.pillCount = pillCount
        self.potency = potency
        self.potencyUnits = potencyUnits
        super.init(ndcPackageCode:ndcPackageCode, name: name, expirationDate: expirationDate)
    }
}
