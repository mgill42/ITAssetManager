//
//  EditStaffView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 27/10/2022.
//

import SwiftUI

struct UserEditView: View {
    let staff: Staff
    
    @EnvironmentObject var dataController: DataController

    @State private var firstName: String
    @State private var lastName: String
    @State private var department: String
    @State private var devices: [Device]
    
    
    
    init(staff: Staff) {
        self.staff = staff
        _firstName = State(wrappedValue: staff.staffFirstName)
        _lastName = State(wrappedValue: staff.staffLastName)
        _department = State(wrappedValue: staff.staffDepartment)
        _devices = State(wrappedValue: staff.staffDevices)
    }
    
    var body: some View {
        Form {
            Section("Details") {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                Picker("Department", selection: $department) {
                    ForEach(Staff.departments, id: \.self) { department in
                        Text(department)
                    }
                }
            }
        }
        .navigationTitle("Edit Staff")
        .onDisappear(perform: dataController.save)
        .onChange(of: firstName) { _ in update()}
        .onChange(of: lastName) { _ in update()}
        .onChange(of: department) { _ in update()}
   
    }
    
    func update() {
        print("updated")
        staff.firstName = firstName
        staff.lastName = lastName
        staff.department = department
    }
    
   
}

struct StaffEditView_Previews: PreviewProvider {
    static let dataController = DataController()

    static var previews: some View {
        NavigationStack {
            UserEditView(staff: .example)
                .environmentObject(dataController)
        }
    }
}
