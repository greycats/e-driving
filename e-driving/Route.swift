//
//  Traceroute.swift
//  e-driving
//
//  Created by Rex Sheng on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats
import CoreLocation

struct RouteHistory {
	let timestamp: NSDate
	let location: CLLocation
	let recoginzedName: String?
	let milesToNext: Double?
}

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

class RouteView: UIView {
	var route: [RouteHistory] = [] {
		didSet {
			renderRoute()
		}
	}

	func renderRoute() {
		var g = route.generate()
		var point: RouteHistory? = g.next()
		var line: DashLine!
		while let p = point {
			let newLine = injectRouteHistory(p)
			if let previous = line {
				addConstraint(NSLayoutConstraint(item: newLine, attribute: .Top, relatedBy: .Equal, toItem: previous, attribute: .Bottom, multiplier: 1, constant: 0))
			} else {
				addConstraint(NSLayoutConstraint(item: newLine, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0))
			}
			line = newLine
			let nextPoint = g.next()
			if let _ = nextPoint {
				let height: CGFloat = p.milesToNext > 0 ? 86 : 67
				addConstraint(NSLayoutConstraint(item: line, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0, constant: height))
			} else {
				line.hasLine = false
			}
			point = nextPoint
		}
		if let line = line {
			addConstraint(NSLayoutConstraint(item: line, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
		}
	}

	func injectRouteHistory(history: RouteHistory) -> DashLine {
		let line = DashLine()
		line.opaque = false
		line.translatesAutoresizingMaskIntoConstraints = false
		addSubview(line)
		addConstraint(NSLayoutConstraint(item: line, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 106))
		addConstraint(NSLayoutConstraint(item: line, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0, constant: 16))
		let label = PositionLabel()
		label.layout = "Compact"
		label.translatesAutoresizingMaskIntoConstraints = false
		addSubview(label)
		let time = RouteTime.format(history.timestamp)
		if let placeName = history.recoginzedName?.uppercaseString {
			label.title = "\(time) - \(placeName)"
		} else {
			label.title = time
		}
		print("adding", label.title)
		fetchAddress(history.location, label: label)
		addConstraint(NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: line, attribute: .Top, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: label, attribute: .Bottom, relatedBy: .Equal, toItem: line, attribute: .Bottom, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: label, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: label, attribute: .Leading, relatedBy: .Equal, toItem: line, attribute: .Trailing, multiplier: 1, constant: 12.5))
		if let miles = history.milesToNext {
			let view = MilesView()
			view.translatesAutoresizingMaskIntoConstraints = false
			addSubview(view)
			view.miles = miles
			addConstraint(NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 25))
			addConstraint(NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: line, attribute: .CenterY, multiplier: 1, constant: 0))
		}
		return line
	}

	func fetchAddress(location: CLLocation, label: PositionLabel) {
		label.address = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
		CLGeocoder().reverseGeocodeLocation(location) { (marks, error) in
			if let mark = marks?.first {
				var string = ""
				var hasStreet = false
				if let subThoroughfare = mark.subThoroughfare {
					string += subThoroughfare
					hasStreet = true
				}
				if let thoroughfare = mark.thoroughfare {
					if hasStreet {
						string += " "
					}
					string += thoroughfare
					hasStreet = true
				}
				if let subAdministrativeArea = mark.subAdministrativeArea {
					if hasStreet {
						string += ", "
					}
					string += subAdministrativeArea
				}
				if let administrativeArea = mark.administrativeArea {
					if hasStreet {
						string += ", "
					}
					string += administrativeArea
				}
				label.address = string
			}
		}
	}
}
