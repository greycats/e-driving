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
		hoursItem?.title = AchieveName.Hours
		hoursItem?.isLight = getHours
	}
	
	@IBOutlet weak var happyItem: AchieveItem! {
		didSet { renderHappy() }
	}
	@IBInspectable var getHappy: Bool = false {
		didSet { renderHappy() }
	}
	private func renderHappy() {
		happyItem?.title = AchieveName.Happy
		happyItem?.isLight = getHappy
	}
	
	@IBOutlet weak var slowItem: AchieveItem! {
		didSet { renderSlow() }
	}
	@IBInspectable var getSlow: Bool = true {
		didSet { renderSlow() }
	}
	private func renderSlow() {
		slowItem?.title = AchieveName.Slow
		slowItem?.isLight = getSlow
	}
	
	@IBOutlet weak var ticketItem: AchieveItem! {
		didSet { renderTicket() }
	}
	@IBInspectable var getTicket: Bool = false {
		didSet { renderTicket() }
	}
	private func renderTicket() {
		ticketItem?.title = AchieveName.Ticket
		ticketItem?.isLight = getTicket
	}
	
	@IBOutlet weak var driftItem: AchieveItem! {
		didSet { renderDrift() }
	}
	@IBInspectable var getDrift: Bool = false {
		didSet { renderDrift() }
	}
	private func renderDrift() {
		driftItem?.title = AchieveName.Drift
		driftItem?.isLight = getDrift
	}
	
	@IBOutlet weak var notDrunkItem: AchieveItem! {
		didSet { renderNotDrunk() }
	}
	@IBInspectable var getNotDrunk: Bool = false {
		didSet { renderNotDrunk() }
	}
	private func renderNotDrunk() {
		notDrunkItem?.title = AchieveName.NotDrunk
		notDrunkItem?.isLight = getNotDrunk
	}
	
	@IBOutlet weak var routeItem: AchieveItem! {
		didSet { renderRoute() }
	}
	@IBInspectable var getRoute: Bool = false {
		didSet { renderRoute() }
	}
	private func renderRoute() {
		routeItem?.title = AchieveName.Route
		routeItem?.isLight = getRoute
	}
	
	@IBOutlet weak var safeItem: AchieveItem! {
		didSet { renderSafe() }
	}
	@IBInspectable var getSafe: Bool = true {
		didSet { renderSafe() }
	}
	private func renderSafe() {
		safeItem?.title = AchieveName.Safe
		safeItem?.isLight = getSafe
	}
	
	@IBOutlet weak var speedItem: AchieveItem! {
		didSet { renderSpeed() }
	}
	@IBInspectable var getSpeed: Bool = false {
		didSet { renderSpeed() }
	}
	private func renderSpeed() {
		speedItem?.title = AchieveName.Speed
		speedItem?.isLight = getSpeed
	}
}