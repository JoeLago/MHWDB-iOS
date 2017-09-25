//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import UIKit
import SwiftyUserDefaults

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        Logs.start()
        Color.setDefaults()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ListMenu())
        window?.makeKeyAndVisible()
        
        Defaults[.launchCount] += 1
        if Defaults[.firstLaunchDate] == nil {
            Defaults[.firstLaunchDate] = Date()
        }
        
        #if DEBUG
            presentTestController()
        #endif
    }
}
