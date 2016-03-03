//
//  NavigationItem.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class NavigationItem: UINavigationItem {
	override var title: String? {
		didSet {
			resetTitleView()
		}
	}

	var _titleView: UIView?
	override var titleView: UIView? {
		get {
			if _titleView == nil {
				resetTitleView()
			}
			return _titleView
		}
		set(value) {
			_titleView = value
			super.titleView = value
		}
	}

	func resetTitleView() {
		let view = KernLabel()
		view.font = UIFont(name: "SFUIText-Regular", size: 16)
		view.textColor = .whiteColor()
		view.kern = 1
		view.text = title?.uppercaseString
		view.sizeToFit()
		titleView = view
	}
}

@IBDesignable
public class KernLabel: UILabel {
	@IBInspectable public var kern: Int = 0 {
		didSet { updateAttributedText() }
	}
	public override var text: String? {
		didSet { updateAttributedText() }
	}
	
	func updateAttributedText() {
		if let text = text {
			attributedText = NSAttributedString(string: text, attributes: [
				NSFontAttributeName: font,
				NSForegroundColorAttributeName: textColor,
				NSKernAttributeName: kern
				])
		}
	}
}