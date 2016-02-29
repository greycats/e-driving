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
	var achievements: [Achievement] = [] {
		didSet {
			self -< achievements.map { AchieveView(achievement: $0) }
		}
	}
}
