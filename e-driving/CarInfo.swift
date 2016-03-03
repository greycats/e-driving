//
//  CarInfo.swift
//  e-driving
//
//  Created by Rex Sheng on 3/3/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import UIKit

struct CarInfo {
	let driverName: String
	let driverAvatar: UIImage?
	let rank: Double
	let brand: String
	let model: String
	let year: String
	let miles: Double
	let lastTimeService: NSDate
}

extension CarInfo {
	static var demo = CarInfo(driverName: "Loc Ngo", driverAvatar: UIImage(named: "LocNgo"), rank: 8.5, brand: "BMW", model: "320i", year: "2013", miles: 3200, lastTimeService: NSDate())
}