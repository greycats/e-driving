//
//  VehicleScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats
import CoreLocation

class VehicleViewController: UIViewController, ColorPalette, Overlayed {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var routeView: RouteView!
	@IBOutlet weak var milesView: MilesView!

	@IBOutlet weak var indicesView: UIView!
	@IBOutlet weak var milesPerGallonLabel: IndexLabel!
	@IBOutlet weak var hardBrakesLabel: IndexLabel!
	@IBOutlet weak var hardAcceleLabel: IndexLabel!
	@IBOutlet weak var overSpeedLabel: IndexLabel!
	@IBOutlet weak var experienceView: ExperienceView!

	override func viewDidLoad() {
		super.viewDidLoad()
		applyTheme(.Dark)
		for subview in scrollView.subviews {
			if let subview = subview as? ColorPalette {
				subview.applyTheme(.Dark)
			}
		}
		for subview in indicesView.subviews {
			if let subview = subview as? ColorPalette {
				subview.applyTheme(.Dark)
			}
		}
		routeView.displayMiles = false
		routeView.route = [
			RouteHistory(timestamp: NSDate(), location: CLLocation(latitude: 37.662438, longitude: -122.424233), recoginzedName: "From Home", milesToNext: 6),
			RouteHistory(timestamp: NSDate(), location: CLLocation(latitude: 37.736910, longitude: -122.249683), recoginzedName: "To Office", milesToNext: nil),
		]
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		milesView.miles = 8.5
		experienceView.experience = 35
	}
}