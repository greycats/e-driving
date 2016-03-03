//
//  AlertInfoView.swift
//  e-driving
//
//  Created by Rex Sheng on 3/2/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

struct CarAlert {
	enum Reason {
		case LowOil
		case LowGas
		case EngineCheck
	}
	let reason: Reason
	let error: String
	let suggestion: String
}

class AlertInfoView: NibView {
	@IBOutlet weak var reasonLabel: UILabel!
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var suggestionLabel: UILabel!
	@IBOutlet weak var icon: UIImageView!

	convenience init(alert: CarAlert) {
		self.init(frame: .zero)
		let name = String(alert.reason)
		icon.image = UIImage(named: name.cc_snakecaseString)
		reasonLabel.text = name.cc_capitalizedString
		errorLabel.text = alert.error.uppercaseString
		suggestionLabel.text = alert.suggestion.capitalizedString
	}
}

