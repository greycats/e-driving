//
//  DateTicker.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

private let cal = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
enum DateBasis {
	case Weekly
	case Monthly
	case Yearly

	func next(date: NSDate, options: NSCalendarOptions = [.MatchNextTime]) -> NSDate {
		switch self {
		case .Weekly:
			let week = cal.component(.Weekday, fromDate: date)
			return cal.nextDateAfterDate(date, matchingUnit: .Weekday, value: week, options: options)!
		case .Monthly:
			let day = cal.component(.Day, fromDate: date)
			return cal.nextDateAfterDate(date, matchingUnit: .Day, value: day, options: options)!
		case .Yearly:
			let compo = cal.components([.Month, .Day], fromDate: date)
			return cal.nextDateAfterDate(date, matchingComponents: compo, options: options)!
		}
	}

	func previous(date: NSDate) -> NSDate {
		return next(date, options: [.SearchBackwards, .MatchNextTime])
	}

	func formatDate(date: NSDate) -> String {
		let formatter: Formatter
		switch self {
		case .Weekly:
			formatter = WeeklyFormat
		case .Monthly:
			formatter = MonthlyFormat
		case .Yearly:
			formatter = YearlyFormat
		}
		return formatter.format(date)
	}
}

@IBDesignable
class DateTicker: NibView {

	var basis: DateBasis = .Weekly
	var date: NSDate! = NSDate() {
		didSet {
			print(date)
			dateLabel.text = basis.formatDate(date)
			onDateChange?(date)
		}
	}

	var onDateChange: ((NSDate) -> ())?
	
	@IBOutlet weak var dateLabel: UILabel!

	@IBAction func tapLeft(sender: UIControl) {
		date = basis.previous(date)
	}

	@IBAction func tapRight(sender: UIControl) {
		date = basis.next(date)
	}
}