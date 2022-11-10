//
//  RoomsView.swift
//  ITAssetManager
//
//  Created by Mahaveer Gill on 08/11/2022.
//

import SwiftUI

struct RoomsView: View {
    
    @EnvironmentObject var dataController: DataController

    @State private var searchText = ""
    @State private var addStaff = false
    @State var createdStaff: Staff?
    @State private var showFilter = false
    @State private var filterBy = ""

    
  
    let rooms: FetchRequest<Rooms>
    
    static let tag: String? = "Rooms"
    
    init() {
        rooms = FetchRequest<Rooms>(entity: Rooms.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Rooms.roomNumber, ascending: true)
        ], animation: .default)
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults) { room in
                    
                    
                    NavigationLink(destination: RoomDetailView(room: room)) {
                        Text(room.roomroomNumber)
                            .swipeActions(allowsFullSwipe: false) {
                                SwipeButtonsNoArchiveRoom(room: room)
                            }
                    }
                }
            }
            .searchable(text: $searchText)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .navigationTitle("Rooms")
        }
    }
    
    var searchResults: [Rooms] {
        if searchText.isEmpty {
            return Array(rooms.wrappedValue)
        } else {
            return Array(rooms.wrappedValue).filter {"\($0.roomroomNumber)".localizedCaseInsensitiveContains(searchText)}
        }
    }
}

struct RoomsView_Previews: PreviewProvider {
    static var previews: some View {
        let dataController = DataController.preview
        
        RoomsView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
