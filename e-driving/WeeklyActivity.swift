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

	override func setup() {
		super.setup()
		activitiesView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "pan:"))
	}

	private func panAnimate(closure: (() -> ())?) {
		userInteractionEnabled = false
		UIView.animateWithDuration(0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .CurveEaseInOut, animations: {
			self.layoutIfNeeded()
			}, completion: { _ in
				self.userInteractionEnabled = true
				closure?()
		})
	}

	func panReset() {
		lineLeft.constant = 0
		panAnimate(nil)
	}

	var step: CGFloat!
	var x0: CGFloat!

	var weekday: Int = 0 {
		didSet {
			if oldValue != weekday {
				fixLineLeft()
			}
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		weekday = Calendar.component(.Weekday, fromDate: NSDate())
		fixLineLeft()
	}

	func fixLineLeft() {
		if x0 == nil {
			step = (bounds.width - 40) / 7
			x0 = 20 + step / 2
		}
		lineLeft.constant = CGFloat(weekday) * step + x0
		panAnimate(nil)
	}

	func pan(gesture: UIPanGestureRecognizer) {
		switch gesture.state {
		case .Changed:
			let x = gesture.locationInView(activitiesView).x
			let num = max(0, floor((x - x0) / step))
			weekday = Int(num)
		default:
			break
		}
	}
}
