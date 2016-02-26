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
	let place: CLPlacemark
	let recoginzedName: String?
	let milesToNext: Double?

}

func createRoute() {
	CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: 37.662438, longitude: -122.424233)) { (marks, error) in
		if let mark = marks?.first {
			print("\(mark.subThoroughfare) \(mark.thoroughfare), \(mark.subAdministrativeArea), \(mark.administrativeArea)")
		}
	}
}

class TracerouteView: UIView {
}
