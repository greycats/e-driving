//
//  Traceroute.swift
//  e-driving
//
//  Created by Rex Sheng on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class RouteView: UIView {
	var route: [RouteHistory] = [] {
		didSet {
			renderRoute()
		}
	}

	var displayMiles: Bool = true

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
				if displayMiles {
					let height: CGFloat = p.milesToNext > 0 ? 86 : 67
					addConstraint(NSLayoutConstraint(item: line, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0, constant: height))
				}
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
		if displayMiles {
		addConstraint(NSLayoutConstraint(item: line, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 0.55, constant: 0))
		} else {
			addConstraint(NSLayoutConstraint(item: line, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 13))
		}
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
		history.fetchAddress { label.address = $0 }
		addConstraint(NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: line, attribute: .Top, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: label, attribute: .Bottom, relatedBy: .Equal, toItem: line, attribute: .Bottom, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: label, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: label, attribute: .Leading, relatedBy: .Equal, toItem: line, attribute: .Trailing, multiplier: 1, constant: displayMiles ? 25 : 31))
		if let miles = history.milesToNext where displayMiles {
			let view = MilesView()
			view.translatesAutoresizingMaskIntoConstraints = false
			addSubview(view)
			view.miles = miles
			addConstraint(NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0))
			addConstraint(NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: line, attribute: .Leading, multiplier: 1, constant: 0))
			addConstraint(NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: line, attribute: .CenterY, multiplier: 1, constant: 7))
		} else {
			line.hasLine = false
		}
		return line
	}
}