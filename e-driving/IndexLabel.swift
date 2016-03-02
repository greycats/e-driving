//
//  IndexLabel.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class IndexLabel: NibView, ColorPalette, Syncing {

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

	var healthy: Bool = false
	@IBInspectable var thumbsUp: Bool = false {
		didSet { updateThumb() }
	}
	@IBOutlet weak var thumbView: UIImageView! {
		didSet { updateThumb() }
	}
	private func updateThumb() {
		thumbView?.hidden = !thumbsUp
	}

	@IBInspectable var showAlert: Bool = false {
		didSet { updateAlert() }
	}
	@IBOutlet weak var alertView: AlertIcon! {
		didSet { updateAlert() }
	}
	private func updateAlert() {
		alertView?.hidden = !showAlert
	}

	@IBInspectable var showAlertBefore: Bool = false {
		didSet { updateAlertBefore() }
	}
	@IBOutlet weak var alertBeforeView: AlertIcon! {
		didSet { updateAlertBefore() }
	}
	private func updateAlertBefore() {
		alertBeforeView?.hidden = !showAlertBefore
	}

	func syncingWillStart() {
		titleLabel.text = "RATING"
		numberLabel.text = "TBD"
		numberLabel.alpha = 0.5
	}

	func setSyncingState(alpha: CGFloat) {
		numberLabel.alpha = alpha * 0.5
		titleLabel.alpha = alpha
	}

	func syncingDidStop() {
		numberLabel.alpha = 1
		titleLabel.alpha = 1
	}

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .Alert:
			alertView.tintColor = color
			alertBeforeView.tintColor = color
			if showAlert || showAlertBefore {
				numberLabel.textColor = color
			}
		case .SupplymentText:
			titleLabel.textColor = color
		case .MainText:
			if !thumbsUp && (!showAlert || !showAlertBefore) && !healthy {
				numberLabel.textColor = color
			}
		case .Highlight:
			if thumbsUp || healthy {
				numberLabel.textColor = color
			}
		default:
			break
		}
	}

	var index: CarIndex! {
		didSet {
			var value = index.value
			if let number = Double(index.value) {
				let formatter = NSNumberFormatter()
				formatter.maximumFractionDigits = 1
				formatter.groupingSize = 3
				value = formatter.stringFromNumber(number)!
			}

			titleLabel.text = index.title.uppercaseString
			numberLabel.text = value
			switch index.state {
			case .Alert(let floating):
				switch floating {
				case .FloatLeft:
					showAlertBefore = true
				case .FloatRight:
					showAlert = true
				}
			case .Good:
				healthy = true
			case .Nice:
				thumbsUp = true
			default:
				break
			}
			applyTheme(.Dark)
		}
	}
}