//
//  ArchievementsView.swift
//  e-driving
//
//  Created by Jint on 2/28/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

enum Achievement {
	case PerfectDriver
	case SafetyLevel(Int)
	case CalmnessLevel(Int)

	var text: String {
		switch self {
		case .PerfectDriver:
			return "PERFECT\nDRIVER"
		case .SafetyLevel(let level):
			return "SAFETY\nLEVEL \(level)"
		case .CalmnessLevel(let level):
			return "CALMNESS\nLEVEL \(level)"
		}
	}
}

@IBDesignable
class GradientLabel: GradientView {
	private var attributedText: [NSAttributedString]!
	@IBInspectable var fontName: String = "SFUIText-Semibold" { didSet { updateText() } }
	@IBInspectable var text: String! { didSet { updateText() } }

	func updateText() {
		attributedText = text.componentsSeparatedByString("\n").map {
			NSAttributedString(string: $0, attributes: [NSFontAttributeName: UIFont(name: fontName, size: 16)!])
		}
		setNeedsDisplay()
	}

	override func drawRect(rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else { return }

		CGContextSaveGState(context)

		attributedText.enumerate().forEach { i, text in
			CGContextRestoreGState(context)
			CGContextSaveGState(context)
			CGContextTranslateCTM(context, 0.0, rect.size.height)
			CGContextScaleCTM(context, 1.0, -1.0)
			let line = CTLineCreateWithAttributedString(text)
			let trect = CTLineGetBoundsWithOptions(line, .UseGlyphPathBounds)
			CGContextSetTextPosition(context, (rect.size.width - trect.size.width) / 2, rect.size.height - CGFloat(i + 1) * 22)
			CGContextSetTextDrawingMode(context, .Clip)
			CTLineDraw(line, context)
			drawGradient(context, rect: rect)
		}
		if !CGContextIsPathEmpty(context) {
			CGContextClip(context)
		}
		CGContextRestoreGState(context)
	}
}

@IBDesignable
class AchivementBorder: GradientView {
	static func outerPath() -> UIBezierPath {
		let path = UIBezierPath()
		path.moveToPoint(CGPointMake(52.97, 0.9))
		path.addCurveToPoint(CGPointMake(46.3, 0.92), controlPoint1: CGPointMake(51.13, -0.31), controlPoint2: CGPointMake(48.13, -0.3))
		path.addLineToPoint(CGPointMake(3.32, 29.69))
		path.addCurveToPoint(CGPointMake(0, 35.91), controlPoint1: CGPointMake(1.5, 30.91), controlPoint2: CGPointMake(0, 33.71))
		path.addLineToPoint(CGPointMake(0, 85.48))
		path.addCurveToPoint(CGPointMake(3.32, 91.71), controlPoint1: CGPointMake(0, 87.68), controlPoint2: CGPointMake(1.5, 90.49))
		path.addLineToPoint(CGPointMake(46.3, 120.47))
		path.addCurveToPoint(CGPointMake(52.97, 120.5), controlPoint1: CGPointMake(48.13, 121.7), controlPoint2: CGPointMake(51.13, 121.71))
		path.addLineToPoint(CGPointMake(96.66, 91.69))
		path.addCurveToPoint(CGPointMake(100, 85.48), controlPoint1: CGPointMake(98.5, 90.48), controlPoint2: CGPointMake(100, 87.68))
		path.addLineToPoint(CGPointMake(100, 35.91))
		path.addCurveToPoint(CGPointMake(96.66, 29.71), controlPoint1: CGPointMake(100, 33.71), controlPoint2: CGPointMake(98.5, 30.92))
		path.closePath()
		return path
	}

