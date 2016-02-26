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
        var picName = title!
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
        if isLight {
            picName += "_Light"
            itemLabel?.textColor = UIColor(hexRGB: 0xFFFFFF)
        } else {
            picName += "_Dark"
            itemLabel?.textColor = UIColor(hexRGB: 0x9B9B9B)
        }
		
		// in IBDesignable, UIImage need bundle
		let bundle = NSBundle(forClass: AchieveItem.self)
        let image = UIImage(named: picName, inBundle: bundle, compatibleWithTraitCollection: nil)
        itemPic?.image = image
    }
}