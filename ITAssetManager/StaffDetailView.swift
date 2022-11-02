//
//  StaffDetailView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 28/10/2022.
//

import SwiftUI

struct StaffDetailView: View {
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
                
            }
            
            
            
                Section("Devices") {
                    ForEach(devices.filter {$0.archived == false}) { device in
                        NavigationLink(destination: AssetEditView(device: device)) {
                            Text(device.deviceAssetTag)
                        }
                    }
                    Button("Add Asset") {
                        withAnimation {
                            let newAsset = Device(context: moc)
                            newAsset.assetTag = "New Asset"
                            newAsset.purchaseDate = Date()
                            newAsset.archived = false
                            devices.append(newAsset)
                        }
                    }
                }
        
            
            if devices.contains(where: { $0.archived == true }) {
                Section("Archived Devices") {
                    ForEach(devices.filter {$0.archived == true}) { device in
                        NavigationLink(destination: AssetEditView(device: device)) {
                            Text(device.deviceAssetTag)
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
                NavigationLink(destination: StaffEditView(staff: staff)) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .alert("Delete Staff?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                delete()
            }
        } message: {
            Text("Deleting user will archive all assigned assets")
        }
    }
    
    func update() {
        staff.devices = NSSet(array: devices)
    }
    
    func delete() {
        for device in devices {
            device.archived = true
        }
        dataController.delete(staff)
        dismiss()
    }
}

struct StaffDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StaffDetailView(staff: .example)
    }
}
