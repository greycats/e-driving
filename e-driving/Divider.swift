//
//  Divider.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class DividerView: NibView {
	@IBOutlet weak var separator: UIView!
	override func willMoveToSuperview(newSuperview: UIView?) {
		if let _ = newSuperview {
			separator.layer.shadowColor = UIColor(white: 0, alpha: 0.3).CGColor
			separator.layer.shadowRadius = 10
			separator.layer.shadowOpacity = 1
			separator.layer.shadowPath = UIBezierPath(rect: CGRect(x: -100, y: 0, width: ScreenSize.width + 200, height: 10)).CGPath
		}
	}
}