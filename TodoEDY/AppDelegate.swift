//
//  AppDelegate.swift
//  TodoEDY
//
//  Created by Yungdrung Gyaltsen on 11/19/18.
//  Copyright © 2018 Yungdrung Gyaltsen. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       //print( Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
        }
        catch{
            print("Error initializing Realm \(error)")
        }
        
        return true
    }

}
