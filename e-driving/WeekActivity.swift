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
	var thickness: CGFloat = 2
	var glow: Bool = false

	var weekOffset: Int = 20 {
		didSet { setNeedsDisplay() }
	}

	func currentY(offset: Int) -> CGFloat {
		let p0 = numbers[weekOffset * 4 + offset / 2]
		if offset % 2 == 1 {
			let p1 = numbers[weekOffset * 4 + offset / 2 + 1]
			return translateY((p0 + p1) / 2)
		} else {
			return translateY(p0)
		}
	}

	func translateY(number: CGFloat) -> CGFloat {
		return bounds.size.height * (0.8 - 0.8 * number)
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

		path.moveToPoint(CGPoint(x: x - step * 2, y: rect.size.height + 30))
		path.addLineToPoint(CGPoint(x: x, y: y))
		for number in subset {
			let oldX = x
			let oldY = y
			x += step * 2
			y = translateY(number)
			path.addCurveToPoint(CGPoint(x: x, y: y), controlPoint1: CGPoint(x: sim ? oldX : oldX + r, y: oldY), controlPoint2: CGPoint(x: x - r, y: y))
			sim = false
		}

		path.addLineToPoint(CGPoint(x: x + step * 2, y: rect.size.height + 30))
		path.closePath()

		let context = UIGraphicsGetCurrentContext()
		CGContextSaveGState(context)
		CGContextSetStrokeColorWithColor(context, tintColor.CGColor)
		CGContextSetFillColorWithColor(context, tintColor.CGColor)
		if glow {
			CGContextSetShadowWithColor(context, .zero, 20, tintColor.colorWithAlphaComponent(0.8).CGColor)
		}
		CGContextAddPath(context, path.CGPath)
		CGContextSetLineWidth(context, thickness)
		CGContextDrawPath(context, .Stroke)

		if glow {
			CGContextAddPath(context, path.CGPath)
			CGContextClip(context)
			let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [UIColor(white: 0, alpha: 0.3).CGColor, UIColor.clearColor().CGColor], [0, 1])
			CGContextDrawLinearGradient(context, gradient,
				CGPointMake(rect.size.width * 0.5, rect.size.height * 0),
				CGPointMake(rect.size.width * 0.5, rect.size.height * 1),
				[.DrawsBeforeStartLocation, .DrawsAfterEndLocation])
		}
		CGContextRestoreGState(context)
	}
}

private func gen_line(count: Int) -> [CGFloat] {
	srand48(Int(arc4random()))
	return (0..<count).map { _ in CGFloat(drand48()) }
}

@IBDesignable
class WeekActivity: NibView {
	@IBOutlet weak var activitiesView: UIView!
	@IBOutlet weak var lineLeft: NSLayoutConstraint!
	@IBOutlet weak var line: UIView!

	var step: CGFloat!
	var x0: CGFloat!
	var weekday: Int = 0 {
		didSet {
			if oldValue != weekday {
				fixLineLeft()
				onWeekdayChange.forEach { $0(weekday) }
			}
		}
	}

	var onWeekdayChange: [(Int) -> ()] = []

	func setDay(day: NSDate) throws {
		let components = Calendar.components(.Day, fromDate: NSDate(), toDate: day, options: [.MatchFirst])
		let weeks = Int(ceil(Float(components.day) / 7)) + 20
		for view in activitiesView.subviews {
			if let view = view as? ActivityLine {
				if weeks > 20 || weeks < 0 {
					throw ActivityError.ReachEnd
				}
				view.weekOffset = weeks
			}
		}
		onWeekdayChange.forEach { $0(weekday) }
	}

	func addDemoLine(color: UIColor = UIColor(hexRGB: 0x65D2FD), thickness: CGFloat = 3, glow: Bool = true) -> ActivityLine {
		let activityLine = ActivityLine()
		activityLine.x0 = x0
		activityLine.step = step
		activityLine.numbers = gen_line(100)
		activityLine.thickness = thickness
		activityLine.tintColor = color
		activityLine.opaque = false
		activityLine.glow = glow
		activitiesView.addSubview(activityLine)
		activityLine.fullDimension()
		return activityLine
	}

	func setupOnce() {
		step = (bounds.width - 40) / 7
		x0 = 20 + step / 2
		//TODO - this is a demo
		(0...1).forEach { i in
			let line = addDemoLine(UIColor(hexRGB: 0x05297B), thickness: 2, glow: false)
			let avatar = UIImageView(image: UIImage(named: "avatar\(i)"))
			attachAvatar(avatar, line: line)
		}
		let line = addDemoLine()
		let avatar = UIImageView(image: UIImage(named: "avatar2"))
		attachAvatar(avatar, line: line)
		layoutIfNeeded()
		weekday = Calendar.component(.Weekday, fromDate: NSDate())
		fixLineLeft()
		onWeekdayChange.forEach { $0(weekday) }
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		if x0 == nil {
			setupOnce()
		}
	}

	override func setup() {
		super.setup()
		activitiesView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "pan:"))
	}

	func attachAvatar(avatar: UIImageView, line: ActivityLine) {
		avatar.translatesAutoresizingMaskIntoConstraints = false
		activitiesView.addSubview(avatar)
		let leading = NSLayoutConstraint(item: avatar, attribute: .CenterX, relatedBy: .Equal, toItem: self.line, attribute: .CenterX, multiplier: 1, constant: 0)
		addConstraint(leading)
		let top = NSLayoutConstraint(item: avatar, attribute: .CenterY, relatedBy: .Equal, toItem: line, attribute: .Top, multiplier: 1, constant: 0)
		addConstraint(top)
		addConstraint(NSLayoutConstraint(item: self.line, attribute: .Top, relatedBy: .GreaterThanOrEqual, toItem: avatar, attribute: .Bottom, multiplier: 1, constant: 14))
		onWeekdayChange.append {[weak line] weekday in
			if let y = line?.currentY(weekday) {
				top.constant = y
			}
		}
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
			weekday = Int(max(0, floor((x - x0) / step)))
		default:
			break
		}
	}
}