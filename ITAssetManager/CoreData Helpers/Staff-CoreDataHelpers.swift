//
//  Staff-CoreDataHelpers.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 25/10/2022.
//

import SwiftUI

extension Staff {
    static let departments = ["DEP1", "DEP2", "DEP3", "DEP4"]

    
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
    
    
    static var example: Staff {
        let controller = DataController(inMemory: true)
        
        let viewContext = controller.container.viewContext
        
        let staff = Staff(context: viewContext)
        staff.id = UUID()
        staff.firstName = "Example Staff First Name"
        staff.lastName = "Example Staff Last Name"
        staff.department = "Example Department"
        
        return staff
    }
}
