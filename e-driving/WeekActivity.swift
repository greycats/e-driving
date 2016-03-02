//
//  WeeklyActivity.swift
//  e-driving
//
//  Created by Rex Sheng on 3/2/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

enum ActivityError: ErrorType {
	case ReachEnd
}

class ActivityLine: UIView {
	var step: CGFloat! {
		didSet {
			r = step * 0.8
		}
	}
	var r: CGFloat!
	var x0: CGFloat!
	var numbers: [CGFloat]!

	private var _weekOffset: Int = 20
	var weekOffset: Int {
		get { return _weekOffset }
		set(value) {
			if value <= 20 && value >= 0 {
				_weekOffset = value
				setNeedsDisplay()
			}
		}
	}

	override func drawRect(rect: CGRect) {
		let path = UIBezierPath()
		let simulate0: CGFloat = x0 - step * 2
		var x = simulate0
		var y: CGFloat
		var sim = true
		let start = weekOffset * 4
		let subset = numbers[start..<start + 5]
		if start > 0 {
			y = numbers[start - 1]
		} else {
			y = rect.size.height + 30
		}

		path.moveToPoint(CGPoint(x: x, y: y))
		for number in subset {
			let oldX = x
			let oldY = y
			x += step * 2
			y = rect.size.height * number
			path.addCurveToPoint(CGPoint(x: x, y: y), controlPoint1: CGPoint(x: sim ? oldX : oldX + r, y: oldY), controlPoint2: CGPoint(x: x - r, y: y))
			sim = false
		}
		tintColor.setStroke()
		path.lineWidth = 2
		path.stroke()
	}
}

private func gen_line(count: Int) -> [CGFloat] {
	srand48(Int(arc4random()))
	return (0..<count).map { _ in 1 - CGFloat(drand48()) }
}

@IBDesignable
class WeekActivity: NibView {
	@IBOutlet weak var activitiesView: UIView!
	@IBOutlet weak var lineLeft: NSLayoutConstraint!
	@IBOutlet weak var lineTop: NSLayoutConstraint!
	@IBOutlet weak var line: UIView!

	var step: CGFloat!
	var x0: CGFloat!
	var weekday: Int = 0 {
		didSet {
			if oldValue != weekday {
				fixLineLeft()
			}
		}
	}

	func setDay(day: NSDate) throws {
		let components = Calendar.components(.Day, fromDate: NSDate(), toDate: day, options: [.MatchFirst])
		let weeks = Int(ceil(Float(components.day) / 7))
		for view in activitiesView.subviews {
			if let view = view as? ActivityLine {
				if weeks > 0 || weeks < -20 {
					throw ActivityError.ReachEnd
				}
				view.weekOffset = weeks + 20
			}
		}
	}

	func addDemoLine(color: UIColor) {
		let activityLine = ActivityLine()
		activityLine.x0 = x0
		activityLine.step = step
		activityLine.numbers = gen_line(100)
		activityLine.opaque = false
		activityLine.tintColor = color
		activitiesView.addSubview(activityLine)
		activityLine.fullDimension()
	}

	override func setup() {
		super.setup()
		activitiesView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "pan:"))
		step = (bounds.width - 40) / 7
		x0 = 20 + step / 2
		layoutIfNeeded()
		weekday = Calendar.component(.Weekday, fromDate: NSDate())
		fixLineLeft()

		//TODO - this is a demo
		(0...1).forEach { _ in
			addDemoLine(UIColor(hexRGB: 0x05297B))
		}
		addDemoLine(UIColor(hexRGB: 0x65D2FD))
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

	func fixLineLeft() {
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
