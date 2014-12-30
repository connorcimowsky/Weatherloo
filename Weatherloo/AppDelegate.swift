//
//  AppDelegate.swift
//  Weatherloo
//
//  Created by Connor Cimowsky on 12/16/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import UIKit

let flurryAPIKey = ""

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        Flurry.startSession(flurryAPIKey)
        
        return true
    }
}
