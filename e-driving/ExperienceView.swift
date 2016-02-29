//
//  ExperienceView.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class ExperienceView: NibView {
	@IBOutlet weak var increasedExperienceLabel: UILabel!
	@IBOutlet weak var experienceBar: UIView!
	@IBOutlet weak var experienceBarWidth: NSLayoutConstraint!

	override func setup() {
		super.setup()
		experienceBar.layer.shadowColor = UIColor(hexRGB: 0x81FF00).CGColor
	}

	var experience: Int = 0 {
		didSet {
			increasedExperienceLabel.text = "+\(experience)"
			let width = CGFloat(experience) / 100 * bounds.width
			experienceBarWidth.constant = width
			UIView.animateWithDuration(1) {
				self.layoutIfNeeded()
			}
		}
	}
}