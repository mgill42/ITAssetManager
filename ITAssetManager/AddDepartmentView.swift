//
//  AddDepartmentView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 09/11/2022.
//

import SwiftUI

struct AddDepartmentView: View {
    @EnvironmentObject var dataController: DataController
    @FocusState private var textActive: Bool
    
    @State private var newDepartment = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Enter Department", text: $newDepartment)
                    .focused($textActive)
                 
                Button("Add Department") {
                    dataController.departments.append(newDepartment)
                    newDepartment = ""
                }.disabled(newDepartment.isEmpty)
            }
            
            Section("List of Department") {
                List {
                    ForEach(dataController.departments, id: \.self) {
                        Text($0)
                    }
                    .onDelete(perform: delete)
                }
            }
        }
        .navigationTitle("Add Department")
        .interactiveDismissDisabled()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { textActive = false }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        dataController.departments.remove(atOffsets: offsets)
    }
}

struct AddDepartmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddDepartmentView()
    }
}
