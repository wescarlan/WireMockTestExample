//
//  AppDelegate.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/17/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let configuration: ShowWebCalls.Configuration
        
        if ProcessInfo.processInfo.arguments.contains("useMockService") {
            let port = ProcessInfo.processInfo.environment["mockServicePort"]
            configuration = .localhost(port)
        } else {
            // Follow instructions in README.md for acquiring an API key
            configuration = .rapidApi("<Insert API Key>")
        }
        
        ShowWebCalls.initialize(configuration: configuration)
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

