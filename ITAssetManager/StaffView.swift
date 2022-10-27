//
//  StaffView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 24/10/2022.
//

import SwiftUI

struct StaffView: View {
    static let tag: String? = "Staff"
    let staff: FetchRequest<Staff>
    
    @EnvironmentObject var dataController: DataController
    
    init() {
        staff = FetchRequest<Staff>(entity: Staff.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Staff.firstName, ascending: true)
        ])
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(staff.wrappedValue) { staff in
                    NavigationLink(destination: StaffEditView(staff: staff)) {
                        Text(staff.staffFirstName)
                    }
                }
            }
            .navigationTitle("Staff")
            .toolbar {
                Button("Add Data") {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }
            }
        }
        
    }
}

struct StaffView_Previews: PreviewProvider {
    static var previews: some View {
        StaffView()
    }
}







