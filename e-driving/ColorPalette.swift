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
	case Line
	case SupplymentText
	case Highlight
}

protocol ColorPalette {
	func setColor(color: UIColor, category: ColorCategory)
	func applyTheme(theme: Theme)
}

extension ColorPalette {
	func setColor(color: UIColor, category: ColorCategory) {
	}

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
			setColor(UIColor(hexRGB: 0x9B9B9B), category: .SupplymentText)
			setColor(UIColor(hexRGB: 0xE67E22), category: .Highlight)
		case .Dark:
			setColor(UIColor(hexRGB: 0x000E31), category: .Background)
			setColor(UIColor(hexRGB: 0x063090), category: .Foreground)
			setColor(UIColor(hexRGB: 0xFFFFFF), category: .MainText)
			setColor(UIColor(hexRGB: 0x8396C0), category: .SupplymentText)
			setColor(UIColor(hexRGB: 0x50D5C2), category: .Highlight)
		}
	}
}

extension ColorPalette where Self: UIViewController {
	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .Foreground:
			view.backgroundColor = color
		default:
			break
		}
	}
}