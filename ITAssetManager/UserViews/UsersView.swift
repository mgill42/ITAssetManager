//
//  StaffView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 24/10/2022.
//

import SwiftUI

struct UsersView: View {
    @EnvironmentObject var dataController: DataController

    @State private var searchText = ""
    @State private var addStaff = false
    @State var createdStaff: Staff?
    @State private var showFilter = false
    @State private var filterBy = ""

    
    static let tag: String? = "Users"
    let staff: FetchRequest<Staff>
 
    
    init() {
        staff = FetchRequest<Staff>(entity: Staff.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Staff.firstName, ascending: true)
        ], animation: .default)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults) { staff in
                    NavigationLink(destination: UserDetailView(staff: staff)) {
                        Text("\(staff.staffFirstName) \(staff.staffLastName)")
                            .swipeActions(allowsFullSwipe: false) {
                                SwipeButtonsNoArchiveStaff(staff: staff)
                            }
                    }
                }
            }
            .searchable(text: $searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            .navigationTitle("Users")
            .sheet(isPresented: $showFilter) {
                NavigationStack {
                    DepartmentSheet(filterBy: $filterBy)
                }
            }
            .toolbar {

                ToolbarItem {
                    Button("Add Data") {
                        dataController.deleteAll()
                        try? dataController.createSampleData()
                    }
                }
                
                ToolbarItem {
                    NavigationLink(destination: UserAddView()) {
                        Label("Add Staff", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showFilter = true
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease")
                    }
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
    
    func deleteStaff(at offsets: IndexSet) {
        for offset in offsets {
            let staff = searchResults[offset]
            dataController.delete(staff)
        }
        dataController.save()
    }
}

struct StaffView_Previews: PreviewProvider {
    static var previews: some View {
        let dataController = DataController.preview

        UsersView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}







