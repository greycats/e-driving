//
//  VehicleView.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class VehicleView: NibView {
	@IBOutlet weak var display: VehicleDisplay!
	@IBOutlet weak var scoreLabel: UILabel!

	var score: Double = 0 {
		didSet {
			let formatter = NSNumberFormatter()
			formatter.maximumFractionDigits = 1
			formatter.minimumFractionDigits = 1
			formatter.minimumIntegerDigits = 1
			formatter.maximumIntegerDigits = 2
			let scoreString = formatter.stringFromNumber(score)!
			scoreLabel.attributedText = NSAttributedString(string: scoreString, attributes: [
				NSKernAttributeName: 2,
				NSFontAttributeName: scoreLabel.font,
				NSForegroundColorAttributeName: scoreLabel.textColor
				])
		}
	}
}