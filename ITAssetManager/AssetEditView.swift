//
//  EditDeviceView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 26/10/2022.
//

import SwiftUI

struct AssetEditView: View {
    let device: Device
    let allStaff: FetchRequest<Staff>
    @EnvironmentObject var dataController: DataController
    
    @State private var staff: Staff?
    @State private var archived: Bool
    @State private var assetTag: String
    @State private var mac: String
    @State private var manufacturer: String
    @State private var model: String
    @State private var notes: String
    @State private var type: String
    @State private var purchaseDate: Date
    @State private var serialNumber: String
    @State private var warrantyStart: Date
    @State private var warrantyEnd: Date
    
    init(device: Device) {
        self.device = device
        
        _staff = State(wrappedValue: device.deviceStaff)
        _archived = State(wrappedValue: device.archived)
        _assetTag = State(wrappedValue: device.deviceAssetTag)
        _mac = State(wrappedValue: device.deviceMac)
        _manufacturer = State(wrappedValue: device.deviceManufacturer)
        _model = State(wrappedValue: device.deviceModel)
        _type = State(wrappedValue: device.deviceType)
        _notes = State(wrappedValue: device.deviceNotes)
        _purchaseDate = State(wrappedValue: device.devicePurchaseDate)
        _serialNumber = State(wrappedValue: device.deviceSerialNumber)
        _warrantyStart = State(wrappedValue: device.deviceWarrantyStart)
        _warrantyEnd = State(wrappedValue: device.deviceWarrantyEnd)
        
        allStaff = FetchRequest<Staff>(entity: Staff.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Staff.firstName, ascending: true)
        ])
        
    }
    
    var body: some View {
        Form {
            Section("Device Details") {
                Picker("Staff", selection: $staff) {
                    ForEach(allStaff.wrappedValue) { staff in
                        Text("\(staff.staffFirstName)").tag(staff as Staff?)
                    }
                }
                
                TextField("Asset Tag", text: $assetTag)
                TextField("MAC Address", text: $mac)
                TextField("Manufacturer", text: $manufacturer)
                TextField("Model", text: $model)
                TextField("Serial Number", text: $serialNumber)
                DatePicker("Purchase Date", selection: $purchaseDate, displayedComponents: .date)
                TextField("Notes", text: $notes)
                
            }
            
            Section {
                Picker("Type", selection: $type) {
                    ForEach(DeviceType.types, id: \.self) { type in
                        Text(type)
                    }
                }
            }
            
            Section {
                Toggle("Archive", isOn: $archived)
            }
            
            Section("Warranty Details") {
                DatePicker("Warranty Start", selection: $warrantyStart, displayedComponents: .date)
                DatePicker("Warranty End", selection: $warrantyEnd, displayedComponents: .date)
            }
        }
        .navigationTitle("Edit Asset")
        .onDisappear(perform: dataController.save)
        .onChange(of: staff) { _ in update()}
        .onChange(of: assetTag) { _ in update()}
        .onChange(of: mac) { _ in update()}
        .onChange(of: manufacturer) { _ in update()}
        .onChange(of: model) { _ in update()}
        .onChange(of: serialNumber) { _ in update()}
        .onChange(of: type) { _ in update()}
        .onChange(of: purchaseDate) { _ in update()}
        .onChange(of: notes) { _ in update()}
        .onChange(of: warrantyStart) { _ in update()}
        .onChange(of: warrantyEnd) { _ in update()}
    }
    
    func update() {
        device.staff = staff
        device.archived = archived
        device.assetTag = assetTag
        device.mac = mac
        device.manufacturer = manufacturer
        device.model = model
        device.type = type
        device.notes = notes
        device.purchaseDate = purchaseDate
        device.serialNumber = serialNumber
        device.warrantyStart = warrantyStart
        device.warrantyEnd = warrantyEnd
    }
}

struct AssetEditView_Previews: PreviewProvider {
    static let dataController = DataController()
    
    static var previews: some View {
        AssetEditView(device: .example)
            .environmentObject(dataController)
            
    }
}

