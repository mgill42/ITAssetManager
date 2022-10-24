//
//  StaffView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 24/10/2022.
//

import SwiftUI

struct StaffView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        Button("Add Data") {
            dataController.deleteAll()
            try? dataController.createSampleData()
        }
    }
}

struct StaffView_Previews: PreviewProvider {
    static var previews: some View {
        StaffView()
    }
}
