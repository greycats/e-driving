//
//  ArchievementsView.swift
//  e-driving
//
//  Created by Jint on 2/28/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class AchievementView: NibView {
	@IBOutlet weak var captionLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!

	var highlighted: Bool = false {
		didSet {
			if highlighted {
				captionLabel.textColor = UIColor(hexRGB: 0xFFFFFF)
				imageView.tintColor = UIColor(hexRGB: 0xE67E22)
			} else {
				captionLabel.textColor = UIColor(hexRGB: 0x9B9B9B)
				imageView.tintColor = UIColor(hexRGB: 0x3D3D3F)
			}
		}
	}

	convenience init(achievement: Achievement) {
		self.init()
		captionLabel.text = achievement.text
		let imageName = String(achievement)
		imageView.image = UIImage(named: imageName)
	}
}

class AchievementsView: UIView {
	var achievements: [Achievement] = [] {
		didSet {
			self -< achievements.map { AchievementView(achievement: $0) }
		}
	}
}