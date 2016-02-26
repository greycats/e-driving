//
//  MilesView.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class MilesView: NibView {
	let highlightColor = UIColor(hexRGB: 0x2ECC71)
	let normalColor = UIColor(hexRGB: 0x9B9B9B)

	@IBOutlet weak var backgroundView: UIView! {
		didSet { renderBackgroundView() }
	}
	@IBInspectable var highlighted: Bool = false {
		didSet { renderBackgroundView() }
	}
	private func renderBackgroundView() {
		backgroundView?.backgroundColor = highlighted ? highlightColor : normalColor
	}

	@IBOutlet weak var milesLabel: UILabel! {
		didSet { renderMile() }
	}

	@IBInspectable var miles: Double = 0 {
		didSet { renderMile() }
	}

	private func renderMile() {
		let formatter = NSNumberFormatter()
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 1
		formatter.minimumIntegerDigits = 1
		milesLabel.text = formatter.stringFromNumber(miles)
	}
}