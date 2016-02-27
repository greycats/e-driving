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
    @IBInspectable var title: String? = "Route" {
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
		switch(title!)
		{
		case "Hours": itemLabel?.text = "9999 DRIVE\nHOURS"
		case "Happy": itemLabel?.text = "HAPPY\nENDING"
		case "Slow": itemLabel?.text = "SLOW\nENOUGH"
		case "Ticket": itemLabel?.text = "TICKET\nAVOID"
		case "Drift": itemLabel?.text = "1ST TIME\nDRIFT"
		case "NotDrunk": itemLabel?.text = "NOT\nDRUNK"
		case "Route": itemLabel?.text = "ROUTE\nSCHEDULE"
		case "Safe": itemLabel?.text = "SAFE &\nSOUND"
		case "Speed": itemLabel?.text = "300\nKM//H"
		default: itemLabel?.text = "missed"
		}
		
		// in IBDesignable, UIImage need bundle
		let bundle = NSBundle(forClass: AchieveItem.self)
		var image = UIImage(named: title!, inBundle: bundle, compatibleWithTraitCollection: nil)
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