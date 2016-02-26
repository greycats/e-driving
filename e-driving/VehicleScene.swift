//
//  VehicleScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class VehicleViewController: UIViewController, UIScrollViewDelegate {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var driveView: UIView!

	func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let y = targetContentOffset.memory.y
		let over = CGFloat(fmodf(Float(y), 55))
		if over < CGFloat(55) / 2 {
			targetContentOffset.memory = CGPoint(x: 0, y: y - CGFloat(over))
		} else {
			targetContentOffset.memory = CGPoint(x: 0, y: y + 55 - over)
		}
	}

	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		switchParagraph()
	}

	func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if !decelerate {
			switchParagraph()
		}
	}

	func switchParagraph() {

	}

	func scrollViewDidScroll(scrollView: UIScrollView) {
		let v = scrollView.contentOffset.y
//		if v >= 0 {
//			scrollView.contentOffset.y = v / 5
//		} else {
//			scrollView.contentOffset.y = 0
//		}
//		print(scrollView.contentOffset.y)
	}
}
