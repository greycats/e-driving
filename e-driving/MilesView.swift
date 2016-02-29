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
	@IBInspectable var percentage: Double = 0 { didSet { setNeedsDisplay() } }

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .Highlight:
			onColor = color
		default:
			break
		}
	}
	@IBInspectable var needleSize: CGSize = CGSize(width: 1.15, height: 5.57) { didSet { setNeedsDisplay() } }
	override func drawRect(rect: CGRect) {
		let angle = CGFloat(2 * M_PI / 45)
		let offAfter = Int(floor(percentage * 45))
		let circleSize = rect.size
		let startPoint = CGPoint(x: -needleSize.width / 2, y: -circleSize.height / 2)
		let cornerRadius = needleSize.width / 2
		let context = UIGraphicsGetCurrentContext()
		CGContextSaveGState(context)
		CGContextTranslateCTM(context, circleSize.width / 2 + startPoint.x, -startPoint.y)
		for i in 0..<45 {
			let off = i >= offAfter
			let path = UIBezierPath(roundedRect: CGRect(origin: startPoint, size: needleSize), cornerRadius: cornerRadius)
			CGContextAddPath(context, path.CGPath)
			CGContextRotateCTM(context, angle)
			CGContextSetFillColorWithColor(context, off ? offColor.CGColor : onColor.CGColor)
			CGContextFillPath(context)
		}
		CGContextRestoreGState(context)
		super.drawRect(rect)
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