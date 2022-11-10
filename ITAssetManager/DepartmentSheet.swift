//
//  DepartmentSheet.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 09/11/2022.
//

import SwiftUI

struct DepartmentSheet: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
   
    @Binding var filterBy: String
    
    var body: some View {
        Form {
            Picker("Filter", selection: $filterBy) {
                Text("No Filter").tag("")
                ForEach(dataController.departments, id: \.self) {
                    Text($0)
                    
                }
            }
            .pickerStyle(.inline)
         
        }
        .navigationTitle("Departments")
        .toolbar {
            NavigationLink {
                AddDepartmentView()
            } label: {
                Label("Add Category", systemImage: "plus")
            }
        }
    }
}

struct DepartmentSheet_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentSheet(filterBy: .constant(""))
            .environmentObject(DataController(inMemory: true))
    }
}
