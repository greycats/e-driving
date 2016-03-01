//
//  Achievement.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

enum Achievement {
	case PerfectDriver
	case SmoothnessLevel(Int)
	case CalmnessLevel
	
	var text: String {
		switch self {
		case .PerfectDriver:
			return "PERFECT\nDRIVER"
		case .SmoothnessLevel(let level):
			return "SMOOTHNESS\nLEVEL \(level)"
		case .CalmnessLevel:
			return "CALMNESS\nLEVEL"
		}
	}
}