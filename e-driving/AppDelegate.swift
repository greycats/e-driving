//
//  AppDelegate.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import UIKit
import HockeySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		BITHockeyManager.sharedHockeyManager().configureWithIdentifier("0656d054f006426783308c0906e789d6")
		// Do some additional configuration if needed here
		BITHockeyManager.sharedHockeyManager().startManager()
		BITHockeyManager.sharedHockeyManager().authenticator.authenticateInstallation()
		return true
	}
}

