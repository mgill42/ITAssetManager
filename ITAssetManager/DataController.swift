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
        let viewContext = dataController.container.viewContext
        
        return dataController
    }()

    
    func createSampleData() throws
    
    
    {
        
        let viewContext = container.viewContext
        
        for i in 1...5 {
            let staff = Staff(context: viewContext)
            staff.id = UUID()
            staff.firstName = "First Name \(i)"
            staff.lastName = "Last Name \(i)"
            staff.department = Department.departments.randomElement()
            
            for j in 1...10 {
                let device = Device(context: viewContext)
                device.archived = Bool.random()
                device.assetTag = "UG\(Int.random(in: 10000...99999))"
                device.mac = "MAC \(j)"
                device.manufacturer = "Manufacturer \(j)"
                device.model = "Model \(j)"
                device.notes = "Notes \(j)"
                device.purchaseDate = Date.now
                device.serialNumber = "Serial Number \(j)"
                device.type = Department.departments.randomElement()
                device.warrantyStart = Date.now
                device.warrantyEnd = Date.now
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


