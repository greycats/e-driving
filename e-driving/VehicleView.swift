//
//  VehicleView.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class VehicleView: NibView, ColorPalette {
	@IBOutlet var alerts: [AlertIcon]!
	@IBOutlet var warnings: [AlertIcon]!

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .Alert:
			alerts.forEach { $0.tintColor = color }
		case .Warning:
			warnings.forEach { $0.tintColor = color }
		default:
			break
		}
	}
}