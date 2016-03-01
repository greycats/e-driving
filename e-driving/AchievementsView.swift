//
//  ArchievementsView.swift
//  e-driving
//
//  Created by Jint on 2/28/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

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
		let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [color1.CGColor, color2.CGColor], [0, 1])

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
			CGContextDrawLinearGradient(context, gradient,
				CGPointMake(rect.size.width * loc1.x, rect.size.height * loc1.y),
				CGPointMake(rect.size.width * loc2.x, rect.size.height * loc2.y),
				[.DrawsBeforeStartLocation, .DrawsAfterEndLocation])
		}
		if !CGContextIsPathEmpty(context) {
			CGContextClip(context)
		}
		CGContextRestoreGState(context)
	}
}

@IBDesignable
class AchievementView: NibView {
	@IBOutlet weak var captionLabel: GradientLabel!
	@IBOutlet weak var imageView: UIImageView!

	convenience init(achievement: Achievement) {
		self.init()
		captionLabel.text = achievement.text
		var imageName = String(achievement)
		if let range = imageName.rangeOfString("(") {
			imageName = imageName.substringToIndex(range.startIndex)
		}
		imageView.image = UIImage(named: imageName)
	}
}

class AchievementsView: UIScrollView {
	var achievements: [Achievement] = [] {
		didSet {
			self -< achievements.map { AchievementView(achievement: $0) }
		}
	}
}