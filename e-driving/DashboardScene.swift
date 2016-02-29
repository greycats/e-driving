//
//  DashboardScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class DashboardViewController: UIViewController, ColorPalette {

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .Background:
			view.backgroundColor = color
		default:
			break
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		applyTheme(.Dark)
	}
}
