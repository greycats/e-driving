//
//  DashboardScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class DashboardViewController: UIViewController, ColorPalette, Overlayed {

	@IBOutlet weak var dateTicker: DateTicker!
	@IBOutlet weak var basisPicker: UIView!
	@IBOutlet weak var milesView: MilesView!
	@IBOutlet weak var indicesView: UIView!

	@IBOutlet var indices: [IndexLabel]!
	override func viewDidLoad() {
		super.viewDidLoad()
		indices.apply([
			CarIndex(title: "miles", value: 3200),
			CarIndex(title: "over speed", value: 13),
			CarIndex(title: "hours", value: 376),
			CarIndex(title: "hard brakes", value: 69),
			CarIndex(title: "mpg", value: 30),
			CarIndex(title: "hard accel", value: 27)
			])
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
		dateTicker.onDateChange = {[weak self] _ in
			self?.milesView.miles = Double(random() % 200) / 10
		}
	}
}
