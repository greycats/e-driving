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

private let Light: [ColorCategory: UIColor] = [
	.Background: UIColor(hexRGB: 0x000000),
	.Foreground: UIColor(hexRGB: 0xF7F7F7),
	.MainText: UIColor(hexRGB: 0x1F2C3A),
	.SupplymentText: UIColor(hexRGB: 0x9B9B9B),
	.Highlight: UIColor(hexRGB: 0xE67E22)
]

private let darkOverlayColor = UIColor(hexRGB: 0x3F98FF)
private let Dark: [ColorCategory: UIColor] = [
	.Background: UIColor(hexRGB: 0x000E31),
	.Foreground: UIColor(hexRGB: 0x0E2A4B).overlay(darkOverlayColor),
	.MainText: UIColor(hexRGB: 0xFFFFFF),
	.SupplymentText: UIColor(hexRGB: 0x8396C0),
	.Highlight: UIColor(hexRGB: 0x2ECC71),
	.Alert: UIColor(hexRGB: 0xFF3B30),
	.Warning: UIColor(hexRGB: 0xF5A623)
]

extension ColorPalette {
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

private var themeKey: Void?

extension ColorPalette where Self: UIView {
	func setColor(color: UIColor, category: ColorCategory) {
	}

	func applyTheme(theme: Theme) {
		_deepApplyTheme(theme)
		_applyTheme(theme)
	}
}

extension UIView {
	private func _deepApplyTheme(theme: Theme) {
		for v in subviews {
			if let v = v as? ColorPalette {
				v.applyTheme(theme)
			} else {
				v._deepApplyTheme(theme)
			}
		}
	}
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

	func applyTheme(theme: Theme) {
		view._deepApplyTheme(theme)
		_applyTheme(theme)
	}
}