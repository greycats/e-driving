//
//  CarPerformanceScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class CarPerformanceViewController: UIViewController, ColorPalette, Overlayed {
	@IBOutlet weak var vehicleView: VehicleView!
	@IBOutlet weak var findMechanic: ButtonView!

	@IBOutlet weak var alertsView: UIView!
	override func viewDidLoad() {
		super.viewDidLoad()
		applyTheme(.Dark)
		let alerts = [
			CarAlert(reason: .LowOil, error: "change in 20 miles", suggestion: "Needs Replacement"),
			CarAlert(reason: .LowGas, error: "20 miles left", suggestion: "Find Nearest Station"),
			CarAlert(reason: .EngineCheck, error: "20 miles left", suggestion: "Engine Maintenance")
		]
		let views = alerts.map { AlertInfoView(alert: $0) }
		alertsView |< views
	}
}