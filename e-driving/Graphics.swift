//
//  Graphics.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class Animation: NSObject {
	var lastDrawTime: CFTimeInterval = 0
	var displayLink: CADisplayLink?

	func start(closure: NSTimeInterval -> ()) {
		self.closure = closure
		if let displayLink = displayLink {
			displayLink.invalidate()
			lastDrawTime = 0
		}
		displayLink = CADisplayLink(target: self, selector: "update")
		displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
	}

	deinit {
		if let displayLink = displayLink {
			displayLink.invalidate()
		}
	}

	var closure: ((elapsedTime: NSTimeInterval) -> ())!

	func update() {
		if let displayLink = displayLink {
			if lastDrawTime == 0 {
				lastDrawTime = displayLink.timestamp
			}
			let elapsedTime = displayLink.timestamp - lastDrawTime
			closure(elapsedTime: elapsedTime)
		}
	}
}

@IBDesignable
class Arrow: UIControl, ColorPalette {
	@IBInspectable var left: Bool = true {
		didSet { setNeedsDisplay() }
	}

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .MainText:
			tintColor = color
			setNeedsDisplay()
		default:
			break
		}
	}

	override func drawRect(rect: CGRect) {
		let path = UIBezierPath()
		path.moveToPoint(CGPointMake(left ? 16 : 9, 18))
		path.addLineToPoint(CGPointMake(left ? 11 : 14, 13))
		path.addLineToPoint(CGPointMake(left ? 16 : 9, 8))
		path.lineCapStyle = .Round
		path.lineJoinStyle = .Round
		tintColor.setStroke()
		path.lineWidth = 1
		path.stroke()
	}
}

@IBDesignable
class CurveBackgroundView: UIView {
	@IBInspectable var color: UIColor = UIColor.grayColor() {
		didSet { setNeedsDisplay() }
	}

	@IBInspectable var waveHeight: CGFloat = 27 {
		didSet { setNeedsDisplay() }
	}

	@IBInspectable var middleRatio: CGFloat = 0.4277 {
		didSet { setNeedsDisplay() }
	}

	let animation = Animation()

	override func willMoveToSuperview(newSuperview: UIView?) {
		if let _ = newSuperview {
			animation.start {[weak self] elapsedTime in
				var (i5, f5) = modf(elapsedTime / 5)
				if i5 % 2 == 1 {
					f5 = 1 - f5
				}
				var (i7, f7) = modf(elapsedTime / 7)
				if i7 % 2 == 1 {
					f7 = 1 - f7
				}
				self?.control = CGFloat(1.6 - f5 * 2)
				self?.waveHeight = CGFloat(f7 * 7 + 20)
			}
		}
	}

	var control: CGFloat = 1.598

	override func drawRect(rect: CGRect) {
		let path = UIBezierPath()
		let h = rect.height - abs(waveHeight)
		let w = rect.width
		let middle = middleRatio * w
		func point(x: CGFloat, _ y: CGFloat) -> CGPoint {
			return CGPoint(x: x * w, y: h + y * waveHeight)
		}
		let startPoint = point(0, 0.592)
		let endPoint = point(1, 0.64)
		path.moveToPoint(CGPoint(x: 0, y: 0))
		path.addLineToPoint(CGPoint(x: w, y: 0))
		path.addLineToPoint(endPoint)
		let m = point(middleRatio, 0.384)
		//		let span: CGFloat = 0.61
		//		let c1 = point((span * (1 - middleRatio) + middleRatio), 1.598)
		//		let c2 = point((1 - span) * middleRatio, 0)
		let c1 = point(middleRatio + 0.348, control)
		var c2 = point(middleRatio - 0.26, 0)
		c2.y = (c2.x - m.x) * (c1.y - m.y) / (c1.x - m.x) + m.y
		path.addCurveToPoint(m, controlPoint1: endPoint, controlPoint2: c1)
		path.addCurveToPoint(startPoint, controlPoint1: c2, controlPoint2: startPoint)
		path.closePath()
		color.setFill()
		path.fill()
	}
}

@IBDesignable
class DashLine: UIView, ColorPalette {
	@IBInspectable var hasLine: Bool = true {
		didSet { setNeedsDisplay() }
	}

	@IBInspectable var highlightDot: Bool = false {
		didSet { setNeedsDisplay() }
	}

