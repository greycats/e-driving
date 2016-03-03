//
//  Button.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class ButtonView: NibView, ColorPalette {
    @IBOutlet weak var buttonView: UIButton! {
        didSet { renderTitle() }
    }
    @IBInspectable var title: String? {
        didSet { renderTitle() }
    }
    private func renderTitle() {
        buttonView?.setTitle(title?.uppercaseString, forState: .Normal)
    }

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .Highlight:
			buttonView.backgroundColor = color
		default:
			break
		}
	}

	private var closure: (() -> ())?
	func onClick(closure: () -> ()) {
		self.closure = closure
		buttonView.removeTarget(self, action: nil, forControlEvents: .TouchUpInside)
		buttonView.addTarget(self, action: "click", forControlEvents: .TouchUpInside)
	}

	func click() {
		closure?()
	}
}