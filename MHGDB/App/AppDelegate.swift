//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        Logs.start()
        Color.setDefaults()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ListMenu())
        window?.makeKeyAndVisible()
        
        #if DEBUG
            presentTestController()
        #endif
    }
}
