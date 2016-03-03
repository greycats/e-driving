//
//  CarIssueView.swift
//  e-driving
//
//  Created by Rex Sheng on 3/2/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class CarIssueView: NibView, ColorPalette {
	@IBOutlet weak var reasonLabel: UILabel!
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var suggestionLabel: UILabel!
	@IBOutlet weak var icon: UIImageView!

	convenience init(issue: CarIssue) {
		self.init(frame: .zero)
		let name = String(issue.reason)
		icon.image = UIImage(named: name.cc_snakecaseString)
		reasonLabel.text = name.cc_capitalizedString
		errorLabel.text = issue.error.uppercaseString
		suggestionLabel.text = issue.suggestion.capitalizedString
	}

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .Alert:
			icon.tintColor = color
			reasonLabel.textColor = color
		case .MainText:
			errorLabel.textColor = color
			suggestionLabel.textColor = color
		default:
			break
		}
	}
}