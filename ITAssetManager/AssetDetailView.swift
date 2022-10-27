//
//  DeviceDetailView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 27/10/2022.
//

import SwiftUI

struct AssetDetailView: View {
    
    let device: Device
    let dateFormatter = DateFormatter()
    
    
    var body: some View {
    
        List {
            Section {
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
                    Text("Purchase Date")
                    Spacer()
                    Text(device.devicePurchaseDate.formatted(date: .numeric, time: .omitted))
                        .foregroundColor(.secondary)
                }
   
                VStack(alignment: .leading) {
                    Text("Notes")
                        .padding(.bottom, 5)
                    Text(device.deviceNotes)
                        .foregroundColor(.secondary)
                }
    
            }
            
            Section {
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AssetEditView(device: device)) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
    }
}

struct AssetDetailView_Previews: PreviewProvider {

    static var previews: some View {
        AssetDetailView(device: .example)
    }
    
}
