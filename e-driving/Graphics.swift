//
//  Graphics.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import UIKit

@IBDesignable
class CurveBackgroundView: UIView {
	@IBInspectable var color: UIColor = UIColor.grayColor() {
		didSet {
			setNeedsDisplay()
		}
	}

	@IBInspectable var waveHeight: CGFloat = 27 {
		didSet {
			setNeedsDisplay()
		}
	}

	override func drawRect(rect: CGRect) {
		let bezier2Path = UIBezierPath()
		let h = rect.height - abs(waveHeight)
		let w = rect.width
		bezier2Path.moveToPoint(CGPointMake(0, h + 0.5919 * waveHeight))
		bezier2Path.addLineToPoint(CGPointMake(0, 0))
		bezier2Path.addLineToPoint(CGPointMake(w, 0))
		bezier2Path.addLineToPoint(CGPointMake(w, h + 0.6396 * waveHeight))
		bezier2Path.addCurveToPoint(CGPointMake(0.4277 * w, h + 0.3844 * waveHeight), controlPoint1: CGPointMake(0.9595 * w, h + 0.8096 * waveHeight), controlPoint2: CGPointMake(0.7707 * w, h + 1.45 * waveHeight))
		bezier2Path.addCurveToPoint(CGPointMake(0, h + 0.5919 * waveHeight), controlPoint1: CGPointMake(0.2176086957 * w, h - 0.2685 * waveHeight), controlPoint2: CGPointMake(0.08118357488 * w, h + 0.1070 * waveHeight))
		bezier2Path.closePath()
		color.setFill()
		bezier2Path.fill()
	}
}