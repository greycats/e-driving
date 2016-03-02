//
//  DateTicker.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

let Calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
enum DateBasis {
	case Weekly
	case Monthly
	case Yearly

	func next(date: NSDate, options: NSCalendarOptions = [.MatchNextTime]) -> NSDate {
		switch self {
		case .Weekly:
			let week = Calendar.component(.Weekday, fromDate: date)
			return Calendar.nextDateAfterDate(date, matchingUnit: .Weekday, value: week, options: options)!
		case .Monthly:
			let day = Calendar.component(.Day, fromDate: date)
			return Calendar.nextDateAfterDate(date, matchingUnit: .Day, value: day, options: options)!
		case .Yearly:
			let compo = Calendar.components([.Month, .Day], fromDate: date)
			return Calendar.nextDateAfterDate(date, matchingComponents: compo, options: options)!
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
class DateTicker: NibView, ColorPalette {

	@IBOutlet weak var leftArrow: Arrow!
	@IBOutlet weak var rightArrow: Arrow!
	@IBOutlet weak var dateLabel: UILabel!

	var basis: DateBasis = .Weekly
	private var _date: NSDate!
	var date: NSDate! {
		get { return _date }
		set(value) {
			if let _ = try? onDateChange?(value) {
				dateLabel.text = basis.formatDate(value)
				_date = value
			}
		}
	}

	var onDateChange: ((NSDate) throws -> ())?

	@IBAction func tapLeft(sender: UIControl) {
		date = basis.previous(date)
	}

	@IBAction func tapRight(sender: UIControl) {
		date = basis.next(date)
	}

	func setColor(color: UIColor, category: ColorCategory) {
		leftArrow.setColor(color, category: category)
		rightArrow.setColor(color, category: category)
		switch category {
		case .MainText:
			dateLabel.textColor = color
		default:
			break
		}
	}
}