	let cellPath: UIBezierPath = {
		let path = AchivementBorder.outerPath()
		path.moveToPoint(CGPointMake(96.08, 82.8))
		path.addCurveToPoint(CGPointMake(92.59, 88.76), controlPoint1: CGPointMake(96.08, 85), controlPoint2: CGPointMake(94.51, 87.69))
		path.addLineToPoint(CGPointMake(53.09, 110.95))
		path.addCurveToPoint(CGPointMake(46.13, 110.93), controlPoint1: CGPointMake(51.17, 112.03), controlPoint2: CGPointMake(48.04, 112.02))
		path.addLineToPoint(CGPointMake(7.38, 88.79))
		path.addCurveToPoint(CGPointMake(3.91, 82.8), controlPoint1: CGPointMake(5.47, 87.7), controlPoint2: CGPointMake(3.91, 85))
		path.addLineToPoint(CGPointMake(3.91, 39.36))
		path.addCurveToPoint(CGPointMake(7.36, 33.33), controlPoint1: CGPointMake(3.91, 37.16), controlPoint2: CGPointMake(5.46, 34.45))
		path.addLineToPoint(CGPointMake(46.15, 10.52))
		path.addCurveToPoint(CGPointMake(53.06, 10.49), controlPoint1: CGPointMake(48.05, 9.4), controlPoint2: CGPointMake(51.16, 9.39))
		path.addLineToPoint(CGPointMake(92.62, 33.36))
		path.addCurveToPoint(CGPointMake(96.08, 39.36), controlPoint1: CGPointMake(94.52, 34.46), controlPoint2: CGPointMake(96.08, 37.16))
		path.closePath()
		path.usesEvenOddFillRule = true
		return path
	}()

	let shadowPath: UIBezierPath = {
		let path = AchivementBorder.outerPath()
		path.lineWidth = 2
		return path
	}()

	let innerPath: UIBezierPath = {
		let path = UIBezierPath()
		path.moveToPoint(CGPointMake(90, 79.86))
		path.addCurveToPoint(CGPointMake(86.84, 85.1), controlPoint1: CGPointMake(90, 81.94), controlPoint2: CGPointMake(88.64, 84.25))
		path.addLineToPoint(CGPointMake(53.16, 103.95))
		path.addCurveToPoint(CGPointMake(46.84, 103.95), controlPoint1: CGPointMake(51.02, 105.24), controlPoint2: CGPointMake(48.3, 105.23))
		path.addLineToPoint(CGPointMake(13.16, 85.1))
		path.addCurveToPoint(CGPointMake(10, 79.86), controlPoint1: CGPointMake(11.36, 84.26), controlPoint2: CGPointMake(10, 81.94))
		path.addLineToPoint(CGPointMake(10, 42.14))
		path.addCurveToPoint(CGPointMake(13.16, 36.9), controlPoint1: CGPointMake(10, 40.7), controlPoint2: CGPointMake(11.35, 38.36))
		path.addLineToPoint(CGPointMake(46.84, 18.05))
		path.addCurveToPoint(CGPointMake(53.16, 18.05), controlPoint1: CGPointMake(48.31, 16.77), controlPoint2: CGPointMake(51.01, 16.76))
		path.addLineToPoint(CGPointMake(86.84, 36.9))
		path.addCurveToPoint(CGPointMake(90, 42.14), controlPoint1: CGPointMake(88.65, 38.37), controlPoint2: CGPointMake(90, 40.7))
		path.addLineToPoint(CGPointMake(90, 79.86))
		path.closePath()
		path.lineWidth = 1
		return path
	}()

	@IBInspectable var innerShadowColor = UIColor(hexRGB: 0x12C8FF) { didSet { setNeedsDisplay() } }
	@IBInspectable var shadowColor = UIColor(white: 0, alpha: 0.1) { didSet { setNeedsDisplay() } }
	@IBInspectable var strokeColor = UIColor(hexRGB: 0x252628) { didSet { setNeedsDisplay() } }

	override func drawRect(rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()
		drawGradient(context, rect: rect) { cellPath.addClip() }

		CGContextSaveGState(context)
		innerShadowColor.setStroke()
		shadowPath.addClip()
		shadowPath.stroke()
		CGContextRestoreGState(context)

		CGContextSaveGState(context)
		cellPath.addClip()
		let shadow = UIBezierPath(rect: CGRectMake(50, -14, 73, 172))
		shadowColor.setFill()
		shadow.fill()
		CGContextRestoreGState(context)

		strokeColor.setStroke()
		innerPath.stroke()
	}
}

@IBDesignable
class AchievementView: NibView {
	@IBOutlet weak var captionLabel: GradientLabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var border: AchivementBorder!

	convenience init(achievement: Achievement) {
		self.init()
		captionLabel.text = achievement.text
		var imageName = String(achievement)
		if let range = imageName.rangeOfString("(") {
			imageName = imageName.substringToIndex(range.startIndex)
		}
		imageView.image = UIImage(named: imageName.cc_capitalizedString)
	}
}

class AchievementsView: UIScrollView {
	var achievements: [Achievement] = [] {
		didSet {
			self -< achievements.map { AchievementView(achievement: $0) }
		}
	}
}