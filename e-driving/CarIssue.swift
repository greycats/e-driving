//
//  CarIssue.swift
//  e-driving
//
//  Created by Rex Sheng on 3/3/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

struct CarIssue {
	enum Reason {
		case LowOil
		case LowGas
		case EngineCheck
	}
	let reason: Reason
	let error: String
	let suggestion: String
}

extension CarIssue {
	static var demoIssues =	[
		CarIssue(reason: .LowOil, error: "change in 20 miles", suggestion: "Needs Replacement"),
		CarIssue(reason: .LowGas, error: "20 miles left", suggestion: "Find Nearest Station"),
		CarIssue(reason: .EngineCheck, error: "20 miles left", suggestion: "Engine Maintenance")
	]
}