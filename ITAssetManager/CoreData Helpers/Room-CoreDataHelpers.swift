//
//  Room-CoreDataHelpers.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 10/11/2022.
//

import SwiftUI

extension Rooms {
    
    var roomroomNumber: String {
        roomNumber ?? ""
    }

    var roomBuilding: String {
        building ?? ""
    }
    var roomStaff: [Staff] {
        let staffArray = staff?.allObjects as? [Staff] ?? []
        return staffArray
    }
    
    var roomDevices: [Device] {
        let deviceArray = devices?.allObjects as? [Device] ?? []
        return deviceArray
    }
    
    static var example: Rooms {
        let controller = DataController(inMemory: true)
        
        let viewContext = controller.container.viewContext
        
        let room = Rooms(context: viewContext)
        room.roomNumber = "Example Room"
        room.building = "Example Building"
        
        return room
    }
}

