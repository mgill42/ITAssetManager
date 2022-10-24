//
//  ContentView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 24/10/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            AssetsView(showArchived: false)
                .tabItem {
                    Image(systemName: "desktopcomputer")
                    Text("Test")
                }
            
            StaffView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Users")
                }
            
            AssetsView(showArchived: true)
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
