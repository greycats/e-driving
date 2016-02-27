//
//  AchieveItem.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class AchieveItem: NibView {
    @IBInspectable var title: AchieveName? = AchieveName.Route {
        didSet { renderItem() }
    }
    @IBInspectable var isLight: Bool = false {
        didSet { renderItem() }
    }
    @IBOutlet weak var itemLabel: UILabel! {
        didSet { renderItem() }
    }
    @IBOutlet weak var itemPic: UIImageView! {
        didSet { renderItem() }
    }
    private func renderItem() {
		if let achieveName = title {
			var imageName = "Route"
			switch(achieveName)
			{
				case AchieveName.Hours:
					imageName = "Hours"
					itemLabel?.text = "9999 DRIVE\nHOURS"
				case AchieveName.Happy:
					imageName = "Happy"
					itemLabel?.text = "HAPPY\nENDING"
				case AchieveName.Slow:
					imageName = "Slow"
					itemLabel?.text = "SLOW\nENOUGH"
				case AchieveName.Ticket:
					imageName = "Ticket"
					itemLabel?.text = "TICKET\nAVOID"
				case AchieveName.Drift:
					imageName = "Drift"
					itemLabel?.text = "1ST TIME\nDRIFT"
				case AchieveName.NotDrunk:
					imageName = "NotDrunk"
					itemLabel?.text = "NOT\nDRUNK"
				case AchieveName.Route:
					imageName = "Route"
					itemLabel?.text = "ROUTE\nSCHEDULE"
				case AchieveName.Safe:
					imageName = "Safe"
					itemLabel?.text = "SAFE &\nSOUND"
				case AchieveName.Speed:
					imageName = "Speed"
					itemLabel?.text = "300\nKM//H"
				default:
					itemLabel?.text = "missed"
			}
			
			// in IBDesignable, UIImage need bundle
			let bundle = NSBundle(forClass: AchieveItem.self)
			var image = UIImage(named: imageName, inBundle: bundle, compatibleWithTraitCollection: nil)
			image = image?.imageWithRenderingMode(.AlwaysTemplate)//change image color with tintcolor
			itemPic?.image = image
			
			if isLight {
				itemLabel?.textColor = UIColor(hexRGB: 0xFFFFFF)
				itemPic?.tintColor = UIColor(hexRGB: 0xE67E22)
			} else {
				itemLabel?.textColor = UIColor(hexRGB: 0x9B9B9B)
				itemPic?.tintColor = UIColor(hexRGB: 0x3D3D3F)
			}
		}
    }
}