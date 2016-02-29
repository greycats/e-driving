//
//  ArchievementsView.swift
//  e-driving
//
//  Created by Jint on 2/28/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class AchievementsView: NibView {
	var achieveArray: [Achievement]? {
		didSet {
			if let achieves = achieveArray {
				for index in 0 ... achieves.count-1 {
					let achieveView: AchieveView = AchieveView(achieveName: achieves[index].name)
					achieveView.isLight = achieves[index].isLight
					achieveView.frame = CGRect(x: 0, y: 0, width: 94, height: 136)
					switch (index % 3) {
					case 0: achieveView.center = CGPoint(x: self.center.x * 0.4, y: ((CGFloat)(index/3) + 0.5) * achieveView.frame.size.height)
					case 1: achieveView.center = CGPoint(x: self.center.x, y: ((CGFloat)(index/3) + 0.5) * achieveView.frame.size.height)
					case 2: achieveView.center = CGPoint(x: self.center.x * 1.6, y: ((CGFloat)(index/3) + 0.5) * achieveView.frame.size.height)
					default: achieveView.center = CGPoint(x: 0, y: 0)
					}
					self.addSubview(achieveView)
				}
			}
		}
	}
}
