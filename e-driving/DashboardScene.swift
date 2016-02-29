//
//  DashboardScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class DashboardViewController: UIViewController, ColorPalette {

	@IBOutlet weak var dateTicker: DateTicker!
	@IBOutlet weak var basisPicker: UIView!
	@IBOutlet weak var milesView: MilesView!
	@IBOutlet weak var indicesView: UIView!

	override func viewDidLoad() {
		super.viewDidLoad()
		applyTheme(.Dark)
		dateTicker.date = NSDate()
		for subview in indicesView.subviews {
			if let subview = subview as? ColorPalette {
				subview.applyTheme(.Dark)
			}
		}
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		milesView.miles = 8.5
	}
}
