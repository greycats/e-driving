//
//  Mechanic.swift
//  e-driving
//
//  Created by Rex Sheng on 3/3/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

struct Mechanic: Equatable {
	let name: String
	let address: String
	let miles: Double
}
func ==(lhs: Mechanic, rhs: Mechanic) -> Bool {
	return lhs.name == rhs.name
}

extension Mechanic {
	static var demoMechanics = [
		Mechanic(name: "CYNTHIA'S AUTO", address: "698 East Blvd, Odessa, NC", miles: 8),
		Mechanic(name: "WANDA'S AUTO", address: "647 12th Ct, Fremont, GA", miles: 15),
		Mechanic(name: "Beverly's Dojo", address: "950 Oak Ave, Fairfie, SC", miles: 18),
		Mechanic(name: "Patrick's Supplies", address: "1330 Forest Dr, Cleveland, AL", miles: 21)
	]
}