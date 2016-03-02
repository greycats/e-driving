//
//  CarPerformanceScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

struct MechanicInfo: Equatable {
	let name: String
	let address: String
	let miles: Double
}
func ==(lhs: MechanicInfo, rhs: MechanicInfo) -> Bool {
	return lhs.name == rhs.name
}

class MechanicCell: UITableViewCell, TableViewDataNibCell {
	static var nibName = "MechanicCell"
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var miles: UILabel!

	var mechanic: MechanicInfo! {
		didSet {
			nameLabel.text = mechanic.name
			addressLabel.text = mechanic.address
			miles.text = "\(mechanic.miles) Miles"
		}
	}
}

class CarPerformanceViewController: UIViewController, ColorPalette, Overlayed {
	@IBOutlet weak var vehicleView: VehicleView!
	@IBOutlet weak var findMechanic: ButtonView!
	@IBOutlet weak var indicesView: UIView!
	@IBOutlet var indices: [IndexLabel]!
	@IBOutlet weak var driverImage: UIImageView!
	@IBOutlet weak var driverName: UILabel!
	@IBOutlet weak var milesView: MilesView!
	@IBOutlet weak var mechanicsTableView: UITableView!
	@IBOutlet weak var alertsView: UIView!
	let mechanics = TableViewDataNib<MechanicInfo, MechanicCell>(title: nil)
		.onRender { $0.mechanic = $1 }

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

		mechanics.source = [
			MechanicInfo(name: "CYNTHIA'S AUTO", address: "698 East Blvd, Odessa, NC", miles: 8),
			MechanicInfo(name: "WANDA'S AUTO", address: "647 12th Ct, Fremont, GA", miles: 15),
			MechanicInfo(name: "Beverly's Dojo", address: "950 Oak Ave, Fairfie, SC", miles: 18),
			MechanicInfo(name: "Patrick's Supplies", address: "1330 Forest Dr, Cleveland, AL", miles: 21)
		]

		connectTableView(mechanicsTableView, sections: [mechanics])
		mechanicsTableView.tableFooterView = UIView()
	}
}