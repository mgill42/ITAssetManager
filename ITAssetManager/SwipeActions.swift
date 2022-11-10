//
//  SwipeActions.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 03/11/2022.
//

import SwiftUI


struct SwipeButtons: View {
    @EnvironmentObject var dataController: DataController
    
    @State var device: Device
    
    var body: some View {
        
        Button(role: .destructive) {
            dataController.delete(device)
            dataController.container.viewContext.processPendingChanges()
            dataController.save()
        } label: {
            Label("Delete", systemImage: "trash.fill")
        }
        
        Button(role: .destructive) {
            device.archived = device.archived == false ? true : false
            dataController.save()
        } label: {
            Label(device.archived == false ? "Archive" : "Unarchive", systemImage: device.archived == false ? "archivebox.fill" : "tray.and.arrow.up.fill")
        }
        .tint(.teal)
        

    
        NavigationLink(destination: AssetEditView(device: device)) {
            Label("Edit", systemImage: "square.and.pencil")
        }
        .tint(.orange)
        
    }
}

struct SwipeButtonsNoArchiveDevice: View {
    @EnvironmentObject var dataController: DataController
    
    @State var device: Device
    
    var body: some View {
        
        Button(role: .destructive) {
            dataController.delete(device)
            dataController.container.viewContext.processPendingChanges()
            dataController.save()
        } label: {
            Label("Delete", systemImage: "trash.fill")
        }
    
        NavigationLink(destination: AssetEditView(device: device)) {
            Label("Edit", systemImage: "square.and.pencil")
        }
        .tint(.orange)
        
    }
}

struct SwipeButtonsNoArchiveStaff: View {
    @EnvironmentObject var dataController: DataController
    
    @State var staff: Staff
    
    var body: some View {
        
        Button(role: .destructive) {
            dataController.delete(staff)
            dataController.container.viewContext.processPendingChanges()
            dataController.save()
        } label: {
            Label("Delete", systemImage: "trash.fill")
        }
    
        NavigationLink(destination: UserEditView(staff: staff)) {
            Label("Edit", systemImage: "square.and.pencil")
        }
        .tint(.orange)
        
    }
}

struct SwipeButtonsNoArchiveRoom: View {
    @EnvironmentObject var dataController: DataController
    
    @State var room: Rooms
    
    var body: some View {
        
        Button(role: .destructive) {
            dataController.delete(room)
            dataController.container.viewContext.processPendingChanges()
            dataController.save()
        } label: {
            Label("Delete", systemImage: "trash.fill")
        }
    
//        NavigationLink(destination: UserEditView(staff: staff)) {
//            Label("Edit", systemImage: "square.and.pencil")
//        }
//        .tint(.orange)
        
    }
}

