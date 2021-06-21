//
//  ToDoApp.swift
//  ToDo
//
//  Created by giora krasilshchik on 19/10/2020.
//

import SwiftUI

// no changes in your AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        WebSocketService.shared
        return true
    }
}

@main
struct ToDoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TodoList()
        }
    }
}
