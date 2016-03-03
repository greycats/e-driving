//
//  CarPerformanceScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class MechanicCell: UITableViewCell, TableViewDataNibCell {
	static var nibName = "MechanicCell"
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var miles: UILabel!

	var mechanic: Mechanic! {
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
	@IBOutlet weak var issuesView: UIView!

	var issues: [CarIssue] = [] {
		didSet {
			issuesView |< issues.map { CarIssueView(issue: $0) }
		}
	}
}

class CarInfoView: NibView, ColorPalette {
	@IBOutlet weak var driverImage: UIImageView!
	@IBOutlet weak var driverName: UILabel!
	@IBOutlet weak var milesView: MilesView!
	@IBOutlet weak var indicesView: UIView!
	@IBOutlet var indices: [IndexLabel]!

	var carInfo: CarInfo! {
		didSet {
			indices.apply([
				CarIndex(title: "BRAND", value: carInfo.brand),
				CarIndex(title: "MODEL", value: carInfo.model),
				CarIndex(title: "YEAR", value: carInfo.year),
				CarIndex(title: "MILES", value: carInfo.miles),
				CarIndex(title: "LAST DAY SERVICE", value: carInfo.lastTimeService, state: .Alert(.Left))
				])
			driverImage.image = carInfo.driverAvatar
			driverName.text = carInfo.driverName
			milesView.miles = carInfo.rank
		}
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
	let mechanics = TableViewDataNib<Mechanic, MechanicCell>(title: "nearest machanics")
		.onRender { $0.mechanic = $1 }
		.onHeader { MechanicHeader(text: $0) }

	override func viewDidLoad() {
		super.viewDidLoad()
		let size = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
		tableView.tableHeaderView = headerView
		tableView.tableHeaderView?.frame = CGRect(origin: .zero, size: size)
		performanceView.issues = CarIssue.demoIssues
		infoView.carInfo = CarInfo.demo
		mechanics.source = Mechanic.demoMechanics
		connectTableView(tableView, sections: [mechanics])
		performanceView.findButton.onClick {[weak self] in
			self?.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: true)
		}
	}
}