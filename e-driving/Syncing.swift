//
//  Syncing.swift
//  e-driving
//
//  Created by Rex Sheng on 3/1/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import UIKit

protocol Syncing {
	func startSync(@noescape completion: (end: () -> ()) -> ())
	func syncingDidStop()
	func syncingWillStart()
	func setSyncingState(alpha: CGFloat)
}

protocol LabelSyncing: Syncing {
	var syncingLabel: UILabel! { get }
}

private func breath(t: NSTimeInterval) -> CGFloat {
	var (i, f) = modf(t)
	if i % 2 == 1 {
		f = 1 - f
	}
	return 1 - sin(CGFloat(f * M_PI_2))
}

extension Syncing where Self: NSObject {
	func startSync(@noescape completion: (end: () -> ()) -> ()) {
		syncingWillStart()
		let animation = Animation()
		animation.start {[weak self] time in
			self?.setSyncingState(breath(time))
		}
		completion {[weak self] end in
			animation.stop()
			self?.setSyncingState(1)
			self?.syncingDidStop()
		}
	}
}

extension LabelSyncing {
	func syncingWillStart() {
		syncingLabel.text = "SYNC"
	}

	func syncingDidStop() {
	}

	func setSyncingState(alpha: CGFloat) {
		syncingLabel.alpha = alpha
	}
}