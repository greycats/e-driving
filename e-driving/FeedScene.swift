//
//  FeedScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats
import CoreLocation

private func gen_line(count: Int) -> [CGFloat] {
	srand48(Int(arc4random()))
	return (0..<count).map { _ in CGFloat(drand48()) }
}

class FeedViewController: UIViewController, ColorPalette {
	@IBOutlet weak var routeView: RouteView!
	@IBOutlet weak var dateTicker: DateTicker!
	@IBOutlet weak var achievementsView: AchievementsView!
	@IBOutlet weak var weekActivity: WeekActivity!

	override func viewDidLoad() {
		routeView.route = [
			RouteHistory(timestamp: NSDate(), location: CLLocation(latitude: 37.662438, longitude: -122.424233), recoginzedName: "Home", milesToNext: 6),
			RouteHistory(timestamp: NSDate(), location: CLLocation(latitude: 37.666325, longitude: -122.433674), recoginzedName: nil, milesToNext: nil),
			RouteHistory(timestamp: NSDate(), location: CLLocation(latitude: 37.666325, longitude: -122.433674), recoginzedName: nil, milesToNext: 6),
			RouteHistory(timestamp: NSDate(), location: CLLocation(latitude: 37.662438, longitude: -122.424233), recoginzedName: "Home", milesToNext: nil),
		]

		dateTicker.date = NSDate()
		achievementsView.achievements = [.PerfectDriver, .SafetyLevel(2), .CalmnessLevel(2)]
		dateTicker.onDateChange = {[weak self] day in
			try self?.weekActivity.setDay(day)
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		weekActivity.addFriendLine(gen_line(100), avatar: UIImage(named: "avatar0"))
		weekActivity.addFriendLine(gen_line(100), avatar: UIImage(named: "avatar1"))
		weekActivity.addSelfLine(gen_line(100), avatar: UIImage(named: "avatar2"))
	}
}