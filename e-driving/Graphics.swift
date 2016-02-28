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
class DashLine: UIView {
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
	let normalColor = UIColor(hexRGB: 0x9B9B9B)

	let dotDiameter: CGFloat = 14
	let thickness: CGFloat = 2

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

@IBDesignable
class VehicleDisplay: UIView {
	override func drawRect(rect: CGRect) {
		let path = UIBezierPath()
		path.moveToPoint(CGPointMake(1.62, 3.87))
		path.addCurveToPoint(CGPointMake(10.99, 2.52), controlPoint1: CGPointMake(4.39, 3.43), controlPoint2: CGPointMake(7.43, 2.99))
		path.addCurveToPoint(CGPointMake(26.24, 0.83), controlPoint1: CGPointMake(15.15, 1.97), controlPoint2: CGPointMake(20.64, 1.28))
		path.addCurveToPoint(CGPointMake(42.34, 0.1), controlPoint1: CGPointMake(30.88, 0.47), controlPoint2: CGPointMake(35.99, 0.23))
		path.addCurveToPoint(CGPointMake(47.98, 0), controlPoint1: CGPointMake(44.22, 0.06), controlPoint2: CGPointMake(46.1, 0.03))
		path.addCurveToPoint(CGPointMake(53.61, 0.07), controlPoint1: CGPointMake(49.85, 0.02), controlPoint2: CGPointMake(51.73, 0.04))
		path.addCurveToPoint(CGPointMake(69.72, 0.72), controlPoint1: CGPointMake(59.96, 0.17), controlPoint2: CGPointMake(65.08, 0.38))
		path.addCurveToPoint(CGPointMake(84.99, 2.32), controlPoint1: CGPointMake(75.32, 1.13), controlPoint2: CGPointMake(80.82, 1.79))
		path.addCurveToPoint(CGPointMake(94.65, 3.66), controlPoint1: CGPointMake(88.67, 2.79), controlPoint2: CGPointMake(91.79, 3.22))
		path.addCurveToPoint(CGPointMake(94.16, 10.86), controlPoint1: CGPointMake(94.46, 6.11), controlPoint2: CGPointMake(94.3, 8.51))
		path.addCurveToPoint(CGPointMake(93.38, 28.81), controlPoint1: CGPointMake(93.73, 17.89), controlPoint2: CGPointMake(93.49, 23.59))
		path.addCurveToPoint(CGPointMake(93.38, 46.37), controlPoint1: CGPointMake(93.27, 34.67), controlPoint2: CGPointMake(93.32, 40.62))
		path.addLineToPoint(CGPointMake(93.4, 48.58))
		path.addCurveToPoint(CGPointMake(93.66, 66.96), controlPoint1: CGPointMake(93.45, 54.61), controlPoint2: CGPointMake(93.51, 60.83))
		path.addCurveToPoint(CGPointMake(94.59, 87.96), controlPoint1: CGPointMake(93.84, 73.77), controlPoint2: CGPointMake(94.15, 80.83))
		path.addCurveToPoint(CGPointMake(96.06, 108.37), controlPoint1: CGPointMake(95, 94.77), controlPoint2: CGPointMake(95.54, 101.68))
		path.addCurveToPoint(CGPointMake(89.64, 109.98), controlPoint1: CGPointMake(93.96, 108.92), controlPoint2: CGPointMake(91.79, 109.49))
		path.addCurveToPoint(CGPointMake(73.96, 112.29), controlPoint1: CGPointMake(85.01, 111.01), controlPoint2: CGPointMake(79.88, 111.77))
		path.addCurveToPoint(CGPointMake(60.4, 113.01), controlPoint1: CGPointMake(69.65, 112.67), controlPoint2: CGPointMake(65.09, 112.92))
		path.addCurveToPoint(CGPointMake(48.49, 113.04), controlPoint1: CGPointMake(56.24, 113.1), controlPoint2: CGPointMake(52.07, 113.07))
		path.addCurveToPoint(CGPointMake(48.49, 113.04), controlPoint1: CGPointMake(48.49, 113.04), controlPoint2: CGPointMake(48.49, 113.04))
		path.addLineToPoint(CGPointMake(48.48, 113.04))
		path.addCurveToPoint(CGPointMake(36.57, 113.09), controlPoint1: CGPointMake(44.05, 113.11), controlPoint2: CGPointMake(40.32, 113.14))
		path.addCurveToPoint(CGPointMake(23.02, 112.46), controlPoint1: CGPointMake(31.89, 113.02), controlPoint2: CGPointMake(27.32, 112.81))
		path.addCurveToPoint(CGPointMake(7.32, 110.24), controlPoint1: CGPointMake(17.09, 111.97), controlPoint2: CGPointMake(11.96, 111.25))
		path.addCurveToPoint(CGPointMake(0.89, 108.67), controlPoint1: CGPointMake(5.16, 109.77), controlPoint2: CGPointMake(2.99, 109.22))
		path.addCurveToPoint(CGPointMake(2.23, 88.26), controlPoint1: CGPointMake(1.36, 101.98), controlPoint2: CGPointMake(1.85, 95.07))
		path.addCurveToPoint(CGPointMake(3.02, 67.25), controlPoint1: CGPointMake(2.62, 81.11), controlPoint2: CGPointMake(2.89, 74.04))
		path.addCurveToPoint(CGPointMake(3.17, 48.87), controlPoint1: CGPointMake(3.13, 61.12), controlPoint2: CGPointMake(3.15, 54.89))
		path.addLineToPoint(CGPointMake(3.17, 46.66))
		path.addCurveToPoint(CGPointMake(3.05, 29.1), controlPoint1: CGPointMake(3.19, 40.9), controlPoint2: CGPointMake(3.21, 34.95))
		path.addCurveToPoint(CGPointMake(2.16, 11.16), controlPoint1: CGPointMake(2.92, 23.88), controlPoint2: CGPointMake(2.63, 18.18))
		path.addCurveToPoint(CGPointMake(1.62, 3.87), controlPoint1: CGPointMake(2, 8.78), controlPoint2: CGPointMake(1.82, 6.34))
		path.closePath()
		tintColor.setFill()
		path.fill()
	}
}