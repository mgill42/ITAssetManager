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
            
            UsersView()
                .tag(UsersView.tag)
                .tabItem {
                    Image(systemName: "person")
                    Text("Users")
                }
            
            RoomsView()
                .tag(RoomsView.tag)
                .tabItem {
                    Image(systemName: "house")
                    Text("Rooms")
                }
            
            
            AssetsView(showArchived: false)
                .tag(AssetsView.assetsTag)
                .tabItem {
                    Image(systemName: "laptopcomputer.and.iphone")
                    Text("Assets")
                }
            
            AssetsView(showArchived: true)
                .tag(AssetsView.archivedTag)
                .tabItem {
                    Image(systemName: "archivebox")
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
