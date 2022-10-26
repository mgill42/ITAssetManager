//
//  Device-CoreDataHelpers.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 25/10/2022.
//

import Foundation

extension Device {
  
    var deviceAssetTag: String {
        assetTag ?? ""
    }
    
    var deviceMac: String {
        mac ?? ""
    }
    
    var deviceManufacturer: String {
        manufacturer ?? ""
    }
    
    var deviceModel: String {
        model ?? ""
    }
    
    var deviceNotes: String {
        notes ?? ""
    }
    
    var devicePurchaseDate: Date {
        purchaseDate ?? Date()
    }
    
    var deviceSerialNumber: String {
        serialNumber ?? ""
    }
    
    var deviceType: String {
        type ?? ""
    }
    
    var deviceWarrantyStart: Date {
        warrantyStart ?? Date()
    }
    
    var deviceWarrantyEnd: Date {
        warrantyEnd ?? Date()
    }
    
    static var example: Device {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let device = Device(context: viewContext)
        device.archived = false
        device.assetTag = "Example Asset Tag"
        device.mac = "Example Mac"
        device.manufacturer = "Example Manufacturer"
        device.model = "Example Model"
        device.notes = "Example Notes"
        device.purchaseDate = Date()
        device.serialNumber = "Example Serial Number"
        device.type = "Example Type"
        device.warrantyStart = Date()
        device.warrantyEnd = Date()
        
        return device
        
    }
    
}
