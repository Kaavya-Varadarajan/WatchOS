//
//  WatchOSApp.swift
//  WatchOS WatchKit Extension
//
//  Created by Kaavya on 2022-02-08.
//

import SwiftUI

@main
struct WatchOSApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
