//
//  StaffDetailView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 28/10/2022.
//

import SwiftUI

struct StaffDetailView: View {
    let staff: Staff
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataController: DataController
    
    @State private var showDeleteAlert = false
    
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
            
            if staff.staffDevices.contains(where: { $0.archived == false }) {
                Section("Devices") {
                    ForEach(staff.staffDevices.filter {$0.archived == false}) { device in
                        NavigationLink(destination: AssetDetailView(device: device)) {
                            Text(device.deviceAssetTag)
                        }
                    }
                }
            }
            if staff.staffDevices.contains(where: { $0.archived == true }) {
                Section("Archived Devices") {
                    ForEach(staff.staffDevices.filter {$0.archived == true}) { device in
                        NavigationLink(destination: AssetDetailView(device: device)) {
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
            Text("Deleting staff will remove all associated assets")
        }
    }
    
    func delete() {
        dataController.delete(staff)
        dismiss()
    }
}

struct StaffDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StaffDetailView(staff: .example)
    }
}
