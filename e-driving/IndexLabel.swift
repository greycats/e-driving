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
	@IBOutlet weak var thumbView: UIView! {
		didSet { updateThumb() }
	}
	private func updateThumb() {
		thumbView?.hidden = !thumbsUp
	}

	@IBInspectable var showAlert: Bool = false {
		didSet { updateAlert() }
	}
	@IBOutlet weak var alertView: UIView! {
		didSet { updateAlert() }
	}
	private func updateAlert() {
		alertView?.hidden = !showAlert
	}

	@IBInspectable var showAlertBefore: Bool = false {
		didSet { updateAlertBefore() }
	}
	@IBOutlet weak var alertBeforeView: UIView! {
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

	var defaultTextColor: UIColor?

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
			defaultTextColor = color
		case .Highlight:
			thumbView.tintColor = color
			if thumbsUp || healthy {
				numberLabel.textColor = color
			}
		default:
			break
		}
	}

	var index: CarIndex! {
		didSet {
			titleLabel.text = index.title.uppercaseString
			numberLabel.text = index.indexString
			switch index.state {
			case .Alert(let pos):
				switch pos {
				case .Left:
					showAlertBefore = true
				case .TopRight:
					showAlert = true
				}
			case .Good:
				healthy = true
			case .Nice:
				thumbsUp = true
			default:
				break
			}
			if showAlert || showAlertBefore {
				numberLabel.textColor = alertView.tintColor
			} else if thumbsUp || healthy {
				numberLabel.textColor = thumbView.tintColor
			} else {
				numberLabel.textColor = defaultTextColor
			}

		}
	}
}