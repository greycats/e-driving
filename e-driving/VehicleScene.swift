//
//  VehicleScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class VehicleViewController: UIViewController {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var driveView: UIView!
	@IBOutlet weak var vehicleView: VehicleView!

	override func viewDidLoad() {
		super.viewDidLoad()
		vehicleView.score = 8.5
	}
}