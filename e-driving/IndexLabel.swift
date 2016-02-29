//
//  IndexLabel.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class IndexLabel: NibView, ColorPalette {

	@IBInspectable var key: String? {
		didSet { renderKey() }
	}
	@IBOutlet weak var titleLabel: UILabel! {
		didSet { renderKey() }
	}
	private func renderKey() {
		titleLabel?.text = key
	}

	@IBInspectable var value: String? {
		didSet { renderValue() }
	}
	@IBOutlet weak var numberLabel: UILabel! {
		didSet { renderValue() }
	}
	private func renderValue() {
		numberLabel?.text = value
	}

	@IBInspectable var showAlert: Bool = false {
		didSet { updateAlert() }
	}
	@IBOutlet weak var alertView: UIImageView! {
		didSet { updateAlert() }
	}
	private func updateAlert() {
		alertView?.hidden = !showAlert
	}

	func applyTheme(theme: Theme) {
		switch theme {
		case .Dark:
			numberLabel.textColor = UIColor(hexRGB: 0xECF0F1)
			titleLabel.textColor = UIColor(white: 1, alpha: 0.5)
		case .Light:
//			titleLabel.textColor = UIColor(hexRGB: 0xECF0F1)
			break
		}
	}
}
