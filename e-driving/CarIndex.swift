//
//  CarIndex.swift
//  e-driving
//
//  Created by Rex Sheng on 3/1/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import UIKit

enum Position {
	case Left
	case TopRight
}
enum CarIndexState {
	case Normal
	case Alert(Position)
	case Good
	case Nice
}
protocol CarIndexValue {
	var indexString: String? { get }
}
struct CarIndex {
	let title: String
	var value: CarIndexValue
	let state: CarIndexState
	let highlight: Bool
	init<T: CarIndexValue>(title: String, value: T, state: CarIndexState = .Normal, highlight: Bool = false) {
		self.title = title
		self.value = value
		self.state = state
		self.highlight = highlight
	}
	var indexString: String? { return value.indexString }
}

extension String: CarIndexValue {
	var indexString: String? { return self }
}
extension Double: CarIndexValue {
	var indexString: String? {
		let formatter = NSNumberFormatter()
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 1
		formatter.groupingSeparator = ","
		formatter.groupingSize = 3
		formatter.usesGroupingSeparator = true
		return formatter.stringFromNumber(self)
	}
}
extension NSDate: CarIndexValue {
	var indexString: String? {
		return IndexFormat.format(self)
	}
}

extension UIView {
	func stack(times times: Int) -> [IndexLabel] {
		let labels = (0..<times).map { _ in IndexLabel() }
		horizontalStack(labels, marginX: 13, equalWidth: false)
		return labels
	}
}

extension CollectionType where Generator.Element == IndexLabel, Index == Int {
	func apply(index: [CarIndex]) {
		index.enumerate().forEach { i, index in
			self[i].index = index
		}
	}
}