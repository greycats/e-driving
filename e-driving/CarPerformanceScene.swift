//
//  CarPerformanceScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class CarPerformanceViewController: UIViewController, ColorPalette, Overlayed {
	@IBOutlet weak var vehicleView: VehicleView!
	@IBOutlet weak var findMechanic: ButtonView!
	@IBOutlet weak var indicesView: UIView!
	@IBOutlet var indices: [IndexLabel]!
	@IBOutlet weak var driverImage: UIImageView!
	@IBOutlet weak var driverName: UILabel!
	@IBOutlet weak var milesView: MilesView!
	@IBOutlet weak var mechanicsTableView: UITableView!
	
	var mechanicsArray: [MechanicInfo] = []

	@IBOutlet weak var alertsView: UIView!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		applyTheme(.Dark)
		let alerts = [
			CarAlert(reason: .LowOil, error: "change in 20 miles", suggestion: "Needs Replacement"),
			CarAlert(reason: .LowGas, error: "20 miles left", suggestion: "Find Nearest Station"),
			CarAlert(reason: .EngineCheck, error: "20 miles left", suggestion: "Engine Maintenance")
		]
		let views = alerts.map { AlertInfoView(alert: $0) }
		alertsView |< views
		
		indices.apply([
			CarIndex(title: "BRAND", value: "BMW"),
			CarIndex(title: "MODEL", value: "320i"),
			CarIndex(title: "YEAR", value: "2013"),
			CarIndex(title: "MILES", value: "3200"),
			CarIndex(title: "LAST DAY SERVICE", value: "JAN 15, 2016", state: .AlertBefore)
			])
		for subview in indicesView.subviews {
			if let subview = subview as? ColorPalette {
				subview.applyTheme(.Dark)
			}
		}
		
		driverImage.image = UIImage(named: "LocNgo")
		driverName.text = "Loc Ngo"
		milesView.miles = 8.5
		
		mechanicsArray = [MechanicInfo(name: "CYNTHIA'S AUTO", address: "698 East Blvd, Odessa, NC", miles: 8),
		MechanicInfo(name: "WANDA'S AUTO", address: "647 12th Ct, Fremont, GA", miles: 15),
		MechanicInfo(name: "Beverly's Dojo", address: "950 Oak Ave, Fairfie, SC", miles: 18),
		MechanicInfo(name: "Patrick's Supplies", address: "1330 Forest Dr, Cleveland, AL", miles: 21)]
		
		mechanicsTableView.registerNib(UINib(nibName: "MechanicCell", bundle: nil), forCellReuseIdentifier: "MechanicCell")
	}
	
	
	// MARK: - tableview
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return mechanicsArray.count
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 80
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("MechanicCell", forIndexPath: indexPath) as! MechanicCell
		cell.nameLabel.text = mechanicsArray[indexPath.row].name 
		cell.addressLabel.text = mechanicsArray[indexPath.row].address 
		cell.miles.text = String(mechanicsArray[indexPath.row].miles)
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
}


struct MechanicInfo {
	let name: String
	let address: String
	let miles: Double
}