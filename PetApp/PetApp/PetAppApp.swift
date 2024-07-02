//
//  PetAppApp.swift
//  PetApp
//
//  Created by 박지혜 on 7/2/24.
//

import SwiftUI

@main
struct PetAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
