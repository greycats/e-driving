//
//  ColorPalette.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

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
	case Alert
	case Warning
}

protocol ColorPalette {
	func setColor(color: UIColor, category: ColorCategory)
	func applyTheme(theme: Theme)
}

extension UIColor {
	convenience init(hexa: Int, hexb: Int) {
		let ff: CGFloat = 255.0
		let ra = CGFloat((hexa & 0xff0000) >> 16) / ff
		let ga = CGFloat((hexa & 0xff00) >> 8) / ff
		let ba = CGFloat(hexa & 0xff) / ff
		let rb = CGFloat((hexb & 0xff0000) >> 16) / ff
		let gb = CGFloat((hexb & 0xff00) >> 8) / ff
		let bb = CGFloat(hexb & 0xff) / ff
		func blend(b: CGFloat, _ a: CGFloat) -> CGFloat {
			if a < 0.5 {
				return 2 * a * b
			} else {
				return 1 - 2 * (1 - a) * (1 - b)
			}
		}
		let r = blend(ra, rb)
		let g = blend(ga, gb)
		let b = blend(ba, bb)
		self.init(red: r, green: g, blue: b, alpha: 1)
	}
}

private let Light: [ColorCategory: UIColor] = [
	.Background: UIColor(hexRGB: 0x000000),
	.Foreground: UIColor(hexRGB: 0xF7F7F7),
	.MainText: UIColor(hexRGB: 0x1F2C3A),
	.SupplymentText: UIColor(hexRGB: 0x9B9B9B),
	.Highlight: UIColor(hexRGB: 0xE67E22)
]

private let Dark: [ColorCategory: UIColor] = [
	.Background: UIColor(hexRGB: 0x000E31),
	.Foreground: UIColor(hexRGB: 0x072E86),
	.MainText: UIColor(hexRGB: 0xFFFFFF),
	.SupplymentText: UIColor(hexRGB: 0x8396C0),
	.Highlight: UIColor(hexRGB: 0x2CBC69),
	.Alert: UIColor(hexRGB: 0xFF3B30),
	.Warning: UIColor(hexRGB: 0xF5A623)
]

private let DarkOverlay: [ColorCategory: UIColor] = [
	.Foreground: UIColor(hexa: 0x3F98FF, hexb: 0x0E2A4B),
	.MainText: UIColor(hexa: 0x3F98FF, hexb: 0xFFFFFF),
	.SupplymentText: UIColor(white: 1, alpha: 0.5),
	.Highlight: UIColor(hexa: 0x3F98FF, hexb: 0x2CBC69),
	.Alert: UIColor(hexa: 0x3F98FF, hexb: 0xFF3B30),
	.Warning: UIColor(hexa: 0x3F98FF, hexb: 0xF5A623)
]

extension ColorPalette {
	func setColor(color: UIColor, category: ColorCategory) {
	}

	private func _applyTheme(theme: Theme) {
		switch theme {
		case .Light:
			Light.forEach { setColor($1, category: $0) }
		case .Dark:
			if self is Overlayed {
				DarkOverlay.forEach { setColor($1, category: $0) }
			} else {
				Dark.forEach { setColor($1, category: $0) }
			}
		}
	}

	func applyTheme(theme: Theme) {
		let mirror = Mirror(reflecting: self)
		for (_, field) in mirror.children {
			if let field = field as? ColorPalette {
				field.applyTheme(theme)
			}
		}
		_applyTheme(theme)
	}
}

protocol Overlayed {
}

extension ColorPalette where Self: UIViewController {
	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .Foreground:
			view.backgroundColor = color
			navigationController?.navigationBar.setBackgroundImage(UIImage(fromColor: color), forBarPosition: .Any, barMetrics: .Default)
		default:
			break
		}
	}
}