//
//  DeviceDetailView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 27/10/2022.
//

import SwiftUI

struct AssetDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataController: DataController

    let device: Device
    let dateFormatter = DateFormatter()

    @State private var showDeleteAlert = false
    @State private var archived: Bool
    
    init(device: Device) {
        self.device = device
        _archived = State(wrappedValue: device.archived)
    }
    
    var body: some View {
    
        List {
            Section("Details") {
                HStack {
                    Text("Owner")
                    Spacer()
                    Text("\(device.staff?.staffFirstName ?? "No User") \(device.staff?.staffLastName ?? "")")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Asset Tag")
                    Spacer()
                    Text(device.deviceAssetTag)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Manufacturer")
                    Spacer()
                    Text(device.deviceManufacturer)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Model")
                    Spacer()
                    Text(device.deviceModel)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Serial Number")
                    Spacer()
                    Text(device.deviceSerialNumber)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("MAC Address")
                    Spacer()
                    Text(device.deviceMac)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Type")
                    Spacer()
                    Text(device.deviceType)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Room")
                    Spacer()
                    Text(device.staff?.room?.roomNumber ?? device.room?.roomNumber ?? "No Room")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Purchase Date")
                    Spacer()
                    Text(device.devicePurchaseDate.formatted(date: .numeric, time: .omitted))
                        .foregroundColor(.secondary)
                }
            }
            
            
            if device.deviceNotes.isEmpty == false {
                Section("Notes") {
                    Text(device.deviceNotes)
                        .foregroundColor(.secondary)
                }
            }
    
            if device.hasWarranty {
                Section("Warranty Details") {
                    HStack {
                        Text("Warranty Start")
                        Spacer()
                        Text(device.deviceWarrantyStart.formatted(date: .numeric, time: .omitted))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Warranty Start")
                        Spacer()
                        Text(device.deviceWarrantyEnd.formatted(date: .numeric, time: .omitted))
                            .foregroundColor(.secondary)
                    }
                }
            }

            
            Section {
                if archived == false {
                    Button("Archive") {
                        archived = true
                        dismiss()
                    }
                } else {
                    Button("Unarchive") {
                        archived = false
                        dismiss()
                    }
                }
                
                Button("Delete", role: .destructive) {
                    showDeleteAlert = true
                }
            }
            
        }
        .onChange(of: archived) { _ in update()}
        .navigationTitle("Asset Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AssetEditView(device: device)) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .alert("Delete Asset", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                dataController.delete(device)
                dismiss()
            }
        }
    }
    
    func update() {
        device.archived = archived
    }

}

struct AssetDetailView_Previews: PreviewProvider {
    static let dataController = DataController()
    
    static var previews: some View {
        AssetDetailView(device: .example)
            .environmentObject(dataController)
    }
    
}
