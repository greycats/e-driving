//
//  Achievement.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Foundation

public struct AchieveName: OptionSetType {
	public let rawValue: UInt
	init(_ value: UInt = 0) { rawValue = value }
	public init(rawValue value: UInt) { rawValue = value }
	public static let Hours = AchieveName(0)
	public static let Happy = AchieveName(0x001)
	public static let Slow = AchieveName(0x002)
	public static let Ticket = AchieveName(0x004)
	public static let Drift = AchieveName(0x008)
	public static let NotDrunk = AchieveName(0x010)
	public static let Route = AchieveName(0x020)
	public static let Safe = AchieveName(0x040)
	public static let Speed = AchieveName(0x080)
}