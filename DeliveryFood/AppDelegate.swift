//
//  AppDelegate.swift
//  DeliveryFood
//
//  Created by Олег Федоров on 05.02.2022.
//

import UIKit

let appColor: UIColor = UIColor(red: 242/255,
                                 green: 247/255,
                                 blue: 241/255,
                                 alpha: 1)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = appColor
        window?.rootViewController = MainViewController()
        
        return true
    }
}

