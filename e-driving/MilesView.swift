//
//  MilesView.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class ClockView: UIView, ColorPalette {
	@IBInspectable var onColor: UIColor = UIColor.blackColor() { didSet { setNeedsDisplay() } }
	@IBInspectable var offColor: UIColor = UIColor(hexRGB: 0x163782) { didSet { setNeedsDisplay() } }
	var offAfter: Int = 0
	let needleCount = 36

	@IBInspectable var percentage: Double = 0 {
		didSet {
			let int = Int((floor(min(1, percentage) * Double(needleCount))))
			if int != offAfter {
				offAfter = int
				setNeedsDisplay()
			}
		}
	}

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .Highlight:
			onColor = color
		default:
			break
		}
	}
	var paths: [UIBezierPath] = []
	var origin: CGPoint!

	@IBInspectable var needleSize: CGSize = CGSize(width: 1.15, height: 5.57) {
		didSet {
			generatePaths()
		}
	}

	func generatePaths() {
		let circleSize = bounds.size
		let startPoint = CGPoint(x: -needleSize.width / 2, y: -circleSize.height / 2)
		let cornerRadius = needleSize.width / 2
		origin = CGPoint(x: circleSize.width / 2, y: -startPoint.y)
		paths = (0..<needleCount).map { _ in
			UIBezierPath(roundedRect: CGRect(origin: startPoint, size: needleSize), cornerRadius: cornerRadius)
		}
	}

	override func drawRect(rect: CGRect) {
		if paths.count == 0 {
			generatePaths()
		}
		let context = UIGraphicsGetCurrentContext()
		CGContextSaveGState(context)
		CGContextTranslateCTM(context, origin.x, origin.y)
		let angle = CGFloat(2 * M_PI / Double(needleCount))

		for i in 0..<offAfter {
			let path = paths[i]
			CGContextAddPath(context, path.CGPath)
			CGContextRotateCTM(context, angle)
		}
		CGContextSetFillColorWithColor(context, onColor.CGColor)
		CGContextFillPath(context)
		for i in offAfter..<needleCount {
			let path = paths[i]
			CGContextAddPath(context, path.CGPath)
			CGContextRotateCTM(context, angle)
		}
		CGContextSetFillColorWithColor(context, offColor.CGColor)
		CGContextFillPath(context)
		CGContextRestoreGState(context)
	}
}

@IBDesignable
class MilesView: StyledView, ColorPalette {
	@IBOutlet weak var backgroundView: UIView!
	@IBOutlet weak var clockView: ClockView!
	@IBOutlet weak var milesLabel: UILabel! {
		didSet { renderMile() }
	}

	@IBInspectable var miles: Double = 0 {
		didSet { renderMile() }
	}

	private func renderMile() {
		let miles = self.miles
		let t: NSTimeInterval = 1
		let formatter = NSNumberFormatter()
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 1
		formatter.minimumIntegerDigits = 1
		let animation = Animation()
		animation.start {[weak self] time in
			if time <= t {
				let m = sin(time / t * M_PI_2) * miles
				self?.milesLabel.text = formatter.stringFromNumber(m)
				self?.clockView.percentage = m / 10
			} else {
				self?.animation = nil
			}
		}
		self.animation = animation
	}

	var animation: Animation?

	func applyTheme(theme: Theme) {
		clockView.applyTheme(theme)
	}
}