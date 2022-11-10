//
//  StaffDetailView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 28/10/2022.
//

import SwiftUI

struct UserDetailView: View {
    @ObservedObject var staff: Staff
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var moc
    
    @State private var showDeleteAlert = false
    @State private var devices: [Device]
    
    
    init(staff: Staff) {
        self.staff = staff
        
        _devices = State(wrappedValue: staff.staffDevices)
    }
    
    var body: some View {
        List {
            Section("Details") {
                HStack {
                    Text("Name")
                    Spacer()
                    Text("\(staff.staffFirstName) \(staff.staffLastName)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Department")
                    Spacer()
                    Text("\(staff.staffDepartment)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Room")
                    Spacer()
                    Text("\(staff.room?.roomroomNumber ?? "No Room")")
                        .foregroundColor(.secondary)
                }
                
            }
            
                Section("Devices") {
                    ForEach(staff.staffDevices
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
                            newAsset.staff = staff
                            devices.append(newAsset)
                        }
                    }
                }
        
            
            if staff.staffDevices.contains(where: { $0.archived == true }) {
                Section("Archived Devices") {
                    ForEach(staff.staffDevices
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
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: UserEditView(staff: staff)) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .alert("Delete Staff?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                delete()
            }
        }
    }
    
    func update() {
        staff.devices = NSSet(array: devices)
    }
    
    func delete() {
        dataController.delete(staff)
        dismiss()
    }
}

struct StaffDetailView_Previews: PreviewProvider {
    static let dataController = DataController()
    
    static var previews: some View {
        UserDetailView(staff: .example)
            .environmentObject(dataController)
        
    }
}
