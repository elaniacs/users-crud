//
//  usersApp.swift
//  users
//
//  Created by Cáren Sousa on 24/09/22.
//

import SwiftUI

@main
struct usersApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
