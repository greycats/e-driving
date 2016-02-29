//
//  ActivityScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats
import CoreLocation

class ActivityViewController: UIViewController, ColorPalette {
	@IBOutlet weak var routeView: RouteView!
	@IBOutlet weak var dateTicker: DateTicker!

	override func viewDidLoad() {
		applyTheme(.Dark)
		routeView.route = [
			RouteHistory(timestamp: NSDate(), location: CLLocation(latitude: 37.662438, longitude: -122.424233), recoginzedName: "Home", milesToNext: 6),
			RouteHistory(timestamp: NSDate(), location: CLLocation(latitude: 37.666325, longitude: -122.433674), recoginzedName: nil, milesToNext: nil),
			RouteHistory(timestamp: NSDate(), location: CLLocation(latitude: 37.666325, longitude: -122.433674), recoginzedName: nil, milesToNext: 6),
			RouteHistory(timestamp: NSDate(), location: CLLocation(latitude: 37.662438, longitude: -122.424233), recoginzedName: "Home", milesToNext: nil),
		]

		dateTicker.date = NSDate()
	}
}
