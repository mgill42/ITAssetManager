//
//  DataController.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 22/10/2022.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    // loads and manages core data instances, synronises to iCloud.
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Model")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")    //store data in RAM. Used for previews.
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatel error loading store:  \(error.localizedDescription)")
            }
        }
    }
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatel error creating preview: \(error.localizedDescription)")
        }
 
        
        return dataController
    }()

    
    func createSampleData() throws {
        
        let viewContext = container.viewContext
        
        for _ in 1...100 {
            let staff = Staff(context: viewContext)
            staff.id = UUID()
            staff.firstName = DummyData.firstNames.randomElement()
            staff.lastName = DummyData.lastNames.randomElement()
            staff.department = Device.departments.randomElement()
            
            for _ in 1...Int.random(in: 1...3) {
                let device = Device(context: viewContext)
                device.archived = Bool.random()
                device.assetTag = "UG\(Int.random(in: 10000...99999))"
                device.mac = DummyData.macAddresses.randomElement()
                device.manufacturer = DummyData.manufacturers.randomElement()
                device.model = DummyData.models.randomElement()
                device.notes = DummyData.notes.randomElement()
                device.serialNumber = DummyData.serialNumber.randomElement()
                device.purchaseDate = Date()
                device.type = Device.types.randomElement()
                device.hasWarranty = Bool.random()
                device.warrantyStart = Date()
                device.warrantyEnd = Date()
                device.staff = staff
            }
        }
            
        try viewContext.save()
    }
        
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    func deleteAll() {
        // find all items
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Device.fetchRequest()
        // convert to be a delete request
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        // run delete request
        _ = try? container.viewContext.execute(batchDeleteRequest1)
        

        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = Staff.fetchRequest()
        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        _ = try? container.viewContext.execute(batchDeleteRequest2)
    }
}


