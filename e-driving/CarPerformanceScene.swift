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
			nameLabel.text = mechanic.name.uppercaseString
			addressLabel.text = mechanic.address
			let formatter = NSNumberFormatter()
			formatter.minimumFractionDigits = 0
			formatter.maximumFractionDigits = 1
			formatter.groupingSize = 3
			formatter.usesGroupingSeparator = true
			miles.text = "\(formatter.stringFromNumber(mechanic.miles)!) Miles"
		}
	}
}

class PerformanceView: NibView, ColorPalette {
	@IBOutlet weak var vehicleView: VehicleView!
	@IBOutlet weak var findButton: ButtonView!
	@IBOutlet weak var alertsView: UIView!

	var alerts: [CarAlert] = [] {
		didSet {
			let views = alerts.map { AlertInfoView(alert: $0) }
			alertsView |< views
		}
	}
}

class CarInfoView: NibView, ColorPalette {
	@IBOutlet weak var driverImage: UIImageView!
	@IBOutlet weak var driverName: UILabel!
	@IBOutlet weak var milesView: MilesView!
	@IBOutlet weak var indicesView: UIView!
	@IBOutlet var indices: [IndexLabel]!
	func apply(indices: CarIndex...) {
		self.indices.apply(indices)
	}
}

class MechanicHeader: NibView {
	@IBOutlet weak var label: UILabel!

	convenience init(text: String) {
		self.init()
		backgroundColor = UIColor.whiteColor()
		label.text = text.uppercaseString
	}
}

class CarPerformanceViewController: UIViewController, ColorPalette {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var performanceView: PerformanceView!
	@IBOutlet weak var infoView: CarInfoView!
	@IBOutlet weak var headerView: UIView!

	@IBOutlet weak var map: UIImageView!
	let mechanics = TableViewDataNib<MechanicInfo, MechanicCell>(title: "nearest machanics")
		.onRender { $0.mechanic = $1 }
		.onHeader { MechanicHeader(text: $0) }

	override func viewDidLoad() {
		super.viewDidLoad()
		let size = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
		tableView.tableHeaderView = headerView
		tableView.tableHeaderView?.frame = CGRect(origin: .zero, size: size)
		let alerts = [
			CarAlert(reason: .LowOil, error: "change in 20 miles", suggestion: "Needs Replacement"),
			CarAlert(reason: .LowGas, error: "20 miles left", suggestion: "Find Nearest Station"),
			CarAlert(reason: .EngineCheck, error: "20 miles left", suggestion: "Engine Maintenance")
		]
		performanceView.alerts = alerts
		infoView.apply(
			CarIndex(title: "BRAND", value: "BMW"),
			CarIndex(title: "MODEL", value: "320i"),
			CarIndex(title: "YEAR", value: "2013"),
			CarIndex(title: "MILES", value: 3200),
			CarIndex(title: "LAST DAY SERVICE", value: NSDate(), state: .Alert(.Left))
			)
		infoView.driverImage.image = UIImage(named: "LocNgo")
		infoView.driverName.text = "Loc Ngo"
		infoView.milesView.miles = 8.5

		mechanics.source = [
			MechanicInfo(name: "CYNTHIA'S AUTO", address: "698 East Blvd, Odessa, NC", miles: 8),
			MechanicInfo(name: "WANDA'S AUTO", address: "647 12th Ct, Fremont, GA", miles: 15),
			MechanicInfo(name: "Beverly's Dojo", address: "950 Oak Ave, Fairfie, SC", miles: 18),
			MechanicInfo(name: "Patrick's Supplies", address: "1330 Forest Dr, Cleveland, AL", miles: 21)
		]
		connectTableView(tableView, sections: [mechanics])
		performanceView.findButton.buttonView.addTarget(self, action: "findAMechanic", forControlEvents: .TouchUpInside)
	}

	func findAMechanic() {
		tableView.scrollRectToVisible(tableView.frame, animated: true)
	}
}