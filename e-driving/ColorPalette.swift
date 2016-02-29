//
//  ColorPalette.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import UIKit

enum Theme {
	case Light
	case Dark
}

enum ColorCategory {
	case Background
	case Foreground
	case MainText
	case SupplymentText
}

protocol ColorPalette {
	func setColor(color: UIColor, category: ColorCategory)
	func applyTheme(theme: Theme)
}

extension ColorPalette {
	func applyTheme(theme: Theme) {
		let mirror = Mirror(reflecting: self)
		for (_, field) in mirror.children {
			if let field = field as? ColorPalette {
				field.applyTheme(theme)
			}
		}

		switch theme {
		case .Light:
			setColor(UIColor(hexRGB: 0x000000), category: .Background)
			setColor(UIColor(hexRGB: 0xF7F7F7), category: .Foreground)
			setColor(UIColor(hexRGB: 0x1F2C3A), category: .MainText)
		case .Dark:
			setColor(UIColor(hexRGB: 0x000E31), category: .Background)
			setColor(UIColor(hexRGB: 0x063090), category: .Foreground)
			setColor(UIColor(hexRGB: 0xFFFFFF), category: .MainText)
		}
	}
}