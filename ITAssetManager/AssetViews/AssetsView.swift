//
//  AssetsView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 24/10/2022.
//

import SwiftUI

struct AssetsView: View {
    
    @EnvironmentObject var dataController: DataController

    static let archivedTag: String? = "Archived"
    static let assetsTag: String? = "Assets"
    
    @State private var searchText = ""
    @State private var filterBy = ""
    @State private var showFilter = false
  
    let devices: FetchRequest<Device>
    let showArchived: Bool
    
    init(showArchived: Bool) {
        self.showArchived = showArchived
        
        devices = FetchRequest<Device>(entity: Device.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Device.purchaseDate, ascending: false)
        ], predicate: NSPredicate(format: "archived = %d", showArchived), animation: .default)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults) { device in
                    if filterBy == "" {
                        NavigationLink(destination: AssetDetailView(device: device)) {
                            Text(device.deviceAssetTag)
                                .swipeActions(allowsFullSwipe: false) {
                                    SwipeButtons(device: device)
                                }
                        }
                    } else {
                        if device.deviceType == filterBy {
                            NavigationLink(destination: AssetDetailView(device: device)) {
                                Text(device.deviceAssetTag)
                                    .swipeActions(allowsFullSwipe: false) {
                                        SwipeButtons(device: device)
                                    }
                            }
                        }
                    }
                }
                
            }
            .searchable(text: $searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            .navigationTitle(showArchived ? "\(filterBy) Archived Assets" : "\(filterBy) Assets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newAsset = Device(context: dataController.container.viewContext)
                        newAsset.assetTag = "New Asset"
                        newAsset.purchaseDate = Date()
                        newAsset.archived = false
                    } label: {
                        Label("Add Asset", systemImage: "plus")
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
            .sheet(isPresented: $showFilter) {
                NavigationStack {
                    CategorySheet(filterBy: $filterBy)
                }
            }
        }
    }
    
    
    var searchResults: [Device] {
        if searchText.isEmpty {
            return Array(devices.wrappedValue)
        } else {
            return Array(devices.wrappedValue)
                .filter {$0.deviceAssetTag.localizedCaseInsensitiveContains(searchText)}
                //.filter {$0.deviceType == filterBy }
        }
    }
    
    func deleteDevice(at offsets: IndexSet) {
        for offset in offsets {
            let device = searchResults[offset]
            dataController.delete(device)
        }
        dataController.save()
    }
}

struct AssetsView_Previews: PreviewProvider {
    static var previews: some View {
        let dataController = DataController.preview
        
        AssetsView(showArchived: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
