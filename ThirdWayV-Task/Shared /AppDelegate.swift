//
//  AppDelegate.swift
//  NetworkManager
//
//  Created by Yousef Mohamed on 07/06/2022.
//

import UIKit
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var reachability: Reachability?

    var subscriptions = Set<AnyCancellable>()
    var window: UIWindow?
    var rootController: UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }

    private lazy var applicationCoordinator: Coordinator = self.createApplicationCoordinator()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootViewController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        reachability = try? Reachability()
        try? reachability?.startNotifier()

        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        applicationCoordinator.start()
        return true
    }
    
    private func createApplicationCoordinator() -> ApplicationCoordinator {
        let router = WeakRouter(rootController: rootController)
        let factory = ModuleFactory()
        return ApplicationCoordinator(router: router, factory: factory)
    }
}

