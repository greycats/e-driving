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
	@IBOutlet weak var hoursItem: AchieveItem! {
	didSet { renderHours() }
	}
	@IBInspectable var getHours: Bool = false {
		didSet { renderHours() }
	}
	private func renderHours() {
		hoursItem?.title = "Hours"
		hoursItem?.isLight = getHours
	}
	
	@IBOutlet weak var happyItem: AchieveItem! {
		didSet { renderHappy() }
	}
	@IBInspectable var getHappy: Bool = false {
		didSet { renderHappy() }
	}
	private func renderHappy() {
		happyItem?.title = "Happy"
		happyItem?.isLight = getHappy
	}
	
	@IBOutlet weak var slowItem: AchieveItem! {
		didSet { renderSlow() }
	}
	@IBInspectable var getSlow: Bool = true {
		didSet { renderSlow() }
	}
	private func renderSlow() {
		slowItem?.title = "Slow"
		slowItem?.isLight = getSlow
	}
	
	@IBOutlet weak var ticketItem: AchieveItem! {
		didSet { renderTicket() }
	}
	@IBInspectable var getTicket: Bool = false {
		didSet { renderTicket() }
	}
	private func renderTicket() {
		ticketItem?.title = "Ticket"
		ticketItem?.isLight = getTicket
	}
	
	@IBOutlet weak var driftItem: AchieveItem! {
		didSet { renderDrift() }
	}
	@IBInspectable var getDrift: Bool = false {
		didSet { renderDrift() }
	}
	private func renderDrift() {
		driftItem?.title = "Drift"
		driftItem?.isLight = getDrift
	}
	
	@IBOutlet weak var notDrunkItem: AchieveItem! {
		didSet { renderNotDrunk() }
	}
	@IBInspectable var getNotDrunk: Bool = false {
		didSet { renderNotDrunk() }
	}
	private func renderNotDrunk() {
		notDrunkItem?.title = "NotDrunk"
		notDrunkItem?.isLight = getNotDrunk
	}
	
	@IBOutlet weak var routeItem: AchieveItem! {
		didSet { renderRoute() }
	}
	@IBInspectable var getRoute: Bool = false {
		didSet { renderRoute() }
	}
	private func renderRoute() {
		routeItem?.title = "Route"
		routeItem?.isLight = getRoute
	}
	
	@IBOutlet weak var safeItem: AchieveItem! {
		didSet { renderSafe() }
	}
	@IBInspectable var getSafe: Bool = true {
		didSet { renderSafe() }
	}
	private func renderSafe() {
		safeItem?.title = "Safe"
		safeItem?.isLight = getSafe
	}
	
	@IBOutlet weak var speedItem: AchieveItem! {
		didSet { renderSpeed() }
	}
	@IBInspectable var getSpeed: Bool = false {
		didSet { renderSpeed() }
	}
	private func renderSpeed() {
		speedItem?.title = "Speed"
		speedItem?.isLight = getSpeed
	}
	
}