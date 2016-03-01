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

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .Alert:
			alertView.tintColor = color
			if showAlert {
				numberLabel.textColor = color
			}
		case .SupplymentText:
			titleLabel.textColor = color
		case .MainText:
			if !thumbsUp && !showAlert && !healthy {
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
}

enum CarIndexState {
	case Normal
	case Alert
	case Good
	case Nice
}

struct CarIndex {
	let title: String
	let value: Double
	let state: CarIndexState
	let highlight: Bool
	init(title: String, value: Double, state: CarIndexState = .Normal, highlight: Bool = false) {
		self.title = title
		self.value = value
		self.state = state
		self.highlight = highlight
	}
}

extension UIView {
	func stack(index: CarIndex...) {
		let labels = index.map { _ in IndexLabel() }
		horizontalStack(labels, marginX: 13, equalWidth: false)
		labels.apply(index)
		labels.forEach { $0.applyTheme(.Dark) }
	}
}

extension CollectionType where Generator.Element == IndexLabel, Index == Int {
	func apply(index: [CarIndex]) {
		let formatter = NSNumberFormatter()
		formatter.maximumFractionDigits = 1
		formatter.groupingSize = 3

		index.enumerate().forEach { i, index in
			let label = self[i]
			label.titleLabel.text = index.title.uppercaseString
			label.numberLabel.text = formatter.stringFromNumber(index.value)
			label.showAlert = index.state == .Alert
			label.thumbsUp = index.state == .Nice
			label.healthy = index.state == .Good
		}
	}
}