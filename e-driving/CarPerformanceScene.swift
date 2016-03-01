//
//  CarPerformanceScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import UIKit

class CarPerformanceViewController: UIViewController, ColorPalette, Overlayed {
	@IBOutlet weak var vehicleView: VehicleView!
	@IBOutlet weak var findMechanic: ButtonView!

	override func viewDidLoad() {
		super.viewDidLoad()
		applyTheme(.Dark)
	}
}