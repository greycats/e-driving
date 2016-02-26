//
//  AchieveView.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class AchieveView: NibView {
	@IBOutlet weak var HoursItem: AchieveItem! {
	didSet { renderHours() }
	}
	@IBInspectable var getHours: Bool = false {
		didSet { renderHours() }
	}
	private func renderHours() {
		HoursItem?.title = "Hours"
		HoursItem?.isLight = getHours
	}
	
	@IBOutlet weak var HappyItem: AchieveItem! {
		didSet { renderHappy() }
	}
	@IBInspectable var getHappy: Bool = false {
		didSet { renderHappy() }
	}
	private func renderHappy() {
		HappyItem?.title = "Happy"
		HappyItem?.isLight = getHappy
	}
	
	@IBOutlet weak var SlowItem: AchieveItem! {
		didSet { renderSlow() }
	}
	@IBInspectable var getSlow: Bool = true {
		didSet { renderSlow() }
	}
	private func renderSlow() {
		SlowItem?.title = "Slow"
		SlowItem?.isLight = getSlow
	}
	
	@IBOutlet weak var TicketItem: AchieveItem! {
		didSet { renderTicket() }
	}
	@IBInspectable var getTicket: Bool = false {
		didSet { renderTicket() }
	}
	private func renderTicket() {
		TicketItem?.title = "Ticket"
		TicketItem?.isLight = getTicket
	}
	
	@IBOutlet weak var DriftItem: AchieveItem! {
		didSet { renderDrift() }
	}
	@IBInspectable var getDrift: Bool = false {
		didSet { renderDrift() }
	}
	private func renderDrift() {
		DriftItem?.title = "Drift"
		DriftItem?.isLight = getDrift
	}
	
	@IBOutlet weak var NotDrunkItem: AchieveItem! {
		didSet { renderNotDrunk() }
	}
	@IBInspectable var getNotDrunk: Bool = false {
		didSet { renderNotDrunk() }
	}
	private func renderNotDrunk() {
		NotDrunkItem?.title = "NotDrunk"
		NotDrunkItem?.isLight = getNotDrunk
	}
	
	@IBOutlet weak var RouteItem: AchieveItem! {
		didSet { renderRoute() }
	}
	@IBInspectable var getRoute: Bool = false {
		didSet { renderRoute() }
	}
	private func renderRoute() {
		RouteItem?.title = "Route"
		RouteItem?.isLight = getRoute
	}
	
	@IBOutlet weak var SafeItem: AchieveItem! {
		didSet { renderSafe() }
	}
	@IBInspectable var getSafe: Bool = true {
		didSet { renderSafe() }
	}
	private func renderSafe() {
		SafeItem?.title = "Safe"
		SafeItem?.isLight = getSafe
	}
	
	@IBOutlet weak var SpeedItem: AchieveItem! {
		didSet { renderSpeed() }
	}
	@IBInspectable var getSpeed: Bool = false {
		didSet { renderSpeed() }
	}
	private func renderSpeed() {
		SpeedItem?.title = "Speed"
		SpeedItem?.isLight = getSpeed
	}
	
}