//
//  RouteHistory.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Foundation
import CoreLocation

struct RouteHistory {
	let timestamp: NSDate
	let location: CLLocation
	let recoginzedName: String?
	let milesToNext: Double?

	func fetchAddress(closure: (address: String) -> ()) {
		closure(address: "\(location.coordinate.latitude), \(location.coordinate.longitude)")
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
				closure(address: string)
			}
		}
	}
}