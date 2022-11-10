//
//  AddCatergoryView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 08/11/2022.
//

import SwiftUI

struct AddCatergoryView: View {
    @EnvironmentObject var dataController: DataController
    @FocusState private var textActive: Bool
    
    @State private var newCategory = ""
    
    
    var body: some View {
        Form {
            Section {
                TextField("Enter Category", text: $newCategory)
                    .focused($textActive)
                 
                Button("Add Category") {
                    dataController.categories.append(newCategory)
                    newCategory = ""
                }.disabled(newCategory.isEmpty)
            }
            
            Section("List of Categories") {
                List {
                    ForEach(dataController.categories, id: \.self) {
                        Text($0)
                    }
                    .onDelete(perform: delete)
                }
            }
        }
        .navigationTitle("Add Category")
        .interactiveDismissDisabled()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { textActive = false }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        dataController.categories.remove(atOffsets: offsets)
    }
}

struct AddCatergoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCatergoryView()
    }
}
