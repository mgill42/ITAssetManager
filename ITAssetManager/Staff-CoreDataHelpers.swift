//
//  Staff-CoreDataHelpers.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 25/10/2022.
//

import Foundation

extension Staff {
    var staffFirstName: String {
        firstName ?? ""
    }
    
    var staffLastName: String {
        lastName ?? ""
    }
    
    var staffDepartment: String {
        department ?? ""
    }
    
    var staffDevices: [Device] {
        let deviceArray = devices?.allObjects as? [Device] ?? []
        return deviceArray
    }
    
    var example: Staff {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let staff = Staff(context: viewContext)
        staff.id = UUID()
        staff.firstName = "Example First Name"
        staff.lastName = "Example Last Name"
        staff.department = "Example Department"
        
        return staff
    }
    
   
    
    
}
