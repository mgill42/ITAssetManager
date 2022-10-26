//
//  ContentView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 24/10/2022.
//

import SwiftUI

struct ContentView: View {
    // remember opened tab when closed
    @SceneStorage("selectedView") var selectedView: String?
    
    var body: some View {
        TabView(selection: $selectedView) {
            AssetsView(showArchived: false)
                .tag(AssetsView.assetsTag)
                .tabItem {
                    Image(systemName: "desktopcomputer")
                    Text("Assets")
                }
            
            StaffView()
                .tag(StaffView.tag)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Users")
                }
            
            AssetsView(showArchived: true)
                .tag(AssetsView.archivedTag)
                .tabItem {
                    Image(systemName: "archivebox.fill")
                    Text("Archived")
                }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
