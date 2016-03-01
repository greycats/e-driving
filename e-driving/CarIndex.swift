//
//  CarIndex.swift
//  e-driving
//
//  Created by Rex Sheng on 3/1/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import UIKit

enum CarIndexState {
	case Normal
	case Alert
	case Good
	case Nice
}

struct CarIndex {
	let title: String
	let value: Double
	let state: CarIndexState
	let highlight: Bool
	init(title: String, value: Double, state: CarIndexState = .Normal, highlight: Bool = false) {
		self.title = title
		self.value = value
		self.state = state
		self.highlight = highlight
	}
}

extension UIView {
	func stack(index: CarIndex...) -> [IndexLabel] {
		let labels = index.map { _ in IndexLabel() }
		horizontalStack(labels, marginX: 13, equalWidth: false)
		labels.apply(index)
		return labels
	}
	func stack(times times: Int) -> [IndexLabel] {
		let labels = (0..<times).map { _ in IndexLabel() }
		horizontalStack(labels, marginX: 13, equalWidth: false)
		labels.forEach { $0.applyTheme(.Dark) }
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