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
	@IBOutlet weak var captionLabel: UILabel!

	override func setup() {
		super.setup()
		experienceBar.layer.shadowColor = UIColor(hexRGB: 0x81FF00).CGColor
	}

	var maxExperience: Int = 100
	var experience: Int = 0 {
		didSet {
			increasedExperienceLabel.text = experienceFormat(experience, maxExperience)
			let width = CGFloat(experience) / CGFloat(maxExperience) * bounds.width
			experienceBarWidth.constant = 5
			layoutIfNeeded()
			experienceBarWidth.constant = width
			UIView.animateWithDuration(1) {
				self.layoutIfNeeded()
			}
		}
	}

	var experienceFormat: (Int, Int) -> String = { "+\($0)" }
}