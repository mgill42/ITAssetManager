//
//  ITAssetManagerApp.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 24/10/2022.
//

import SwiftUI

@main
struct ITAssetManagerApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: save)
        }
    }
    
    func save(_ note: Notification) {
        dataController.save()
    }
}
