//
//  CarPerformanceScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/29/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import UIKit

class CarPerformanceViewController: UIViewController, ColorPalette, Overlayed {
	@IBOutlet weak var vehicleView: VehicleView!
	@IBOutlet weak var findMechanic: ButtonView!
	@IBOutlet weak var indicesView: UIView!
	@IBOutlet var indices: [IndexLabel]!
	@IBOutlet weak var driverImage: UIImageView!
	@IBOutlet weak var driverName: UILabel!
	@IBOutlet weak var milesView: MilesView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		applyTheme(.Dark)
		
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
	}
}