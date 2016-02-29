//
//  NavigationBar.swift
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
		let view = UILabel()
		if let title = title?.uppercaseString {
			view.attributedText = NSAttributedString(string: title, attributes: [
				NSFontAttributeName: UIFont(name: "SFUIText-Regular", size: 16)!,
				NSForegroundColorAttributeName: UIColor.whiteColor(),
				NSKernAttributeName: 1]
			)
		}
		view.sizeToFit()
		titleView = view
	}
}