//
//  FilterSheet.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 06/11/2022.
//

import SwiftUI

struct CategorySheet: View {
  
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
   
    @Binding var filterBy: String
  
    var body: some View {
   
        Form {
            Picker("Filter", selection: $filterBy) {
                Text("No Filter").tag("")
                ForEach(dataController.categories, id: \.self) {
                    Text($0)
                 
                }
            }
            .pickerStyle(.inline)
         
        }
        .navigationTitle("Categories")
        .toolbar {
            NavigationLink {
                AddCatergoryView()
            } label: {
                Label("Add Category", systemImage: "plus")
            }
        }
        
    }
    
   
}

struct FilterSheet_Previews: PreviewProvider {
    static var previews: some View {
        CategorySheet(filterBy: .constant(""))
            .environmentObject(DataController(inMemory: true))
    }
}
