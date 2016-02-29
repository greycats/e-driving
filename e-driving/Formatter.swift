//
//  Formatter.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Foundation

struct Formatter {
	let format: NSDate -> String
	let parse: String -> NSDate?

	private static func create(format: String, fixTimeZone: Bool = false, ignoreLocale: Bool = true) -> Formatter {
		let formatter = NSDateFormatter()
		formatter.AMSymbol = "AM"
		formatter.PMSymbol = "PM"
		if fixTimeZone {
			if let timeZone = NSTimeZone(name: "America/Los_Angeles") {
				formatter.timeZone = timeZone
			}
		}
		if ignoreLocale {
			formatter.locale = NSLocale(localeIdentifier: "en_US")
		}

		formatter.dateFormat = format
		return Formatter(format: { formatter.stringFromDate($0) }, parse: { formatter.dateFromString($0) })
	}
}

let RouteTime = Formatter.create("h:mm a")
let WeeklyFormat = Formatter.create("'Week' W, MMMM")
let MonthlyFormat = Formatter.create("MMMM y")
let YearlyFormat = Formatter.create("y")