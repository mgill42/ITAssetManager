//
//  StaffAddView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 05/11/2022.
//

import SwiftUI

struct UserAddView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var userFirstName = ""
    @State var userLastName = ""
    @State var userDepartment = ""


    var body: some View {
        Form {
            Section("User Details") {
                TextField("First Name", text: $userFirstName)
                TextField("Last Name", text: $userLastName)
                Picker("Department", selection: $userDepartment) {
                    ForEach(Staff.departments, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Button("Add User") {
                let newUser = Staff(context: moc)
                newUser.firstName = userFirstName
                newUser.lastName = userLastName
                newUser.department = userDepartment
                dataController.save()
                dismiss()
            }
        }
        .navigationTitle("Add User")
    }
}

struct StaffAddView_Previews: PreviewProvider {
    static var previews: some View {
        UserAddView()
    }
}
