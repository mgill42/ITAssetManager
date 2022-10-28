//
//  Staff-CoreDataHelpers.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 25/10/2022.
//

import SwiftUI

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
    
    
    static var example: Staff {
        let controller = DataController(inMemory: true)
        
        let viewContext = controller.container.viewContext
        
        let staff = Staff(context: viewContext)
        staff.id = UUID()
        staff.firstName = DummyData.firstNames.randomElement()
        staff.lastName = DummyData.lastNames.randomElement()
        staff.department = Department.departments.randomElement()
        
        return staff
    }
    
   
    
    
}
