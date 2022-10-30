//
//  AssetsView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 24/10/2022.
//

import SwiftUI

struct AssetsView: View {
    @State private var searchText = ""
    
    
    static let archivedTag: String? = "Archived"
    static let assetsTag: String? = "Assets"
    
    let devices: FetchRequest<Device>
    let showArchived: Bool
    
    init(showArchived: Bool) {
        self.showArchived = showArchived
        
        devices = FetchRequest<Device>(entity: Device.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Device.assetTag, ascending: true)
        ], predicate: NSPredicate(format: "archived = %d", showArchived))
    }
    
    var body: some View {
        NavigationStack() {
            List {
                ForEach(searchResults) { device in
                    NavigationLink(destination: AssetDetailView(device: device)) {
                        Text(device.deviceAssetTag)
                    }
                }
            }
            .searchable(text: $searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            .navigationTitle(showArchived ? "Archived Assets" : "Assets")
        }
    }
    
    var searchResults: [Device] {
        if searchText.isEmpty {
            return Array(devices.wrappedValue)
        } else {
            return Array(devices.wrappedValue).filter {$0.deviceAssetTag.localizedCaseInsensitiveContains(searchText)}
        }
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
