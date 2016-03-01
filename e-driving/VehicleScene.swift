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

	@IBOutlet weak var experienceView: ExperienceView!
	@IBOutlet weak var indicesView: UIView!

	override func viewDidLoad() {
		super.viewDidLoad()
		applyTheme(.Dark)
		for subview in scrollView.subviews {
			if let subview = subview as? ColorPalette {
				subview.applyTheme(.Dark)
			}
		}
		indicesView.stack(
			CarIndex(title: "eco-friendly", value: 31.2, state: .Good),
			CarIndex(title: "smoothness", value: 89),
			CarIndex(title: "calmness", value: 94, state: .Good),
			CarIndex(title: "safety", value: 68, state: .Alert)
		)
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