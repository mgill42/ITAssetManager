//
//  AssetsView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 24/10/2022.
//

import SwiftUI

struct AssetsView: View {
    let devices: FetchRequest<Device>
    
    let showArchived: Bool
    
    init(showArchived: Bool) {
        self.showArchived = showArchived
        
        devices = FetchRequest<Device>(entity: Device.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Device.assetTag, ascending: true)
        ], predicate: NSPredicate(format: "archived = %d", showArchived))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(devices.wrappedValue) { device in
                    Text(device.assetTag ?? "")
                }
            }
            .navigationTitle(showArchived ? "Archived Devices" : "Devices")
        }
    }
}

struct AssetsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsView(showArchived: false)
    }
}
