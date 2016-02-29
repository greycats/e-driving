//
//  AchieveItem.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class AchieveView: NibView {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemPic: UIImageView!

	override var nibName: String { return "AchieveView" }
	var isLight: Bool = false {
		didSet {
			if isLight {
				itemLabel?.textColor = UIColor(hexRGB: 0xFFFFFF)
				itemPic?.tintColor = UIColor(hexRGB: 0xE67E22)
			} else {
				itemLabel?.textColor = UIColor(hexRGB: 0x9B9B9B)
				itemPic?.tintColor = UIColor(hexRGB: 0x3D3D3F)
			}
		}
	}
	
	convenience init(achievement: Achievement) {
		self.init()
		let imageName = String(achievement)
		itemLabel?.text = achievement.text
		itemPic?.image = UIImage(named: imageName)?.imageWithRenderingMode(.AlwaysTemplate)
	}
}
