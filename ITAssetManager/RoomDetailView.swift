//
//  RoomDetailView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 10/11/2022.
//

import SwiftUI

struct RoomDetailView: View {
    @ObservedObject var room: Rooms
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var moc
    
    @State private var showDeleteAlert = false
    @State private var devices: [Device]
    
    
    init(room: Rooms) {
        self.room = room
        
        _devices = State(wrappedValue: room.roomDevices)
    }
    
    
    var body: some View {
        List {
            Section("Details") {
                HStack {
                    Text("Room")
                    Spacer()
                    Text("\(room.roomroomNumber)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Building")
                    Spacer()
                    Text("\(room.roomBuilding)")
                        .foregroundColor(.secondary)
                }
            }
            
                Section("Devices") {
                    ForEach(room.roomDevices
                        .filter {$0.archived == false}
                        .sorted {$0.devicePurchaseDate > $1.devicePurchaseDate}) { device in
                        NavigationLink(destination: AssetDetailView(device: device)) {
                            Text(device.deviceAssetTag)
                                .swipeActions(allowsFullSwipe: false) {
                                   SwipeButtonsNoArchiveDevice(device: device)
                                    
                                }
                        }
                    }
                    
                    Button("Add Asset") {
                        withAnimation {
                            let newAsset = Device(context: moc)
                            newAsset.assetTag = "New Asset"
                            newAsset.purchaseDate = Date()
                            newAsset.archived = false
                            newAsset.room = room
                            devices.append(newAsset)
                        }
                    }
                }
        
            
            if room.roomDevices.contains(where: { $0.archived == true }) {
                Section("Archived Devices") {
                    ForEach(room.roomDevices
                        .filter {$0.archived == true}
                        .sorted {$0.devicePurchaseDate > $1.devicePurchaseDate}) { device in
                        NavigationLink(destination: AssetDetailView(device: device)) {
                            Text(device.deviceAssetTag)
                                .swipeActions(allowsFullSwipe: false) {
                                    SwipeButtonsNoArchiveDevice(device: device)
                                }
                        }
                    }
                }
            }
            
            Section {
                Button("Delete", role: .destructive) {
                    showDeleteAlert = true
                }
            }
        }
        .navigationTitle("Staff Details")
        .onChange(of: devices) { _ in update()}
        .onDisappear(perform: dataController.save)
        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                NavigationLink(destination: RoomEditView(room: room)) {
//                    Image(systemName: "square.and.pencil")
//                }
//            }
        }
        .alert("Delete Staff?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                delete()
            }
        }
    }
    
    func update() {
        room.devices = NSSet(array: devices)
    }
    
    func delete() {
        dataController.delete(room)
        dismiss()
    }
}

struct RoomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetailView(room: .example)
    }
}
