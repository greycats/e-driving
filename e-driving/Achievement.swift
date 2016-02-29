//
//  Achievement.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

enum Achievement {
	case Hours(Int)
	case HappyEnding
	case SlowEnough
	case TicketAvoid
	case FirstDrift
	case NotDrunk
	case RouteSchedule
	case SafeNSound
	case Speed(Int)

	var text: String {
		switch self {
		case .Hours(let hours):
			return "\(hours) DRIVE\nHOURS"
		case .RouteSchedule:
			return "ROUTE\nSCHEDULE"
		case .SafeNSound:
			return "SAFE &\nSOUND"
		case .Speed(let speed):
			return "\(speed)\nKM/h"
		case NotDrunk:
			return "NOT\nDRUNK"
		case .FirstDrift:
			return "1ST TIME\nDRIFT"
		case .TicketAvoid:
			return "TICKET\nAVOID"
		case .SlowEnough:
			return "SLOW\nENOUGH"
		case .HappyEnding:
			return "HAPPY\nENDING"
		}
	}
}