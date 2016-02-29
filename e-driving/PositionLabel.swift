//
//  PositionLabel.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class PositionLabel: StyledView, ColorPalette {
	@IBOutlet weak var titleLabel: UILabel! {
		didSet { renderTitle() }
	}
	@IBInspectable var title: String? {
		didSet { renderTitle() }
	}

	private func renderTitle() {
		if let title = title, titleLabel = titleLabel {
			let string = NSAttributedString(string: title.uppercaseString, attributes: [
				NSKernAttributeName: 1,
				NSForegroundColorAttributeName: titleLabel.textColor,
				NSFontAttributeName: titleLabel.font
				])
			titleLabel.attributedText = string
		}
	}

	@IBOutlet weak var addressLabel: UILabel! {
		didSet { renderAddress() }
	}
	@IBInspectable var address: String? {
		didSet { renderAddress() }
	}
	private func renderAddress() {
		addressLabel?.text = address
	}

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .SupplymentText:
			titleLabel.textColor = color
			renderTitle()
		case .MainText:
			addressLabel.textColor = color
		default:
			break
		}
	}
}