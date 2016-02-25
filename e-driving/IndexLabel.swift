//
//  IndexLabel.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class IndexLabel: NibView {

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
}
