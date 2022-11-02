//
//  StaffView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 24/10/2022.
//

import SwiftUI

struct StaffView: View {
    @State private var searchText = ""
    
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
                ForEach(searchResults) { staff in
                    NavigationLink(destination: StaffDetailView(staff: staff)) {
                        Text("\(staff.staffFirstName) \(staff.staffLastName)")
                    }
                }
            }
            .searchable(text: $searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            .navigationTitle("Staff")
            .toolbar {
                Button("Add Data") {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }
                Button("Clear Data") {
                    dataController.deleteAll()
                }
            }
        }
        
    }
    
    var searchResults: [Staff] {
        if searchText.isEmpty {
            return Array(staff.wrappedValue)
        } else {
            return Array(staff.wrappedValue).filter {"\($0.staffFirstName) \($0.staffLastName)".localizedCaseInsensitiveContains(searchText)}
        }
    }
}

struct StaffView_Previews: PreviewProvider {
    static var previews: some View {
        let dataController = DataController.preview
        
        StaffView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}







