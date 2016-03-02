//
//  WeeklyActivity.swift
//  e-driving
//
//  Created by Rex Sheng on 3/2/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class ActivityLine: UIView {
	override func drawRect(rect: CGRect) {
		let path = UIBezierPath()
		let r: CGFloat = rect.size.width / 7 / 2
		let x0: CGFloat = -r
		let numbers: [CGFloat] = [49.59, 85.37, 37.8, 1.98, 55.67, 1.84, 36]
		var y: CGFloat = rect.size.height + 30
		var x = x0
		path.moveToPoint(CGPoint(x: x, y: y))
		tintColor.setStroke()

		for number in numbers {
			let l = UIBezierPath()
			l.moveToPoint(CGPoint(x: x, y: y))
			l.addLineToPoint(CGPoint(x: x, y: rect.size.height))
			l.stroke()
			x += r * 2
			path.addCurveToPoint(CGPoint(x: x, y: number), controlPoint1: CGPoint(x: x - r, y: y), controlPoint2: CGPoint(x: x - r, y: number))
			y = number

		}
		tintColor.setStroke()
		path.lineWidth = 2
		path.stroke()
	}
}

@IBDesignable
class WeekActivity: NibView {
	@IBOutlet weak var activitiesView: UIView!
	@IBOutlet weak var lineLeft: NSLayoutConstraint!
	@IBOutlet weak var lineTop: NSLayoutConstraint!
	@IBOutlet weak var line: UIView!
}
