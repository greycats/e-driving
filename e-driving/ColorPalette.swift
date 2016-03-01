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
	.Highlight: UIColor(hexRGB: 0x50D5C2)
]

extension ColorPalette {
	func setColor(color: UIColor, category: ColorCategory) {
	}

	private func _applyTheme(theme: Theme) {
		switch theme {
		case .Light:
			Light.forEach { setColor($1, category: $0) }
		case .Dark:
			Dark.forEach { setColor($1, category: $0) }
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