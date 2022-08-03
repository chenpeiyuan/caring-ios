//
//  caringApp.swift
//  caring
//
//  Created by Peiyuan Chen on 2022/7/28.
//

import Firebase
import SwiftUI

var firebaseInited = false

@main
struct CaringApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    if !firebaseInited {
                        FirebaseApp.configure()
                        firebaseInited = true
                    }
                }
        }
    }
}