	@IBInspectable var highlightLine: Bool = false {
		didSet { setNeedsDisplay() }
	}

	let highlightColor = UIColor(hexRGB: 0x1092E0)

	let dotDiameter: CGFloat = 14
	let thickness: CGFloat = 2

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .SupplymentText:
			normalColor = color
		default:
			break
		}
	}

	var normalColor: UIColor = UIColor.grayColor() {
		didSet { setNeedsDisplay() }
	}

	override func drawRect(rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()
		CGContextSaveGState(context)
		let color = highlightDot ? highlightColor : normalColor
		let dotRect = CGRect(x: thickness / 2, y: thickness / 2, width: dotDiameter, height: dotDiameter)
		CGContextSetStrokeColorWithColor(context, color.CGColor)
		CGContextSetLineWidth(context, thickness)
		CGContextAddEllipseInRect(context, dotRect)
		CGContextStrokePath(context)
		CGContextRestoreGState(context)

		if hasLine {
			CGContextSaveGState(context)
			let mid = CGRectGetMidX(dotRect)
			let dash: [CGFloat] = [1, 5]
			let color = highlightLine ? highlightColor : normalColor
			let sum = dash.reduce(CGFloat(0), combine: +)
			let top = dotDiameter + thickness
			let height = floor((rect.size.height - top) / sum) * sum + top
			CGContextSetLineDash(context	, 1, dash, 2)
			CGContextSetLineWidth(context, 2)
			CGContextSetLineCap(context, .Round)
			CGContextSetStrokeColorWithColor(context, color.CGColor)
			CGContextMoveToPoint(context, mid, top)
			CGContextAddLineToPoint(context, mid, height)
			CGContextStrokePath(context)
			CGContextRestoreGState(context)
		}
	}
}

import FontAwesome_swift

@IBDesignable
class AlertIcon: UIView {
	@IBInspectable var appliesRipple: Bool = false {
		didSet {
			if appliesRipple {
				setup()
			}
		}
	}

	func setup() {
		let ripple = Ripple()
		ripple.backgroundColor = .clearColor()
		ripple.opaque = false
		addSubview(ripple)
		ripple.translatesAutoresizingMaskIntoConstraints = false
		addConstraint(NSLayoutConstraint(item: ripple, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: ripple, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: ripple, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 4, constant: 0))
		addConstraint(NSLayoutConstraint(item: ripple, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 4, constant: 0))
		opaque = false
		backgroundColor = .clearColor()
	}

	override func drawRect(rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()
		CGContextSaveGState(context)
		CGContextSetFillColorWithColor(context, tintColor.CGColor)
		CGContextFillEllipseInRect(context, rect)
		CGContextRestoreGState(context)
		let labelStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
		labelStyle.alignment = .Left

		let font = UIFont.fontAwesomeOfSize(rect.width * 0.52)
		let labelFontAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: labelStyle]
		let text = String.fontAwesomeIconWithName(.ExclamationTriangle)
		let size = text.sizeWithAttributes(labelFontAttributes)
		text.drawInRect(CGRect(origin: CGPoint(x: (rect.width - size.width) / 2, y: (rect.height - 2 * size.height + font.capHeight) / 2), size: size), withAttributes: labelFontAttributes)
	}
}

@IBDesignable
class Ripple: UIView {
	let animation = Animation()

	override func tintColorDidChange() {
		setNeedsDisplay()
	}
	@IBInspectable var t: CGFloat = 0 { didSet { setNeedsDisplay() } }

	func ovalAtCenter(D: CGFloat) -> UIBezierPath {
		let R = bounds.size.width / 2
		let radius = D / 2
		let path = UIBezierPath(ovalInRect: CGRect(x: R - radius, y: R - radius, width: D, height: D))
		path.lineWidth = 2
		return path
	}

	override func willMoveToSuperview(newSuperview: UIView?) {
		if let _ = newSuperview {
			animation.start {[weak self] elapsedTime in
				let (_, t) = modf(elapsedTime / 5)
				self?.t = CGFloat(t)
			}
		}
	}

	override func drawRect(rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()
		CGContextSaveGState(context)
		tintColor.colorWithAlphaComponent(0.05 * t * t - 1.05 * t + 1).setStroke()
		let c = rect.width / 4
		ovalAtCenter(2 * t * t + (c / 2) * t + c - 2).stroke()
		CGContextRestoreGState(context)
	}
}